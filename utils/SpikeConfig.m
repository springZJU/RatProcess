
% load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\fuzaToneOpts.mat"));
if contains(protocolStr, "tone")
    load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\toneOpts.mat"));
    stimStr = string(cellfun(@(x) strrep(x, "o", "_"), {toneOpts.stimStr}, "uni", false));
    temp = toneOpts;
    for soundType = 1 : length(temp)
        S1Dur(1).(strcat("S", stimStr(soundType))) = temp(soundType).tone1Duration;
        S1Dur(2).(strcat("S", stimStr(soundType))) = temp(soundType).tone2Duration;
    end
else

    load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\opts.mat"));
    if length(opts) == 1 % not duration protocol
        stimStr = string(cellfun(@(x) strcat(strrep(num2str(x(1)), ".", "o"), "_", strrep(num2str(x(2)), ".", "o")), array2VectorCell(opts.ICIName), "uni", false));
        temp = opts.soundRealDuration;
        for soundType = 1 : length(temp)
            S1Dur(1).(strcat("S", stimStr(soundType))) = temp(soundType).regStdDuration;
            S1Dur(2).(strcat("S", stimStr(soundType))) = temp(soundType).regDevDuration;
            try
                S1Dur(3).(strcat("S", stimStr(soundType))) = temp(soundType).irregStdDuration;
                S1Dur(4).(strcat("S", stimStr(soundType))) = temp(soundType).irregDevDuration;
            end
        end

    else % duration protocol
        for dIndex = 1 : length(opts) % duration types
            stimStr = string(cellfun(@(x) strcat(strrep(num2str(x(1)), ".", "o"), "_", strrep(num2str(x(2)), ".", "o")), array2VectorCell(opts(dIndex).ICIName), "uni", false));
            temp = opts(dIndex).soundRealDuration;
            for soundType = 1 : length(temp)
                S1Dur(1).(strcat("S", stimStr(soundType), "_ord", num2str(dIndex))) = temp(soundType).regStdDuration;
                S1Dur(2).(strcat("S", stimStr(soundType), "_ord", num2str(dIndex))) = temp(soundType).regDevDuration;
                try
                    S1Dur(3).(strcat("S", stimStr(soundType), "_ord", num2str(dIndex))) = temp(soundType).irregStdDuration;
                    S1Dur(4).(strcat("S", stimStr(soundType), "_ord", num2str(dIndex))) = temp(soundType).irregDevDuration;
                end
            end
        end
    end

end



switch protocolStr
    case "clickTrainLongTermS2o3D1o76D3Rev76"
        stimStr = [ "2.3-1.76 Reg", "1.76-2.3 Reg", "2.3-3 Reg", "3-2.3 Reg"];
        S1Duration = [S1Dur(1).S3_2o3 S1Dur(2).S3_2o3 S1Dur(1).S2o3_1o76 S1Dur(2).S2o3_1o76];
        window = [-5500 3000]; % stim sound is 7 sec
    case "clickTrainLongTermS4D3D5o4Rev76"
        stimStr = ["4-3 Reg", "3-4 Reg", "4-5.4 Reg", "5.4-4 Reg"];
        S1Duration = [S1Dur(1).S4_3 S1Dur(2).S4_3 S1Dur(1).S4_5o4 S1Dur(2).S4_5o4];
        window = [-5500 3000]; % stim sound is 7 sec
end





