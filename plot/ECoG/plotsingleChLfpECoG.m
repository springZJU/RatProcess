function plotsingleChLfpECoG(trialsLfpByCh, S1Duration, stimStr0, window, recordate,protocolStr)
margins = [0.05, 0.05, 0, 0];
paddings = [0.01, 0.03, 0.03, 0.03];
% remapFile = "E:\ratNeuroPixel\Process\plot\ch_validate_1_32.xlsx";
% temp = table2struct(readtable(remapFile));
% remapIdx = [temp.Var3];

% ECoGChIdx = [ 2 : 5, 7 : 18, 35 : -1 : 32, 30 : -1 : 19];
% ECoGChIdx = [17,23,24,29];
ECoGChIdx = [24,29,25,30];
selectWin = [-200 600];
% ECoGChIdx = 1 : 32;
s1Idx = 1 : length(stimStr0);
chNum = length(ECoGChIdx);
remapIdx = 1:chNum;
Fig = figure;
maximizeFig(Fig);
for cIndex = 1:chNum %3

    for dIndex=1:length(trialsLfpByCh)%1

        Temp0=[];s1Idx = 1 : length(stimStr0{dIndex});

        for eIndex = 1:length(trialsLfpByCh{dIndex})%2

            %% put S1 onset and S2 onset together

            % shank1
            temp = mean(trialsLfpByCh{dIndex}{eIndex, 1}{ECoGChIdx(cIndex)});
            Temp0 = [Temp0;trialsLfpByCh{dIndex}{eIndex, 1}{cIndex}];
            t = linspace(window{dIndex}(1), window{dIndex}(2), size(temp, 2));
            [s2Wave, s2Index] = findWithinWindow(temp, t, selectWin);
            s2Wave0(eIndex,:)=s2Wave;
            stimStr{eIndex}=[strsplit(stimStr0{dIndex}(eIndex))];
            ti{eIndex}=[strsplit(stimStr{eIndex}(1),'-')];
            if contains(protocolStr, "duration")
                le(eIndex)=ti{eIndex}(1);
            elseif contains(protocolStr, "Var")
                le(eIndex)=ti{eIndex}(3);
            elseif contains(protocolStr, "Ratio")
                le{eIndex}=num2str(str2num(ti{eIndex}(3))/str2num(ti{eIndex}(2)));
            end
        end
        %         s1Temp = mean(Temp0);
        %         tS1 = linspace(window4{dIndex}(1), window4{dIndex}(2), size(s1Temp, 2)) + S1Duration4{dIndex}(s1Idx(dIndex));
        %         [s1Wave, s1Index] = findWithinWindow(s1Temp, tS1, selectWin);
        F(cIndex,dIndex)=mSubplot(Fig, 4, 5, ((cIndex-1)*5+dIndex), [1, 1], margins, paddings);
        %         plot(tS1(s1Index), s1Wave, "Color", "blue", "LineStyle", "-", "LineWidth", 1.5); hold on;
       plot(t(s2Index), s2Wave0(1,:), "LineStyle", "-","color",[0.7451 0.7451 0.7451], "LineWidth", 1); hold on;
       plot(t(s2Index), s2Wave0(2,:), "LineStyle", "-","color","k", "LineWidth", 1); hold on;
       plot(t(s2Index), s2Wave0(3,:), "LineStyle", "-","color","g", "LineWidth", 1); hold on;
       plot(t(s2Index), s2Wave0(4,:), "LineStyle", "-","color","b", "LineWidth", 1); hold on;
       if ~isempty(s2Wave0(5,:))
       plot(t(s2Index), s2Wave0(5,:), "LineStyle", "-","color","r", "LineWidth", 1); hold on;
       end




        xlim(selectWin);

        if cIndex == 1
            if contains(protocolStr, "duration")
                title(strcat(ti{1}(2),'-',ti{1}(3)));jpgname = "Duration";
            elseif contains(protocolStr, "Var")
                title(strcat(ti{1}(1),'-',ti{1}(2)));jpgname = "Variance";
            elseif contains(protocolStr, "Ratio")
                title(ti{1}(2));jpgname = "Ratio";
            end


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
    legend(le,'Location',[0.97 0.92 0.02  0.05]);
    lines(1).X = 0;
    lines(1).color = "black";
    addLines2Axes(Fig, lines);

    drawnow;
    scaleAxes(Fig, "y" , [-150 150]);
    SAVEPATH = fullfile('E:\ratNeuroPixel\result\newFigure', recordate);
    mkdir(SAVEPATH);
    print(Fig, fullfile(SAVEPATH, jpgname), "-djpeg", "-r200");



