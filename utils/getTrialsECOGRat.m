function [trialsECOG, ICAName] = getTrialsECOGRat(DATAPATH, params)
% DATAPATH = "E:\ratNeuroPixel\matData\ECoGRat1\ER220221102\ECoG1\clickTrainLongTerm_Ratio_4_v2_1\data.mat";
temp = string(strsplit(DATAPATH, "\"));
DateStr = temp(5);
posStr = temp(6);
protocolStr = temp(7);
ICAName = strcat('E:\ratNeuroPixel\result\ICAFigure\', DateStr, "\", posStr,  "\IC_Comp_Merge.mat");

[trialAll, lfpDataset, soundFold] = ratLfpProcess(DATAPATH, params);
if needCorrection(DateStr)
    lfpDataset.data = ChCorrection_RatECOG(lfpDataset.data);
end
lfpDataset = ECOGDownsample(lfpDataset, params.fd);
lfpDatasetCopy = lfpDataset;

run("loadDur.m");
% run("configWindowStr.m");
window = params.window;
%% trialAll config
devType = unique([trialAll.devOrdr]);
devTemp = {trialAll.devOnset}';
[~, ordTemp] = ismember([trialAll.ordrSeq]', devType);
temp = cellfun(@(x, y) x + S1Duration(y), devTemp, num2cell(ordTemp), "UniformOutput", false);
trialAll = addFieldToStruct(trialAll, temp, "devOnset");
trialAll(1) = [];
[trialsECOG, ~, ~] = selectEcog(lfpDatasetCopy, trialAll, "dev onset", window); % "dev onset"; "trial onset"
end

