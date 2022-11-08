function [trialAll, lfpDataset, soundFold] = ratLfpProcess(DATAPATH, params)
% Description: load data from *.mat or TDT block
% Input:
%     DATAPATH: full path of *.mat or TDT block path
%     params:
%         - choiceWin: choice window, in ms
%         - processFcn: behavior processing function handle

% Output:
%     trialAll: n*1 struct of trial information
%     ECOGDataset: TDT dataset of [streams.(posStr(posIndex))]



%% Parameter settings
run("paramsConfig.m");
params = getOrFull(params, paramsDefault);

paramsNames = fieldnames(params);

for index = 1:size(paramsNames, 1)
    eval([paramsNames{index}, '=params.', paramsNames{index}, ';']);
end

%% Validation
if isempty(processFcn)
    error("Process function is not specified");
end

%% Loading data
try
    disp("Try loading data from MAT");
    load(DATAPATH);
    lfpDataset = data.lfp;
    epocs = data.epocs;
    trialAll = processFcn(epocs, choiceWin);
    soundFold = data.params.soundFold;
catch e
    disp(e.message);
    disp("Try loading data from TDT BLOCK...");
    temp = TDTbin2mat(DATAPATH, 'TYPE', {'epocs'});
    epocs = temp.epocs;
    trialAll = processFcn(epocs, choiceWin);

    temp = TDTbin2mat(DATAPATH, 'TYPE', {'streams'});
    streams = temp.streams;
    lfpDataset = streams.Llfp;
    soundFold = [];
end

return;
end