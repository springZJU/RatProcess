function Fig = plotLfpByChLA(trialsLfpByCh, window, stimStr)    
margins = [0.05, 0.05, 0, 0];
paddings = [0.01, 0.03, 0.03, 0.03];
Fig = figure;
maximizeFig(Fig);
shank1 = (31 : -2 : 1)';
shank2 = (32 : -2 : 2)';

chNum = length(shank1);
for dIndex = 1 : length(trialsLfpByCh)
    for cIndex = 1 : chNum
        %% whole time lfp wave
        % shank1
        Axes = mSubplot(Fig, 16, 2 * length(trialsLfpByCh), (cIndex - 1) * 2 * length(trialsLfpByCh) + 2 * dIndex - 1, [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{shank1(cIndex), 1});
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


        % shank2
        mSubplot(Fig, 16, 2 * length(trialsLfpByCh), (cIndex - 1) * 2 * length(trialsLfpByCh) + 2 * dIndex, [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{shank2(cIndex), 1});
        t = linspace(window(1), window(2), size(temp, 2));
        plot(t, temp, "Color", "red", "LineStyle", "-", "LineWidth", 1.5); hold on;
        xlim([t(1), t(end)]);
        if cIndex == 1
            title(strcat(stimStr(dIndex), " shank2-Even"));
        end
        if cIndex < chNum
            set(gca, 'xticklabel', '');
        end
        set(gca, 'yticklabel', '');


    end
end

% add vertical line
lines(1).X = 0;
lines(1).color = "black";
addLines2Axes(Fig, lines);



