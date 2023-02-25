clear; clc;
recordPath = "E:\ratNeuroPixel\RatProcess\utils\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
recordate = 'ER320221209';
protocols =string({recordInfo.paradigm}');



for rIndex =1 : length(recordInfo)
    if isempty(recordInfo(rIndex).BLOCKPATH)
    else
       temp = string(strsplit(recordInfo(rIndex).BLOCKPATH, "\"));

        dateStr = temp(5);
        protocolStr = protocols(rIndex);
        MATPATH = strcat('E:\ratNeuroPixel\matData\ECoGRat1\', dateStr, "\", recordInfo(rIndex).sitePos, "\", protocolStr, "\data.mat");
   if contains(protocolStr, "Offset") && strcmpi(recordate,dateStr)
           run('Figure7_RAT_Offset.m')
           
        elseif contains(protocolStr, ["duration","Var","Ratio","124816"]) && strcmpi(recordate,dateStr)
%         if  contains(protocolStr,"124816") && strcmpi(recordate,dateStr)
           run('Figure4_RAT_Variance.m')

        end
    end
end


