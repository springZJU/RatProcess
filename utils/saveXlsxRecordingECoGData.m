function saveXlsxRecordingECoGData(recordInfo, idx, recordPath)
BLOCKPATH = recordInfo(idx).BLOCKPATH;
sitePos = recordInfo(idx).sitePos;
depth = recordInfo(idx).depth;
paradigm = recordInfo(idx).paradigm;
temp = strsplit(BLOCKPATH, "\");
animalID = temp{end - 2};
dateStr = temp{end - 1};
soundFold = recordInfo(idx).sounds;


%% try to get epocs and ECoG data
try
    buffer=TDTbin2mat(BLOCKPATH);  %spike store name should be changed according to your real name
    data.epocs = buffer.epocs;
    data.lfp = buffer.streams.Llfp;
    data.sortdata = [];
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
recordInfo(idx).exported = 1;

writetable(struct2table(recordInfo), recordPath);
end
