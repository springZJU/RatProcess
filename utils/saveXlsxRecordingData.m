function saveXlsxRecordingData(recordInfo, idx, recordPath)
BLOCKPATH = recordInfo(idx).BLOCKPATH;
sitePos = recordInfo(idx).sitePos;
depth = recordInfo(idx).depth;
paradigm = recordInfo(idx).paradigm;
temp = strsplit(BLOCKPATH, "\");
animalID = temp{end - 2};
dateStr = temp{end - 1};
soundFold = recordInfo(idx).sounds;


%% try to get epocs
try
    buffer=TDTbin2mat(BLOCKPATH);  %spike store name should be changed according to your real name
    data.epocs = buffer.epocs;
catch e
    disp(e.message);
end

%% try to get raw spike data
try
    data.spikeRaw.snips = buffer.snips;
catch e
    disp(e.message);
end

%% try to get sort data
SORTPATH = fullfile(BLOCKPATH, "sortdata.mat");
try
    load(SORTPATH);
    data.sortdata = sortdata;
catch e
    disp(e.message);
end

%% try to get lfp data
try
    load(SORTPATH);
    data.lfp = buffer.streams.Llfp;
catch e
    disp(e.message);
end

%% save params
params.BLOCKPATH = BLOCKPATH;
params.paradigm = paradigm;
params.sitePos = sitePos;
params.depth = depth;
params.animalID = animalID;
params.dateStr = dateStr;
params.soundFold = soundFold;
data.params = params;

%% export result
SAVEPATH = fullfile("E:\ratNeuroPixel\matData", animalID, dateStr, sitePos, paradigm);
mkdir(SAVEPATH);
save(fullfile(SAVEPATH, "data.mat"), "data", "-mat");
recordInfo(idx).processed = 1;

writetable(struct2table(recordInfo), recordPath);
end
