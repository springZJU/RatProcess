clc; close all; clear
%% Parameter setting

% MATPATH = 'E:\ratNeuroPixel\matData\rat2\rat2_20220819\A4o6V0o6\clickTrainLongTermS2o3D1o76D3Rev76\data.mat';
MATPATH{1} = 'E:\ratNeuroPixel\matData\ECoGRat1\ER20221026\ECoG1\clickTrainLongTerm_Oscillation_2_3\data.mat';
MATPATH{2} = 'E:\ratNeuroPixel\matData\ECoGRat1\ER20221115\ECoG1\clickTrainLongTerm_Oscillation_2_3\data.mat';

ROOTPATH = "E:\ratNeuroPixel\CorelDraw\ECoG_Temporal_Binding\";
doICA = true;
params.processFcn = @PassiveProcess_clickTrainContinuous;
fs = 500; % Hz, for downsampling

stimSelect = 1; % 2,4,6,8,10
stateStr = ["Aneasthetic", "Awake"];
cdrPlotIdx = flip([2, 4, 6, 8, 10]);
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
    FIGPATH = strcat(ROOTPATH, "Figure_Duration_Awake_Aneasthetic\", protocolStr, "\", DateStr, "\");
    SAVEPATH = strcat('E:\ratNeuroPixel\result\Figure\', DateStr, "\", posStr, "\", protocolStr, "\");
    if doICA
        SAVEPATH = strrep(SAVEPATH, "Figure", "ICAFigure");
    end

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

    devType = unique([trialAll.devOrdr]);
    devTemp = {trialAll.devOnset}';
    [~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
    temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
    trialAll = addFieldToStruct(trialAll, temp, "devOnset");
    trialAll(1) = [];



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

    for dIndex = 1:length(devType)
        tIndex = [trialAll.devOrdr] == devType(dIndex);
        trials = trialsLFP(tIndex);
        % lfp
        chLfpMean{dIndex} = cell2mat(cellfun(@mean , changeCellRowNum(trials), 'UniformOutput', false));
        chStd = cell2mat(cellfun(@(x) std(x)/sqrt(length(tIndex)), changeCellRowNum(trials), 'UniformOutput', false));

        % FFT during successive sound
        correspFreq = 1 ./ ICI2;
        tIdx = find(t > FFTWin(1) & t < FFTWin(2));
        [ff, PMean{dIndex}, trialsFFT{dIndex}]  = trialsECOGFFT(trials, fs, tIdx, [], "magnitude");
        [tarMean, idx] = findWithinWindow(PMean{dIndex}, ff, [0.9, 1.1] * correspFreq( dIndex));
        [~, targetIndex] = max(tarMean, [], 2);
        targetIdx(dIndex) = mode(targetIndex) + idx(1) - 1;

        for ch = 1 : size(chLfpMean{dIndex}, 1)
            cdrPlot(ch).(strcat(stateStr(mIndex), "Wave"))(:, cdrPlotIdx(dIndex) - 1) = t';
            cdrPlot(ch).(strcat(stateStr(mIndex), "Wave"))(:, cdrPlotIdx(dIndex)) = chLfpMean{dIndex}(ch, :)';
            cdrPlot(ch).(strcat(stateStr(mIndex), "FFT"))(:, cdrPlotIdx(dIndex) - 1) = ff';
            cdrPlot(ch).(strcat(stateStr(mIndex), "FFT"))(:, cdrPlotIdx(dIndex)) = PMean{dIndex}(ch, :)';
        end
    end


end
%%
for mIndex = 1 : length(MATPATH)
    for dIndex = 1 : length(devType)
        Fig(dIndex, mIndex) = plotRawWave_RatECOG(chLfpMean{dIndex}, [], window, strcat(stateStr(mIndex), "_", stimStr(dIndex)));
        FigFFT(dIndex, mIndex) = plotRawWave_RatECOG(PMean{dIndex}, [], [ff(1), ff(end)], strcat(stateStr(mIndex), "_", stimStr(dIndex)));
        deleteLine(FigFFT(dIndex, mIndex), "LineStyle", "--");
        lines(1).X = correspFreq(dIndex); lines(1).color = "k";
        addLines2Axes(FigFFT(dIndex, mIndex), lines);
        orderLine(FigFFT(dIndex, mIndex), "LineStyle", "--", "bottom");
    end
    scaleAxes(FigFFT, "x" , [], [0, 50]);
end

%% sacle figures
setLine([Fig(:, 1), FigFFT(:, 1)], "Color", [1, 1, 0], "Color", [1, 0, 0]);
setLine([Fig(:, 2), FigFFT(:, 2)], "Color", [0, 0, 0], "Color", [1, 0, 0]);

setLine([Fig, FigFFT], "LineWidth", 1.5, "LineStyle", "-");
scaleAxes(Fig(:, 1), "y" , [], [-150 150]);
scaleAxes(Fig(:, 2), "y" , [], [-70 70]);
scaleAxes(FigFFT, "x" , [], [0, 50]);



setLine(Fig, "YData", [-150 150], "LineStyle", "--");
plotLayoutER([Fig(:, 1), FigFFT(:, 1)], 1, 0.8);
plotLayoutER([Fig(:, 2), FigFFT(:, 2)], 1, 0.8);
setAxes([Fig, FigFFT], 'yticklabel', '');
setAxes([Fig, FigFFT], 'xticklabel', '');
setAxes([Fig, FigFFT], 'visible', 'off');
set([Fig, FigFFT], "outerposition", [300, 100, 800, 670]);
drawnow;

%% Data saving params
mkdir(FIGPATH);

for mIndex = 1 : length(MATPATH)
    for dIndex =  1 : length(devType)
        print(FigFFT(dIndex, mIndex), strcat(FIGPATH, "diff_stage_FFT_", strrep(stimStr(dIndex), ".", "o"), "_", stateStr(mIndex)), "-djpeg", "-r200");
        print(Fig(dIndex, mIndex), strcat(FIGPATH, "diff_stage_", strrep(stimStr(dIndex), ".", "o"), "_", stateStr(mIndex)), "-djpeg", "-r200");
    end
end

%%
close all;

