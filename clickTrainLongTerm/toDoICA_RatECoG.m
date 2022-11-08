function [ECOGDataset, comp] = toDoICA_RatECoG(ECOGDataset, trialAll, fs, window)
ECOGDatasetTemp = ECOGDataset;

%% ICA

comp = mICA(ECOGDataset, trialAll([trialAll.oddballType]' ~= "INTERRUPT"), window, "dev onset", fs);

t1 = 0;
t2 = t1 + 400;
comp = realignIC(comp, window, t1, t2);
ICMean = cell2mat(cellfun(@mean, changeCellRowNum(comp.trial), "UniformOutput", false));
% plotRawWave(ICMean, [], window, "ICA", [8, 8]);
% % plotTFA(ICMean, fs, [], window, "ICA", [8, 8]);
% plotTopo(comp, [8, 8]);
% 
% 
% comp = reverseIC(comp, input("IC to reverse: "));
% ICMean = cell2mat(cellfun(@mean, changeCellRowNum(comp.trial), "UniformOutput", false));
% FigICAWave = plotRawWave(ICMean, [], window, "ICA", [4, 8]);
% % plotTFA(ICMean, fs, [], window, "ICA", [4, 5]);
% FigTopo = plotTopo(comp, [4, 8], [4, 8]);
% 
% ECOGDataset.data = comp.unmixing * ECOGDatasetTemp.data;
% comp = rmfield(comp, "trial");