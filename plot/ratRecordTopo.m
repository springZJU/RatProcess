clear all; clc
ratName = '.*rat2.*';
recordPath = "E:\ratNeuroPixel\tankData\recording.xlsx";
recordInfo = table2struct(readtable(recordPath));
[gPath, idx] = regexpi({recordInfo.BLOCKPATH}', ratName, "match");
gIndex = find(~cellfun(@isempty, idx));
siteCF = uniqueRowsCA([{recordInfo(gIndex).sitePos}' {recordInfo(gIndex).cf}']);
dSitePos = getPosAxis(cellfun(@(x) strsplit(x, {'A', 'V'}), siteCF(:, 1), "UniformOutput", false));

Fig = figure;
maximizeFig(Fig);
mkrSize = 100;
scatter(dSitePos(:, 1), dSitePos(:, 2), mkrSize,'black', "filled"); hold on

xWin = [1.5 7];
yWin = [0 2.5];
xlim(xWin);
ylim(yWin);

% add CF inf
for i = 1 : size(dSitePos, 1)
    text(dSitePos(i, 1) - diff(xWin) / 50, dSitePos(i, 2) + diff(yWin) * (0.01 + mkrSize / 8000), siteCF{i, 2}, 'fontSize', 12);
end