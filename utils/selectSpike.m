function [res, sampleinfo] = selectSpike(spikeDataset, trials, psthPara, segOption, window, scaleFactor)
narginchk(3, 6);

if nargin < 4
    segOption = "trial onset";
end

if nargin < 5
    window = [-3000, 7000];
end

if nargin < 6
    scaleFactor = 1e3;
end

windowIndex = window;

switch segOption
    case "trial onset"
        segIndex = cellfun(@(x) fix(x(1)), {trials.soundOnsetSeq}');
    case "dev onset"
        segIndex = fix([trials.devOnset]');
    case "push onset" % make sure pushing time of all trials not empty

        if length(trials) ~= length([trials.firstPush])
            error("Pushing time of all trials should not be empty");
        end

        segIndex = fix([trials.firstPush]');
    case "last std"
        segIndex = cellfun(@(x) fix(x(end - 1)), {trials.soundOnsetSeq}');
end

if isempty(segIndex)
    trialSpike{1} = 0;
    sampleinfo = [];

else


    if segIndex(1) <= 0
        segIndex(1) = 1;
    end

    % by channel

    for cIndex = 1 : length(spikeDataset)
        spikeTemp = spikeDataset(cIndex).spike;
        % by trial
        trialSpike{cIndex, 1} = cell(length(segIndex), 1);
        sampleinfo = zeros(length(segIndex), 2);
        temp = spikeDataset(cIndex).spike;

        for index = 1:length(segIndex)
            sampleinfo(index, :) = [segIndex(index) + windowIndex(1), segIndex(index) + windowIndex(2)];
            trialSpike{cIndex, 1}{index, 1}(:, 1) = temp(temp > segIndex(index) + windowIndex(1) & temp < segIndex(index) + windowIndex(2)) - segIndex(index);
            trialSpike{cIndex, 1}{index, 1}(:, 2) = ones(length(trialSpike{cIndex, 1}{index, 1}), 1) * index;
        end
        spikePlot{cIndex, 1} = cell2mat(trialSpike{cIndex, 1});
        PSTH{cIndex, 1} = calPsth(spikePlot{cIndex, 1}(:, 1), psthPara, 1e3, 'EDGE', window, 'NTRIAL', length(trials));
    end
    res = struct("ch", {spikeDataset.ch}', "realCh", {spikeDataset.realCh}', "trialSpike", trialSpike, "spikePlot", spikePlot, "PSTH", PSTH);
    return;
end
end