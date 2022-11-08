function Fig = plotS1S2LfpECoG(trialsLfpByCh, S1Duration, stimStr, window)   
margins = [0.05, 0.05, 0, 0];
paddings = [0.01, 0.03, 0.03, 0.03];
% remapFile = "E:\ratNeuroPixel\Process\plot\ch_validate_1_32.xlsx";
% temp = table2struct(readtable(remapFile));
% remapIdx = [temp.Var3];

% ECoGChIdx = [ 2 : 5, 7 : 18, 35 : -1 : 32, 30 : -1 : 19];
ECoGChIdx = [ 2:5, 7:30, 32:35];
% ECoGChIdx = 1 : 32;
s1Idx = 1 : length(stimStr);
chNum = length(ECoGChIdx);
remapIdx = 1:chNum;
for dIndex = 1 : length(trialsLfpByCh)
    Fig(dIndex) = figure;
    maximizeFig(Fig(dIndex));
    for cIndex = 1 : chNum
        
        %% put S1 onset and S2 onset together
        selectWin = [-200 600];
        % shank1
        mSubplot(Fig(dIndex), 6, 6, ECoGChIdx(cIndex), [1, 1], margins, paddings);
        temp = mean(trialsLfpByCh{dIndex, 1}{remapIdx(cIndex), 1});
        s1Temp = mean(trialsLfpByCh{s1Idx(dIndex), 1}{remapIdx(cIndex), 1});
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



    end
end

% add vertical line
lines(1).X = 0;
lines(1).color = "black";
addLines2Axes(Fig, lines);



