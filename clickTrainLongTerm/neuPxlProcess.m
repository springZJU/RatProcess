clear; clc;
recordPath = "E:\ratNeuroPixel\tankData\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
protocols = unique(string({recordInfo.paradigm}'));

for rIndex = 1 : length(protocols)
    protocolStr = protocols(rIndex);
    
    if protocolStr == "noise"
        continue
    elseif protocolStr == "toneCF"
        plotFRA(protocolStr);
    else
        clickTrainLongTermProcess(protocolStr);
    end
end
