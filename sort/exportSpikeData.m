clear all; clc
mPath = mfilename("fullpath");
cd(fileparts(mPath));
recordPath = "..\utils\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
sort = [recordInfo.sort]';
exported = [recordInfo.exported]';
validated = [recordInfo.validateSounds]';
isECoG = [recordInfo.isECoG]';
iIndex = find(sort == 1 & exported == 0 & isECoG == 0);  % export sorted and unprocessed spike data
vIndex = find(exported == 1 & validated == 0 & isECoG == 0); % re-export exported spike data
eIndex = find(isECoG == 1 & exported ==0); % export ECoG data

%% export sorted and unprocessed spike data 
for i = iIndex'
    disp(strcat("processing ", recordInfo(i).BLOCKPATH, "... (", num2str(i), "/", num2str(max(iIndex)), ")"));
    recordInfo = table2struct(readtable(recordPath));
    saveXlsxRecordingData(recordInfo, i, recordPath);
end

%% re-export exported spike data
for j = vIndex'
    disp(strcat("validating ", recordInfo(j).BLOCKPATH, "... (", num2str(j), "/", num2str(max(vIndex)), ")"));
    recordInfo = table2struct(readtable(recordPath));
    validateRecordingData(recordInfo, j, recordPath);
end

%% export ECoG data
for e = eIndex'
    disp(strcat("processing ECoG ", recordInfo(j).BLOCKPATH, "... (", num2str(e), "/", num2str(max(eIndex)), ")"));
    recordInfo = table2struct(readtable(recordPath));
    saveXlsxRecordingECoGData(recordInfo, e, recordPath);
end




