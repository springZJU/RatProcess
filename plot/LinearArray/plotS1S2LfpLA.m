function Fig = plotS1S2LfpLA(trialsLfpByCh, S1Duration, stimStr, window)    
margins = [0.05, 0.05, 0, 0];
paddings = [0.01, 0.03, 0.03, 0.03];
Fig = figure;
maximizeFig(Fig);
shank1 = (31 : -2 : 1)';
shank2 = (32 : -2 : 2)';
s1Idx = [2 1 4 3];
chNum = length(shank1);
for dIndex = 1 : length(stimStr)
    for cIndex = 1 : chNum
        %% put S1 onset and S2 onset together

        selectWin = [-200 600];
        % shank1
        mSubplot(Fig, 16, 2 * length(stimStr), (cIndex - 1) * 2 * length(stimStr) + 2 * dIndex - 1, [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{shank1(cIndex), 1});
        s1Temp = mean(trialsLfpByCh{s1Idx(dIndex), 1}{shank1(cIndex), 1});
        t = linspace(window(1), window(2), size(temp, 2));
        tS1 = linspace(window(1), window(2), size(s1Temp, 2)) + S1Duration(s1Idx(dIndex));
        [s1Wave, s1Index] = findWithinWindow(s1Temp, tS1, selectWin);
        [s2Wave, s2Index] = findWithinWindow(temp, t, selectWin);
        plot(tS1(s1Index), s1Wave, "Color", "blue", "LineStyle", "-", "LineWidth", 1.5); hold on;
        plot(t(s2Index), s2Wave, "Color", "red", "LineStyle", "-", "LineWidth", 1.5); hold on;
        xlim(selectWin);

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
        mSubplot(Fig, 16, 2 * length(stimStr), (cIndex - 1) * 2 * length(stimStr) + 2 * dIndex, [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{shank2(cIndex), 1});
        s1Temp = mean(trialsLfpByCh{s1Idx(dIndex), 1}{shank2(cIndex), 1});
        t = linspace(window(1), window(2), size(temp, 2));
        tS1 = linspace(window(1), window(2), size(s1Temp, 2)) + S1Duration(s1Idx(dIndex));
        [s1Wave, s1Index] = findWithinWindow(s1Temp, tS1, selectWin);
        [s2Wave, s2Index] = findWithinWindow(temp, t, selectWin);
        plot(tS1(s1Index), s1Wave, "Color", "blue", "LineStyle", "-", "LineWidth", 1.5); hold on;
        plot(t(s2Index), s2Wave, "Color", "red", "LineStyle", "-", "LineWidth", 1.5); hold on;
        xlim(selectWin);

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



