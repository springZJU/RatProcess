clc; clear;
MATPATH{1} = "E:\ratNeuroPixel\matData\ECoGRat1\ER20221115\ECoG1\";


params.processFcn = @PassiveProcess_clickTrainContinuous;
params.fd = 500;
params.window = [-2000 2000];
for mIndex = 1 : length(MATPATH)
    PROTPATH = dir(MATPATH{mIndex});
    PROTPATH(matches({PROTPATH.name}, [".", ".."])) = [];
    DATANAME = string(cellfun(@(x) strcat(MATPATH{mIndex}, x, "\data.mat"), {PROTPATH.name}, "UniformOutput", false))';
    SAVEPATH = erase(ICAName, "IC_Comp_Merge.mat");
    temp = cellfun(@(x) string(strsplit(x, "\")), DATANAME, "uni", false);
    PSAVEPATH = string(cellfun(@(x) strcat(SAVEPATH, x(end - 1)), temp, "uni", false));
    PICAPATH = string(cellfun(@(x) strcat(SAVEPATH, x(end - 1), "\IC_Comp_Merge.mat"), temp, "uni", false));

    % %get population data
    trialsECOG = cell(length(DATANAME), 1);
    for dIndex = 1 : length(DATANAME)
        DATAPATH = DATANAME{dIndex};
        [trialsECOG{dIndex, 1}, ICAName] = getTrialsECOGRat(DATAPATH, params);
    end
    trialsECOG_Merge = mergeSameContentCell(trialsECOG);

    %% ICA
    [comp, ICs, FigTopoICA, FigWave, FigIC] = ICA_Population_RatRCOG(trialsECOG_Merge, params.fd, params.window);
    compT = comp;
    compT.topo(:, ~ismember(1:size(compT.topo, 2), ICs)) = 0;
    save(ICAName, "compT", "comp", "ICs", "-mat");
    
    for pIndex = 1 : length(PICAPATH)
        mkdir(PSAVEPATH(pIndex));
        save(PICAPATH(pIndex), "compT", "comp", "ICs", "-mat");
    end

    print(FigWave(2), strcat(SAVEPATH, "IC_Rescutction_"), "-djpeg", "-r200");
    print(FigTopoICA, strcat(SAVEPATH, "IC_Topo_"), "-djpeg", "-r200");
    print(FigIC, strcat(SAVEPATH, "IC_Raw_"), "-djpeg", "-r200");
    close(FigTopoICA);
    close(FigWave);
    close(FigIC);

end
