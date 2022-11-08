function clickTrainLongTermProcess(protocolStr)
%% Parameter setting
reprocess = 1;
params.processFcn = @PassiveProcess_clickTrainContinuous;
fs = 500; % Hz, for downsampling
rootPath = "E:\ratNeuroPixel\matData";
sound = "S4";

skipProtocol = ["clickTrainLongTermDecoding"];

if contains(protocolStr, "Ord")
    temp = strsplit(protocolStr, "Ord");
    paraTemp = temp{1};
elseif contains(protocolStr, "Rev")
    temp = strsplit(protocolStr, "Rev");
    paraTemp = temp{1};
end
matPath = getSubfoldPath(rootPath, "data.mat" , protocolStr);
matPath = matPath(~contains(matPath, "ECoG"));

%     run("loadDatapath.m");
for pIndex = 1:length(matPath)
    clear trialAll spikeDataset lfpDataset trials chSpike trialsLfp chLfpMean chStd chSpikeLfp trialsLfpByCh
    disp(strcat("processing ", protocolStr , "...(", num2str(pIndex), "/", num2str(length(matPath)), ")"));

    %% Processing
    DATAPATH = matPath{pIndex};
    if isempty(DATAPATH)
        continue
    end
    temp = string(strsplit(MATPATH, "\"));
    dateStr = temp(5);
    posStr = temp(6);
    protocolStr = temp(7);
    SAVEPATH = fullfile('E:\ratNeuroPixel\result', dateStr, posStr, protocolStr);
    if (exist(SAVEPATH, "dir") && ~reprocess) || ismember(protocolStr, skipProtocol)
        continue
    end
    [trialAll, spikeDataset, lfpDataset, soundFold] = spikeLfpProcess(DATAPATH, params);

    if ~isempty(lfpDataset)
        fs0 = lfpDataset.fs;
    end


 window = [0 8000]; % stim sound is 7 sec
run("SpikeConfig.m");
    devType = unique([trialAll.devOrdr]);
    devTemp = {trialAll.devOnset}';
    [~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
    temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
    trialAll = addFieldToStruct(trialAll, temp, "devOnset");
    trialAll(end) = [];
   

    % spike
    psthPara.binsize = 10; % ms
    psthPara.binstep = 4; % ms
    for dIndex = 1:length(devType)
        trials = trialAll([trialAll.devOrdr] == devType(dIndex));
        % spike
        chSpike = selectSpike(spikeDataset, trials, psthPara, "trial onset", window);
        % lfp
        [trialsLfp, chLfpMean, chStd] = selectEcog(lfpDataset, trials, "trial onset", window);
        chSelect = [chSpike.realCh]';
        trialsLfpByCh{dIndex, 1} = changeCellRowNum(trialsLfp);

        chSpikeLfp{dIndex, 1} = addFieldToStruct(chSpike, [trialsLfpByCh{dIndex, 1}(chSelect) array2VectorCell(chLfpMean(chSelect, :))], ["trialsLfp"; "meanLfp"]);
    end



%% plot figure

% single unit
Fig = plotRasterLfp(chSpikeLfp, window, stimStr);
for cIndex = 1 : length(Fig)
    print(Fig(cIndex), fullfile(SAVEPATH, strcat("ch", num2str(spikeDataset(cIndex).ch))), "-djpeg", "-r300");
end

% lfp of whole period
lfpFig = plotLfpByChLA(trialsLfpByCh, window, stimStr);
scaleAxes(lfpFig, "y", [], [-1000 300]);
print(lfpFig, fullfile(SAVEPATH, strcat("LFP_ch")), "-djpeg", "-r300");

% lfp of s1 and s2
s1s2Fig = plotS1S2LfpLA(trialsLfpByCh, S1Duration, stimStr, window);
scaleAxes(lfpFig, "y", [], [-1000 300]);
print(s1s2Fig, fullfile(SAVEPATH, strcat("s1s2LFP_ch")), "-djpeg", "-r300");


mkdir(FIGPATH);

    %%
    close all;
end

end
