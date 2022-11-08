function validateRecordingData(recordInfo, idx, recordPath)
BLOCKPATH = recordInfo(idx).BLOCKPATH;
sitePos = recordInfo(idx).sitePos;
depth = recordInfo(idx).depth;
paradigm = recordInfo(idx).paradigm;
temp = strsplit(BLOCKPATH, "\");
animalID = temp{end - 2};
dateStr = temp{end - 1};
soundFold = recordInfo(idx).sounds;



%% try to get saved data
SAVEPATH = fullfile("E:\ratNeuroPixel\matData", animalID, dateStr, sitePos, paradigm);
try
    load(fullfile(SAVEPATH, "data.mat"));
    data.params.soundFold = soundFold;
catch e
    disp(e.message);
end


%% export result
save(fullfile(SAVEPATH, "data.mat"), "data", "-mat");
recordInfo(idx).validateSounds = 1;
writetable(struct2table(recordInfo), recordPath);
end
