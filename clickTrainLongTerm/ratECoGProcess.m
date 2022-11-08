clear; clc;
recordPath = "E:\ratNeuroPixel\tankData\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
protocols = unique(string({recordInfo.paradigm}'));

for rIndex =1 : length(protocols)
    protocolStr = protocols(rIndex);
    
    if ismember(protocolStr, ["noise", "ECoGtoneCF", "toneCF"])
        continue
    else
        clickTrainLongTermECoGProcess(protocolStr, false);
    end
end
