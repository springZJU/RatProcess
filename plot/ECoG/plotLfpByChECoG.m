function Fig = plotLfpByChECoG(trialsLfpByCh, window, stimStr)
margins = [0.05, 0.05, 0, 0];
paddings = [0.01, 0.03, 0.03, 0.03];
% remapFile = "E:\ratNeuroPixel\Process\plot\ch_validate_1_32.xlsx";
% temp = sortrows(table2array(readtable(remapFile)), 3);
% remapIdx = temp(:, 1);

ECoGChIdx = [ 2:5, 7:30, 32:35];
% ECoGChIdx = 1 : 32;
chNum = length(ECoGChIdx);
remapIdx = 1:chNum;
for dIndex = 1 : length(trialsLfpByCh)
    Fig(dIndex) = figure;
    maximizeFig(Fig(dIndex));

    for cIndex = 1 : chNum
        %% whole time lfp wave
        % shank1
        Axes = mSubplot(Fig(dIndex), 6, 6, ECoGChIdx(cIndex), [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{remapIdx(cIndex), 1});
        t = linspace(window(1), window(2), size(temp, 2));
        plot(Axes, t, temp, "Color", "red", "LineStyle", "-", "LineWidth", 1.5); hold on;
        xlim([t(1), t(end)]);
        if cIndex == 1
            title(strcat(stimStr(dIndex), " shank1-Odd"));
        end
        if cIndex < chNum
            set(gca, 'xticklabel', '');
        end
        if dIndex > 1
            set(gca, 'yticklabel', '');
        end

    end
end

% add vertical line
lines(1).X = 0;
lines(1).color = "black";
addLines2Axes(Fig, lines);



