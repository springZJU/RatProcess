function clickTrainLongTermECoGProcess(protocolStr, doICA)
%% Parameter setting
reprocess = 0;
params.processFcn = @PassiveProcess_clickTrainContinuous;
fs = 500; % Hz, for downsampling
rootPath = "E:\ratNeuroPixel\matData";

skipProtocol = ["clickTrainLongTermDecoding"];

paraTemp = protocolStr;

matPath = getSubfoldPath(rootPath, "data.mat" , strcat("ECoGRat.*", protocolStr));
protStr = cellfun(@(x) string(strsplit(x, "\")), matPath, "UniformOutput", false);
matPath = matPath(ismember(string(cellfun(@(x) x(7), protStr, "UniformOutput", false)), protocolStr));
%     run("loadDatapath.m");
for pIndex = 1:length(matPath)
    clear trialAll spikeDataset lfpDataset trials chSpike trialsLfp chLfpMean chStd chSpikeLfp trialsLfpByCh
    disp(strcat("processing ", protocolStr , "...(", num2str(pIndex), "/", num2str(length(matPath)), ")"));

    %% Processing
    DATAPATH = matPath{pIndex};
    if isempty(DATAPATH)
        continue
    end
    temp = strsplit(DATAPATH, "\");
    dateStr = temp{5};
    posStr = temp{6};
    protocolStr = temp{7};

    SAVEPATH = fullfile('E:\ratNeuroPixel\result\Figure', dateStr, posStr, protocolStr);
    if doICA
        SAVEPATH = strrep(SAVEPATH, "Figure", "ICAFigure");
    end
    if (exist(SAVEPATH, "dir") && ~reprocess) || ismember(protocolStr, skipProtocol)
        continue
    end
    [trialAll, lfpDataset, soundFold] = ratLfpProcess(DATAPATH, params);

    if ~isempty(lfpDataset)
        fs0 = lfpDataset.fs;
    end
    trialAll([trialAll.devOrdr] == 0) = [];


    window = [-1500 1500]; 

    run("loadDur.m");
    run("configWindowStr.m");

    devType = unique([trialAll.devOrdr]);
    devTemp = {trialAll.devOnset}';
    [~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
    temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
    trialAll = addFieldToStruct(trialAll, temp, "devOnset");
    trialAll(1) = [];



    if doICA
        ICAName = strcat(SAVEPATH, "\comp.mat");
        if ~exist(ICAName, "file")
            [lfpDataset, comp, ~, ~] = toDoICA(lfpDataset, trialAll, 500);
            %             print(FigICAWave, strcat(ICAPATH, AREANAME, "_ICA_Wave_", DateStr), "-djpeg", "-r200");
            %             print(FigTopo, strcat(ICAPATH, AREANAME, "_ICA_Topo_",  DateStr), "-djpeg", "-r200");
            save(ICAName, "comp", "-mat");
        else
            load(ICAName);
            lfpDataset.data = comp.unmixing * lfpDataset.data;
        end
    end

    for dIndex = 1:length(devType)
        trials = trialAll([trialAll.devOrdr] == devType(dIndex));
        % lfp
        [trialsLfp, chLfpMean, chStd] = selectEcog(lfpDataset, trials, "dev onset", window);
        trialsLfp = excludeTrialsChs(trialsLfp, 0.1);
        trialsLfpByCh{dIndex, 1} = changeCellRowNum(trialsLfp);
    end

    s1s2Fig = plotS1S2LfpECoG(trialsLfpByCh, S1Duration, stimStr, window);
    drawnow;
    lfpFig = plotLfpByChECoG(trialsLfpByCh, window, stimStr);
    drawnow;
    scaleAxes([lfpFig, s1s2Fig], "y" , [-150 150]);
    setLine([lfpFig, s1s2Fig], "Color", [1 1 0], "Color", [1 0 0]);
    plotLayoutER([s1s2Fig, lfpFig], 1, 1);
    set([s1s2Fig, lfpFig], "outerposition", [300, 100, 800, 670]);
    mkdir(SAVEPATH);
    for sIndex = 1 : length(lfpFig)
        print(s1s2Fig(sIndex), fullfile(SAVEPATH, strcat("s1s2LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
        print(lfpFig(sIndex), fullfile(SAVEPATH, strcat("LFP_", strrep(stimStr(sIndex), ".", "o"))), "-djpeg", "-r200");
    end
    %% Data saving params




    %%
    close all;
end

end
