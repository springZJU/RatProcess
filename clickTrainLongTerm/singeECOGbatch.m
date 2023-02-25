clear; clc;

% MATPATH{1} = "E:\ratNeuroPixel\matData\ECoGRat1\ER220221128\ECoG1\";
MATPATH{1} = "E:\ratNeuroPixel\matData\ECoGRat1\ER320221226\ECoG1\";
% MATPATH{3} = "E:\ratNeuroPixel\matData\ECoGRat1\ER220221108\ECoG1\";

for mIndex = 1 : length(MATPATH)
    PROTPATH = dir(MATPATH{mIndex});
    PROTPATH(matches({PROTPATH.name}, [".", ".."])) = [];
    DATANAME = string(cellfun(@(x) strcat(MATPATH{mIndex}, x, "\data.mat"), {PROTPATH.name}, "UniformOutput", false))';
    for dIndex = 5:6%1 : length(DATANAME)
        DATAPATH = DATANAME{dIndex};
        run("singleECoGProcess.m");
    end
end

if ~isempty(gcp('nocreate'))
    delete(gcp('nocreate'));
end