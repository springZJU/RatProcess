clc; 
clearvars -except MATPATH mIndex DATANAME dIndex DATAPATH;
% DATAPATH = "E:\ratNeuroPixel\matData\ECoGRat1\ER220221102\ECoG1\clickTrainLongTerm_Ratio_4_v2_1\data.mat";
params.processFcn = @PassiveProcess_clickTrainContinuous;
doICA = true;
temp = string(strsplit(DATAPATH, "\"));
dateStr = temp(5);
posStr = temp(6);
protocolStr = temp(7);

SAVEPATH = strcat('E:\ratNeuroPixel\result\Figure\', dateStr, "\", posStr, "\", protocolStr, "\");
if doICA
    SAVEPATH = strrep(SAVEPATH, "Figure", "ICAFigure");
end

mkdir(SAVEPATH);
[trialAll, lfpDataset, soundFold] = ratLfpProcess(DATAPATH, params);
lfpDataset = ECOGResample(lfpDataset, 500);
lfpDatasetCopy = lfpDataset;
if ~isempty(lfpDataset)
    fs0 = lfpDataset.fs;
end

window = [-1500 1500]; % stim sound is 7 sec

run("loadDur.m");
run("configWindowStr.m");
cursor = 1000./ICI2;
%% trialAll config
devType = unique([trialAll.devOrdr]);
devTemp = {trialAll.devOnset}';
[~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
trialAll = addFieldToStruct(trialAll, temp, "devOnset");
trialAll(1) = [];

%% ICA
[trialsTemp, ~, ~] = selectEcog(lfpDatasetCopy, trialAll, "dev onset", window); % "dev onset"; "trial onset"
if doICA
    ICAName = strcat(SAVEPATH, "IC_Comp",  ".mat");

    if ~exist(ICAName, "file")
        [comp, ICs, FigTopoICA, FigWave] = ICA_Population_RatRCOG(trialsTemp, fs0, window);
        compT = comp;
        compT.topo(:, ~ismember(1:size(compT.topo, 2), ICs)) = 0;
        trialsLFP = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
        close(FigTopoICA);
        close(FigWave);
        save(ICAName, "compT", "comp", "ICs", "-mat");
    else
        load(ICAName);
%         ICA_Exclude_RatECOG(trialsTemp, comp, window);
        trialsLFP = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
    end

end

%% get lfp
t = linspace(window(1), window(2), size(trialsLFP{1}, 2));

for dIndex = 1:length(devType)
    tIndex = [trialAll.devOrdr] == devType(dIndex);
    trialsLfp = trialsLFP(tIndex);
    % lfp
    tIdx = find(t > FFTWin(1) & t < FFTWin(2));
    [ff, PMean{dIndex}, trialsFFT]  = trialsECOGFFT(trialsLfp, fs0, tIdx);
    chLfpMean{dIndex} = cell2mat(cellfun(@mean , changeCellRowNum(trialsLfp), 'UniformOutput', false));
    chStd{dIndex} = cell2mat(cellfun(@(x) std(x)/sqrt(length(tIndex)), changeCellRowNum(trialsLfp), 'UniformOutput', false));
    trialsLfpByCh{dIndex, 1} = changeCellRowNum(trialsLfp);
    FigFFT = plotRawWave_RatECOG(PMean{dIndex}, [], [ff(1), ff(end)]);
    deleteLine(FigFFT, "LineStyle", "--");
    lines(1).X = cursor(dIndex); lines(1).color = "k";
    addLines2Axes(FigFFT, lines);
    scaleAxes(FigFFT, "x" , [0 100]);
%     setAxes(FigFFT, "xScale", "log");
    scaleAxes(FigFFT, "y" , [], [0 6000]);
    orderLine(FigFFT, "LineStyle", "--", "bottom");
    setLine(FigFFT, "YData", [0 5000], "LineStyle", "--");
    setLine(FigFFT, "Color", [1 1 0], "Color", [1 0 0]);
    set(FigFFT, "outerposition", [300, 100, 800, 670]);
    pause(0.1);
    plotLayoutER(FigFFT, 1, 1);
    print(FigFFT, fullfile(SAVEPATH, strcat("s2FFT_", strrep(stimStr(dIndex), ".", "o"))), "-djpeg", "-r200");
    close(FigFFT);
end


s1s2Fig = plotS1S2LfpECoG(trialsLfpByCh, S1Duration, stimStr, window);
lfpFig = plotLfpByChECoG(trialsLfpByCh, window, stimStr);

scaleAxes([lfpFig, s1s2Fig], "y" , [], [-150 150]);

setLine([lfpFig, s1s2Fig], "Color", [1 1 0], "Color", [1 0 0]);
plotLayoutER([s1s2Fig, lfpFig], 1, 1);
set([s1s2Fig, lfpFig], "outerposition", [300, 100, 800, 670]);
pause(0.1);
drawnow;

%% Data saving params

for sIndex = 1 : length(lfpFig)
    print(s1s2Fig(sIndex), fullfile(SAVEPATH, strcat("s1s2LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
    print(lfpFig(sIndex), fullfile(SAVEPATH, strcat("LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
end



%%
close all;

SAVEPATH = strcat('E:\ratNeuroPixel\result\Figure\', dateStr, "\", posStr, "\", protocolStr, "\");
if doICA
    SAVEPATH = strrep(SAVEPATH, "Figure", "ICAFigure");
end

mkdir(SAVEPATH);
[trialAll, lfpDataset, soundFold] = ratLfpProcess(DATAPATH, params);
lfpDataset = ECOGResample(lfpDataset, 500);
lfpDatasetCopy = lfpDataset;
if ~isempty(lfpDataset)
    fs0 = lfpDataset.fs;
end

window = [-1500 1500]; % stim sound is 7 sec

run("loadDur.m");
run("configWindowStr.m");
cursor = 1000./ICI2;
%% trialAll config
devType = unique([trialAll.devOrdr]);
devTemp = {trialAll.devOnset}';
[~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
trialAll = addFieldToStruct(trialAll, temp, "devOnset");
trialAll(1) = [];

%% ICA
[trialsTemp, ~, ~] = selectEcog(lfpDatasetCopy, trialAll, "dev onset", window); % "dev onset"; "trial onset"
if doICA
    ICAName = strcat(SAVEPATH, "IC_Comp",  ".mat");

    if ~exist(ICAName, "file")
        [comp, ICs, FigTopoICA, FigWave] = ICA_Population_RatRCOG(trialsTemp, fs0, window);
        compT = comp;
        compT.topo(:, ~ismember(1:size(compT.topo, 2), ICs)) = 0;
        trialsLFP = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
        close(FigTopoICA);
        close(FigWave);
        save(ICAName, "compT", "comp", "ICs", "-mat");
    else
        load(ICAName);
%         ICA_Exclude_RatECOG(trialsTemp, comp, window);
        trialsLFP = cellfun(@(x) compT.topo * comp.unmixing * x, trialsTemp, "UniformOutput", false);
    end

end

%% get lfp
t = linspace(window(1), window(2), size(trialsLFP{1}, 2));

for dIndex = 1:length(devType)
    tIndex = [trialAll.devOrdr] == devType(dIndex);
    trialsLfp = trialsLFP(tIndex);
    % lfp
    tIdx = find(t > FFTWin(1) & t < FFTWin(2));
    [ff, PMean{dIndex}, trialsFFT]  = trialsECOGFFT(trialsLfp, fs0, tIdx);
    chLfpMean{dIndex} = cell2mat(cellfun(@mean , changeCellRowNum(trialsLfp), 'UniformOutput', false));
    chStd{dIndex} = cell2mat(cellfun(@(x) std(x)/sqrt(length(tIndex)), changeCellRowNum(trialsLfp), 'UniformOutput', false));
    trialsLfpByCh{dIndex, 1} = changeCellRowNum(trialsLfp);
    FigFFT = plotRawWave_RatECOG(PMean{dIndex}, [], [ff(1), ff(end)]);
    deleteLine(FigFFT, "LineStyle", "--");
    lines(1).X = cursor(dIndex); lines(1).color = "k";
    addLines2Axes(FigFFT, lines);
    scaleAxes(FigFFT, "x" , [0 100]);
%     setAxes(FigFFT, "xScale", "log");
    scaleAxes(FigFFT, "y" , [], [0 6000]);
    orderLine(FigFFT, "LineStyle", "--", "bottom");
    setLine(FigFFT, "YData", [0 5000], "LineStyle", "--");
    setLine(FigFFT, "Color", [1 1 0], "Color", [1 0 0]);
    set(FigFFT, "outerposition", [300, 100, 800, 670]);
    pause(0.1);
    plotLayoutER(FigFFT, 1, 1);
    print(FigFFT, fullfile(SAVEPATH, strcat("s2FFT_", strrep(stimStr(dIndex), ".", "o"))), "-djpeg", "-r200");
    close(FigFFT);
end


s1s2Fig = plotS1S2LfpECoG(trialsLfpByCh, S1Duration, stimStr, window);
lfpFig = plotLfpByChECoG(trialsLfpByCh, window, stimStr);

scaleAxes([lfpFig, s1s2Fig], "y" , [], [-150 150]);

setLine([lfpFig, s1s2Fig], "Color", [1 1 0], "Color", [1 0 0]);
plotLayoutER([s1s2Fig, lfpFig], 1, 1);
set([s1s2Fig, lfpFig], "outerposition", [300, 100, 800, 670]);
pause(0.1);
drawnow;

%% Data saving params

for sIndex = 1 : length(lfpFig)
    print(s1s2Fig(sIndex), fullfile(SAVEPATH, strcat("s1s2LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
    print(lfpFig(sIndex), fullfile(SAVEPATH, strcat("LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
end



%%
close all;