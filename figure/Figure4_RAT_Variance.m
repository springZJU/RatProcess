% clc; close all; clear
%% Parameter setting

% MATPATH = 'E:\ratNeuroPixel\matData\rat2\rat2_20220819\A4o6V0o6\clickTrainLongTermS2o3D1o76D3Rev76\data.mat';
% MATPATH{1} = 'E:\ratNeuroPixel\matData\ECoGRat1\ER320230130\ECoG2_RAT3\clickTrainLongTerm_Var_2_3\data.mat';
% MATPATH{2} = 'E:\ratNeuroPixel\matData\ECoGRat1\ER20221115\ECoG1\clickTrainLongTerm_Var_2_3\data.mat';

ROOTPATH = "E:\ratNeuroPixel\result\Figure0\";
doICA = false;
params.processFcn = @PassiveProcess_clickTrainContinuous;
fs = 500; % Hz, for downsampling

stimSelect = 1; % 2,4,6,8,10
stateStr = ["Aneasthetic", "Awake"];
% colorGrad = flip(["#000000", "#0000FF", "#00FF00", "#FFA500", "#FF0000"]);
colorGrad = flip(["#AAAAAA", "#000000", "#0000FF", "#00FF00", "#FFA500", "#FF0000"]);
cdrPlotIdx = flip([2, 4, 6, 8, 10, 12]);
colors = ["red", "black"];
yScale = [150, 80];
quantWin = [0 200];
sponWin = [-200 0];
CRIMethod = 2;
for mIndex = 1 : length(MATPATH)
    %% Processing
    temp = string(strsplit(MATPATH{mIndex}, "\"));
    DateStr = temp(5);
    posStr = temp(6);
    protocolStr = temp(7);
    FIGPATH = strcat(ROOTPATH, "\", protocolStr, "\", DateStr, "\", posStr, "\");
    SAVEPATH = strcat('E:\ratNeuroPixel\result\Figure\', DateStr, "\", posStr, "\", protocolStr, "\");
    if doICA
        SAVEPATH = strrep(SAVEPATH, "Figure", "ICAFigure");
    end
% 
%     if exist(FIGPATH, "dir")
%         continue
%     end

    [trialAll, lfpDataset, soundFold] = ratLfpProcess(MATPATH{mIndex}, params);
    if needCorrection(DateStr)
        lfpDataset.data = ChCorrection_RatECOG(lfpDataset.data);
    end
    lfpDataset = ECOGResample(lfpDataset, 500);
    lfpDatasetCopy = lfpDataset;
    if ~isempty(lfpDataset)
        fs0 = lfpDataset.fs;
    end

    run("loadDur.m");
    run("configWindowStr.m");

    trialAll([trialAll.devOrdr] == 0) = [];
    devType = unique([trialAll.devOrdr]);
    devTemp = {trialAll.devOnset}';
    [~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
    temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
    trialAll = addFieldToStruct(trialAll, temp, "devOnset");
    trialAll(1) = [];data_mean = [];data_se = [];


    [trialsTemp, ~, ~] = selectEcog(lfpDatasetCopy, trialAll, "dev onset", window); % "dev onset"; "trial onset"
    [trialsTempS1, ~, ~] = selectEcog(lfpDatasetCopy, trialAll, "trial onset", window); % "dev onset"; "trial onset"
    if doICA
        mkdir(SAVEPATH);

        ICAName = strcat(SAVEPATH, "IC_Comp",  ".mat");

        if ~exist(ICAName, "file")
            [comp, ICs, FigTopoICA, FigWave] = ICA_Population_RatRCOG(trialsTemp, fs0, window);
            compT = comp;
            compT.topo(:, ~ismember(1:size(compT.topo, 2), ICs)) = 0;
            trialsLFPTemp = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
            trialsLFPS1Temp = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTempS1, "UniformOutput", false);
            close(FigTopoICA);
            close(FigWave);
            save(ICAName, "compT", "comp", "ICs", "-mat");
        else
            load(ICAName);
            trialsLFPTemp = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
            trialsLFPS1Temp = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTempS1, "UniformOutput", false);
        end

    else
        trialsLFPTemp = trialsTemp;
        trialsLFPS1Temp = trialsTempS1;

    end

    [trialsLFP, ~, idx] = excludeTrialsChs(trialsLFPTemp, 0.03);
    trialsLFPS1 = trialsLFPS1Temp(idx);
    trialAll = trialAll(idx);
    %     trialsLFP = mECOGFilter(trialsLFP, 0.1, 50, 500);

    t = linspace(window(1), window(2), diff(window) /1000 * fs0 + 1)';

    for ch = 1 : 32
        cdrPlot(ch).(strcat(stateStr(mIndex), "info")) = strcat("Ch", num2str(ch));
        cdrPlot(ch).(strcat(stateStr(mIndex), "Wave")) = zeros(length(t), 2 * length(devType));
    end
    %%
    for dIndex = 1:length(devType)

        tIndex = [trialAll.devOrdr] == devType(dIndex);
        trials = trialsLFP(tIndex);
        % lfp
        chLfpMean{dIndex} = cell2mat(cellfun(@mean , changeCellRowNum(trials), 'UniformOutput', false));
        chStd = cell2mat(cellfun(@(x) std(x)/sqrt(length(tIndex)), changeCellRowNum(trials), 'UniformOutput', false));

        %             for ch = 1 : size(chLfpMean{dIndex}, 1)
        %                 cdrPlot(ch).(strcat(stateStr(mIndex), "Wave"))(:, cdrPlotIdx(dIndex) - 1) = t';
        %                 cdrPlot(ch).(strcat(stateStr(mIndex), "Wave"))(:, cdrPlotIdx(dIndex)) = chLfpMean{dIndex}(ch, :)';
        %             end

        % quantization amplitude
        [temp, amp, rmsSpon] = cellfun(@(x) waveAmp_Norm(x, window, quantWin, CRIMethod, sponWin), trials, 'UniformOutput', false);
        ampNorm(dIndex).(strcat(stateStr(mIndex), "_mean")) = cellfun(@mean, changeCellRowNum(temp));
        ampNorm(dIndex).(strcat(stateStr(mIndex), "_se")) = cellfun(@(x) std(x)/sqrt(length(x)), changeCellRowNum(temp));
        ampNorm(dIndex).(strcat(stateStr(mIndex), "_raw")) = changeCellRowNum(temp);
        ampNorm(dIndex).(strcat(stateStr(mIndex), "_amp")) = amp;
        ampNorm(dIndex).(strcat(stateStr(mIndex), "_rmsSpon")) = rmsSpon;

        data_mean = [data_mean,ampNorm(dIndex).(strcat(stateStr(mIndex), "_mean"))];data_se = [data_se,ampNorm(dIndex).(strcat(stateStr(mIndex), "_se"))];
        RegRatio(dIndex).chMean = chLfpMean{dIndex}; RegRatio(dIndex).color = colorGrad(dIndex);

    end
    meandata.chMean = data_mean;meandata.color = colorGrad(1);meandata.chSE = data_se;
    %% compare diff rawWave

    FigWave(1) = plotRawWaveMulti_RatECOG(RegRatio, window);
    scaleAxes(FigWave(1), "x", [-100, 600]);
    scaleAxes(FigWave(1), "y", "on");
    %     addLegend2Fig(FigWave(mIndex), stimStr);
    orderLine(FigWave(1), "LineStyle", "--", "bottom");
    AxesLegend = mSubplot(FigWave(1), 6, 6, 6, 1);
    set(AxesLegend, "Visible", "off");
    legendStr = cellstr(stimStr);
    legend(AxesLegend,flip(FigWave(1).Children(end).Children(1:end-1)), legendStr, "NumColumns", 1, "FontSize", 10);
    figname = char(protocolStr);
    mkdir(FIGPATH);
    print(FigWave(1), strcat(FIGPATH,  figname(20:end),'_Multi'), "-djpeg", "-r200");

    FigWave(2) = plotRawWaveMulti_RatECOG(meandata, [1 dIndex],stimStr);
    scaleAxes(FigWave(2), "x", [1 5]);
    scaleAxes(FigWave(2), "y", "on");

    if contains(protocolStr, "duration")
        titleStr= "Duration";
    elseif contains(protocolStr, "Var")
        titleStr = "Variance";
    elseif contains(protocolStr, "Ratio")
        titleStr = "Ratio";
    end
    set(FigWave(2),"Name",titleStr);
    print(FigWave(2), strcat(FIGPATH,  figname(20:end)), "-djpeg", "-r200");

    %
    %         %% significance of s1 onset response
    %         [temp, ampS1, rmsSponS1] = cellfun(@(x) waveAmp_Norm(x, window, quantWin, CRIMethod, sponWin), trialsLFPS1, 'UniformOutput', false);
    %         ampNormS1.(strcat(stateStr(mIndex), "_S1_mean")) = cellfun(@mean, changeCellRowNum(temp));
    %         ampNormS1.(strcat(stateStr(mIndex), "_S1_se")) = cellfun(@(x) std(x)/sqrt(length(x)), changeCellRowNum(temp));
    %         ampNormS1.(strcat(stateStr(mIndex), "_S1_raw")) = changeCellRowNum(temp);
    %         % compare S1Res and spon
    %         [S1H, S1P] = cellfun(@(x, y) ttest(x, y), changeCellRowNum(ampS1), changeCellRowNum(rmsSponS1), "UniformOutput", false);
    %
    %
    %         %% Diff ICI amplitude comparison
    %         sigCh= find(cell2mat(S1H));
    %         nSigCh = find(~cell2mat(S1H));
    %
    %
    %         temp = reshape([ampNorm(1).(strcat(stateStr(mIndex), "_mean"))(sigCh)'; ampNorm(2).(strcat(stateStr(mIndex), "_mean"))(sigCh)';...
    %             ampNorm(3).(strcat(stateStr(mIndex), "_mean"))(sigCh)'; ampNorm(4).(strcat(stateStr(mIndex), "_mean"))(sigCh)';...
    %             ampNorm(5).(strcat(stateStr(mIndex), "_mean"))(sigCh)'; ...%ampNorm(6).(strcat(stateStr(mIndex), "_mean"))(sigCh)';
    %             ampNorm(1).(strcat(stateStr(mIndex), "_se"))(sigCh)'; ampNorm(2).(strcat(stateStr(mIndex), "_se"))(sigCh)';...
    %             ampNorm(3).(strcat(stateStr(mIndex), "_se"))(sigCh)'; ampNorm(4).(strcat(stateStr(mIndex), "_se"))(sigCh)';...
    %             ampNorm(5).(strcat(stateStr(mIndex), "_se"))(sigCh)'; ], 5, []) ;% ampNorm(6).(strcat(stateStr(mIndex), "_se"))(sigCh)'
    %         compare(mIndex).info = stateStr(mIndex);
    %         compare(mIndex).amp_mean_se_S1Sig = [[1; 2; 3; 4; 5], temp];
    %
    %         temp = reshape([ampNorm(1).(strcat(stateStr(mIndex), "_mean"))(nSigCh)'; ampNorm(2).(strcat(stateStr(mIndex), "_mean"))(nSigCh)';...
    %             ampNorm(3).(strcat(stateStr(mIndex), "_mean"))(nSigCh)'; ampNorm(4).(strcat(stateStr(mIndex), "_mean"))(nSigCh)';...
    %             ampNorm(5).(strcat(stateStr(mIndex), "_mean"))(nSigCh)'; ...ampNorm(6).(strcat(stateStr(mIndex), "_mean"))(nSigCh)';
    %             ampNorm(1).(strcat(stateStr(mIndex), "_se"))(nSigCh)'; ampNorm(2).(strcat(stateStr(mIndex), "_se"))(nSigCh)';...
    %             ampNorm(3).(strcat(stateStr(mIndex), "_se"))(nSigCh)'; ampNorm(4).(strcat(stateStr(mIndex), "_se"))(nSigCh)';...
    %             ampNorm(5).(strcat(stateStr(mIndex), "_se"))(nSigCh)'; ], 5, []) ;%ampNorm(6).(strcat(stateStr(mIndex), "_se"))(nSigCh)'
    %         compare(mIndex).amp_mean_se_S1nSig = [[1; 2; 3; 4; 5], temp];
    %

end
%
%
%
%
% setLine(Fig(:, 1), "Color", [1, 1, 0], "Color", [1, 0, 0]);
% setLine(Fig(:, 2), "Color", [0, 0, 0], "Color", [1, 0, 0]);
% setLine(Fig, "LineWidth", 1.5, "LineStyle", "-");
% scaleAxes(Fig(:, 1), "y" , [], [-150 150]);
% scaleAxes(Fig(:, 2), "y" , [], [-70 70]);
% setLine(Fig, "YData", [-150 150], "LineStyle", "--");
% plotLayoutER(Fig(:, 1), 1, 0.8);
% plotLayoutER(Fig(:, 2), 1, 0.8);
% setAxes(Fig, 'yticklabel', '');
% setAxes(Fig, 'xticklabel', '');
% setAxes(Fig, 'visible', 'off');
% set(Fig, "outerposition", [300, 100, 800, 670]);
% drawnow;
%
% %% Data saving params
% mkdir(FIGPATH);
%
% for mIndex = 1 : length(MATPATH)
%     for dIndex =  1 : length(devType)
%         print(Fig(dIndex, mIndex), strcat(FIGPATH, "diff_stage_", strrep(stimStr(dIndex), ".", "o"), "_", stateStr(mIndex)), "-djpeg", "-r200");
%     end
% end
%
% %%
close all;


