function Fig = plotRawWaveMulti_RatECOG(chData, window, stimStr, titleStr, plotSize, chs, visible)
narginchk(2, 6);

if nargin < 4 || isempty(titleStr)
    titleStr = '';
else
    titleStr = [' | ', char(titleStr)];
end

if nargin < 5
    plotSize = [6, 6];
end

if nargin < 6
    chs = reshape(1:(plotSize(1) * plotSize(2)), plotSize(2), plotSize(1))';
end

if nargin < 7
    visible = "on";
end
if length(fieldnames(chData(1))) >2
    lablel = char(stimStr);xlablel = string(lablel(1,3:end-4,:));
    Fig = plotRawWaveErr_RatECOG(chData(1), [], window, titleStr, plotSize, chs, visible, xlablel);
else
    Fig = plotRawWave_RatECOG(chData(1), [], window, titleStr, plotSize, chs, visible);
end
setLine(Fig, "Color", chData(1).color, "LineWidth", 1.5);
if length(chData) > 1
    for i = 2 : length(chData)
        lineSetting.color = chData(i).color;
        Fig_MultiWave = plotRawWaveAdd_RatECOG(Fig, chData(i).chMean, [], window, lineSetting);
    end
end
end