function Fig = plotRatICA(trialsICs, window)

chMean = cell2mat(cellfun(@mean , changeCellRowNum(trialsICs), 'UniformOutput', false));
chStd = cell2mat(cellfun(@(x) std(x)/sqrt(size(x, 1)), changeCellRowNum(trialsICs), 'UniformOutput', false));
Fig = plotRawWave(chMean, 2 * chStd, window, "IC result", [6, 6]);

setAxes(Fig, "xticklabel", "");
% add vertical line
lines(1).X = 0;
lines(1).color = "black";
addLines2Axes(Fig, lines);
setLine(Fig, "LineWidth", 0.5, "Color", [1, 0, 0]);



