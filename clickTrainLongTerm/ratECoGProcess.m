clear; clc;
recordPath = "E:\ratNeuroPixel\RatProcess\utils\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
protocols = unique(string({recordInfo.paradigm}'));
recordate = 'ER220221108';n=1;

for rIndex =1 : length(protocols)
    protocolStr = protocols(rIndex);

    if ismember(protocolStr, ["noise", "ECoGtoneCF", "toneCF"])
        continue
    else
        [trialsLfpByCh, S1Duration, stimStr,window,dateStr] = clickTrainLongTermECoGProcess(protocolStr, false,recordate);
    end
    if contains(protocolStr, ["duration","Var","Ratio"])

        if strcmp(recordate,dateStr)
            trialsLfpByCh0{n} = trialsLfpByCh;
            S1Duration0{n} = S1Duration;
            stimStr0{n} = stimStr;
            window0{n} = window;
            protocolStr0 = protocolStr;
            n = n+1;
        else

        end
    end


end
if exist('trialsLfpByCh0')
    plotsingleChLfpECoG(trialsLfpByCh0, S1Duration0, stimStr0, window0,recordate,protocolStr0);
end








