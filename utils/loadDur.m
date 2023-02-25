
% load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\fuzaToneOpts.mat"));
if contains(protocolStr, "Tone")
    load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\toneOpts.mat"));
    stimStr = string(cellfun(@(x) strrep(x, "o", "_"), {toneOpts.stimStr}, "uni", false));
    temp = toneOpts;
    for soundType = 1 : length(temp)
        S1Dur(1).(strcat("S", stimStr(soundType))) = temp(soundType).tone1Duration;
        S1Dur(2).(strcat("S", stimStr(soundType))) = temp(soundType).tone2Duration;
    end
else
try
    load(strcat("E:\ratNeuroPixel\ratSounds\", soundFold ,"\Opts.mat"));
    if length(opts) == 1 % not duration protocol
        stimStr = string(cellfun(@(x) strcat(strrep(num2str(x(1)), ".", "o"), "_", strrep(num2str(x(2)), ".", "o")), array2VectorCell(opts.ICIName), "uni", false));
        temp = opts.soundRealDuration;
        for soundType = 1 : length(temp)
            S1Dur(1).(strcat("S", stimStr(soundType))) = temp(soundType).regStdDuration;
            S1Dur(2).(strcat("S", stimStr(soundType))) = temp(soundType).regDevDuration;
            try
                S1Dur(3).(strcat("S", stimStr(soundType))) = temp(soundType).irregStdDuration;
                S1Dur(4).(strcat("S", stimStr(soundType))) = temp(soundType).irregDevDuration;
                S1Dur(5).(strcat("S", stimStr(soundType))) = temp(soundType).irregStdDuration3;
                S1Dur(6).(strcat("S", stimStr(soundType))) = temp(soundType).irregDevDuration3;
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
end



switch protocolStr
    case "clickTrainLongTermS4D4o6"
        S1Duration = [S1Dur.S4];
    case "clickTrainLongTermS4D5D4o6"
        S1Duration = [S1Dur(1).S4 S1Dur(1).S4_5 S1Dur(2).S4 S1Dur(2).S4_5];
    case "clickTrainLongTermCTS4D3D4o6"
        S1Duration = [S1Dur(1).S4 S1Dur(1).S4_3 fuzaToneOpts.fuzaTone1Duration S1Dur(3).S4_3];
    case "clickTrainLongTermS4D3D5"
        S1Duration = [S1Dur(1).S4_3 S1Dur(2).S4_3 S1Dur(1).S4_5 S1Dur(2).S4_5];
    case "clickTrainLongTermS4D3D5o4"
        S1Duration = [S1Dur(1).S4_3 S1Dur(2).S4_3 S1Dur(1).S4_5o4 S1Dur(2).S4_5o4];
    case "clickTrainLongTermS2o3D1o76D3"
        S1Duration = [S1Dur(1).S3_2o3 S1Dur(2).S3_2o3 S1Dur(1).S2o3_1o76 S1Dur(2).S2o3_1o76];
    case "clickTrainLongTermNormS2o3D1o76D3"
        S1Duration = [S1Dur(1).S3_2o3 S1Dur(2).S3_2o3 S1Dur(1).S2o3_1o76 S1Dur(2).S2o3_1o76];
    case "clickTrainLongTermS4D3o2468"
        S1Duration = [S1Dur(1).S4_3o2 S1Dur(1).S4_3o4 S1Dur(1).S4_3o6 S1Dur(1).S4_3o8];
    case "clickTrainLongTerm2345681o1"
        S1Duration = [S1Dur(1).S2_2o2 S1Dur(1).S3_3o3 S1Dur(1).S4_4o4 S1Dur(1).S5_5o5 S1Dur(1).S6_6o6 S1Dur(1).S8_8o8];
    case "clickTrainLongTerm2345681o3"
        S1Duration = [S1Dur(1).S2_2o6 S1Dur(1).S3_3o9 S1Dur(1).S4_5o2 S1Dur(1).S5_6o5 S1Dur(1).S6_7o8 S1Dur(1).S8_10o4];
    case "clickTrainLongTermS4D001020306"
        S1Duration = [S1Dur(1).S4_4 S1Dur(1).S4_4o01 S1Dur(1).S4_4o02 S1Dur(1).S4_4o03 S1Dur(1).S4_4o06];
    case "clickTrainLongTermS2D01234"
        S1Duration = [S1Dur(1).S2_2 S1Dur(1).S2_2o1 S1Dur(1).S2_2o2 S1Dur(1).S2_2o3 S1Dur(1).S2_2o4];
    case "clickTrainLongTermS2D02468"
        S1Duration = [S1Dur(1).S2_2 S1Dur(1).S2_2o2 S1Dur(1).S2_2o4 S1Dur(1).S2_2o6 S1Dur(1).S2_2o8];
    case "clickTrainLongTerm2345681o1Rev"
        S1Duration = [S1Dur(2).S2_2o2 S1Dur(2).S3_3o3 S1Dur(2).S4_4o4 S1Dur(2).S5_5o5 S1Dur(2).S6_6o6 S1Dur(2).S8_8o8];
    case "clickTrainLongTerm2345681o3Rev"
        S1Duration = [S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S5_6o5 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTermS4D001020306Rev"
        S1Duration = [S1Dur(2).S4_4 S1Dur(2).S4_4o01 S1Dur(2).S4_4o02 S1Dur(2).S4_4o03 S1Dur(2).S4_4o06];
    case "clickTrainLongTermS2D01234Rev"
        S1Duration = [S1Dur(2).S2_2 S1Dur(2).S2_2o1 S1Dur(2).S2_2o2 S1Dur(2).S2_2o3 S1Dur(2).S2_2o4];
    case "clickTrainLongTermS2D02468Rev"
        S1Duration = [S1Dur(2).S2_2 S1Dur(2).S2_2o2 S1Dur(2).S2_2o4 S1Dur(2).S2_2o6 S1Dur(2).S2_2o8];
    case "clickTrainLongTermS4D005101520"
        S1Duration = [S1Dur(1).S4_4 S1Dur(1).S4_4o05 S1Dur(1).S4_4o1 S1Dur(1).S4_4o15 S1Dur(1).S4_4o2];
    case "clickTrainLongTermS4D005101520Rev"
        S1Duration = [S1Dur(2).S4_4 S1Dur(2).S4_4o05 S1Dur(2).S4_4o1 S1Dur(2).S4_4o15 S1Dur(2).S4_4o2];
    case "clickTrainLongTerm2s_2345681o3Rev"
        S1Duration = [S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S5_6o5 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTerm3s_2345681o3Rev"
        S1Duration = [S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S5_6o5 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTerm4s_2345681o3Rev"
        S1Duration = [S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S5_6o5 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTerm5s_2345681o3Rev"
        S1Duration = [S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S5_6o5 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTerm_tone_500_124816"
        S1Duration = [S1Dur(1).S500_500 S1Dur(1).S500_1000 S1Dur(1).S500_2000 S1Dur(1).S500_4000 S1Dur(1).S500_8000];
    case "clickTrainLongTerm_tone_500_333_1o3"
        S1Duration = [S1Dur(2).S333_256 S1Dur(1).S333_256 S1Dur(2).S500_384 S1Dur(1).S500_384];
    case "clickTrainLongTerm2s_1o522o6_2o333o9"
        S1Duration = [S1Dur(2).S2_1o5 S1Dur(1).S2_1o5 S1Dur(2).S2_2o6 S1Dur(1).S2_2o6 S1Dur(2).S3_2o3 S1Dur(1).S3_2o3 S1Dur(2).S3_3o9 S1Dur(1).S3_3o9];
    case "clickTrainLongTerm3s_1o522o6_2o333o9"
        S1Duration = [S1Dur(2).S2_1o5 S1Dur(1).S2_1o5 S1Dur(2).S2_2o6 S1Dur(1).S2_2o6 S1Dur(2).S3_2o3 S1Dur(1).S3_2o3 S1Dur(2).S3_3o9 S1Dur(1).S3_3o9];
    case "clickTrainLongTerm4s_1o522o6_2o333o9"
        S1Duration = [S1Dur(2).S2_1o5 S1Dur(1).S2_1o5 S1Dur(2).S2_2o6 S1Dur(1).S2_2o6 S1Dur(2).S3_2o3 S1Dur(1).S3_2o3 S1Dur(2).S3_3o9 S1Dur(1).S3_3o9];
    case "clickTrainLongTerm5s_1o522o6_2o333o9"
        S1Duration = [S1Dur(2).S2_1o5 S1Dur(1).S2_1o5 S1Dur(2).S2_2o6 S1Dur(1).S2_2o6 S1Dur(2).S3_2o3 S1Dur(1).S3_2o3 S1Dur(2).S3_3o9 S1Dur(1).S3_3o9];
    case "clickTrainLongTerm1s_1o522o6_2o333o9"
        S1Duration = [S1Dur(2).S2_1o5 S1Dur(1).S2_1o5 S1Dur(2).S2_2o6 S1Dur(1).S2_2o6 S1Dur(2).S3_2o3 S1Dur(1).S3_2o3 S1Dur(2).S3_3o9 S1Dur(1).S3_3o9];
    case "clickTrainLongTerm_duration_1235s_3_2o3"
        S1Duration = [S1Dur(2).S3_2o31_ord1 S1Dur(1).S3_2o31_ord1 S1Dur(2).S3_2o31_ord2 S1Dur(1).S3_2o31_ord2 S1Dur(2).S3_2o31_ord3 S1Dur(1).S3_2o31_ord3 S1Dur(2).S3_2o31_ord4 S1Dur(1).S3_2o31_ord4];
    case "clickTrainLongTerm_duration_1235s_3_3o9"
        S1Duration = [S1Dur(2).S3_3o9_ord1 S1Dur(1).S3_3o9_ord1 S1Dur(2).S3_3o9_ord2 S1Dur(1).S3_3o9_ord2 S1Dur(2).S3_3o9_ord3 S1Dur(1).S3_3o9_ord3 S1Dur(2).S3_3o9_ord4 S1Dur(1).S3_3o9_ord4];
    case "clickTrainLongTerm_duration_1235s_4_4o06"
        S1Duration = [S1Dur(2).S4_4o06_ord1 S1Dur(1).S4_4o06_ord1 S1Dur(2).S4_4o06_ord2 S1Dur(1).S4_4o06_ord2 S1Dur(2).S4_4o06_ord3 S1Dur(1).S4_4o06_ord3 S1Dur(2).S4_4o06_ord4 S1Dur(1).S4_4o06_ord4];
    case "clickTrainLongTerm_Ratio_3_v1_1"
        S1Duration = [S1Dur(1).S3_3 S1Dur(1).S3_3o3 S1Dur(1).S3_3o9 S1Dur(1).S3_4o5 S1Dur(1).S3_5o1 S1Dur(1).S3_5o7];
    case "clickTrainLongTerm_Ratio_3_v1_2"
        S1Duration = [S1Dur(1).S3_3 S1Dur(1).S3_3o3 S1Dur(1).S3_3o6 S1Dur(1).S3_3o9 S1Dur(1).S3_4o2 S1Dur(1).S3_4o5];
    case "clickTrainLongTerm_Ratio_3_v1_3"
        S1Duration = [S1Dur(1).S3_3 S1Dur(1).S3_3o15 S1Dur(1).S3_3o3 S1Dur(1).S3_3o45 S1Dur(1).S3_3o6 S1Dur(1).S3_3o75];
    case "clickTrainLongTerm_Ratio_2_v1_1"
        S1Duration = [S1Dur(1).S2_2 S1Dur(1).S2_2o2 S1Dur(1).S2_2o6 S1Dur(1).S2_3 S1Dur(1).S2_3o4 S1Dur(1).S2_3o8];
    case "clickTrainLongTerm_Ratio_2_v1_1Rev"
        S1Duration = [S1Dur(2).S2_2 S1Dur(2).S2_2o2 S1Dur(2).S2_2o6 S1Dur(2).S2_3 S1Dur(2).S2_3o4 S1Dur(2).S2_3o8];
    case "clickTrainLongTerm_Ratio_3_v1_1Rev"
        S1Duration = [S1Dur(2).S3_3 S1Dur(2).S3_3o3 S1Dur(2).S3_3o9 S1Dur(2).S3_4o5 S1Dur(2).S3_5o1 S1Dur(2).S3_5o7];
    case "clickTrainLongTerm_3s_123468_1o5"
        S1Duration = [S1Dur(1).S1_1o5 S1Dur(1).S2_3 S1Dur(1).S3_4o5 S1Dur(1).S4_6 S1Dur(1).S6_9 S1Dur(1).S8_12];
    case "clickTrainLongTerm_3s_123468_1o5Rev"
        S1Duration = [S1Dur(2).S1_1o5 S1Dur(2).S2_3 S1Dur(2).S3_4o5 S1Dur(2).S4_6 S1Dur(1).S6_9 S1Dur(2).S8_12];
    case "clickTrainLongTerm_3s_123468_1o9"
        S1Duration = [S1Dur(1).S1_1o9 S1Dur(1).S2_3o8 S1Dur(1).S3_5o7 S1Dur(1).S4_7o6 S1Dur(1).S6_11o4 S1Dur(1).S8_15o2];
    case "clickTrainLongTerm_3s_123468_1o9Rev"
        S1Duration = [S1Dur(2).S1_1o9 S1Dur(2).S2_3o8 S1Dur(2).S3_5o7 S1Dur(2).S4_7o6 S1Dur(2).S6_11o4 S1Dur(2).S8_15o2];
    case "clickTrainLongTerm_3s_123468_1o3"
        S1Duration = [S1Dur(1).S1_1o3 S1Dur(1).S2_2o6 S1Dur(1).S3_3o9 S1Dur(1).S4_5o2 S1Dur(1).S6_7o8 S1Dur(1).S8_10o4];
    case "clickTrainLongTerm_3s_123468_1o3Rev"
        S1Duration = [S1Dur(2).S1_1o3 S1Dur(2).S2_2o6 S1Dur(2).S3_3o9 S1Dur(2).S4_5o2 S1Dur(2).S6_7o8 S1Dur(2).S8_10o4];
    case "clickTrainLongTerm_3s_124816_1o5"
        S1Duration = [S1Dur(1).S1_1o5 S1Dur(1).S2_3 S1Dur(1).S4_6 S1Dur(1).S8_12 S1Dur(1).S16_24];
    case "clickTrainLongTerm_3s_124816_1o5Rev"
        S1Duration = [S1Dur(2).S1_1o5 S1Dur(2).S2_3 S1Dur(2).S4_6 S1Dur(2).S8_12 S1Dur(1).S16_24];
    case "clickTrainLongTerm_duration_0o512345s_2_3"
        S1Duration = [498.0544 S1Dur(1).S2_3_ord2 S1Dur(1).S2_3_ord3 S1Dur(1).S2_3_ord4 S1Dur(1).S2_3_ord5 S1Dur(1).S2_3_ord6];
    case "clickTrainLongTerm_duration_0o512345s_2_3Rev"
        S1Duration = [499.7542 S1Dur(2).S2_3_ord2 S1Dur(2).S2_3_ord3 S1Dur(2).S2_3_ord4 S1Dur(2).S2_3_ord5 S1Dur(2).S2_3_ord6];
    case "clickTrainLongTerm_Oscillation_2_3"
        S1Duration = [0, 0, 0, 0, 0];
    case "clickTrainLongTerm_Var_2_3"
        S1Duration = [S1Dur(1).S2_3_ord1 S1Dur(1).S2_3_ord2 S1Dur(1).S2_3_ord3 S1Dur(1).S2_3_ord4 S1Dur(1).S2_3_ord5];
%         S1Duration = [S1Dur(1).S2_3_ord1 S1Dur(1).S2_3_ord2 S1Dur(1).S2_3_ord3 S1Dur(1).S2_3_ord4 S1Dur(1).S2_3_ord5 S1Dur(1).S2_3_ord6];
    case "clickTrainLongTerm_Ratio_2_v2_1"
        S1Duration = [S1Dur(1).S2_2 S1Dur(1).S2_2o2 S1Dur(1).S2_2o6 S1Dur(1).S2_3 S1Dur(1).S2_3o4];
    case "clickTrainLongTerm_Ratio_4_v2_1" 
        S1Duration = [S1Dur(1).S4_4 S1Dur(1).S4_4o4 S1Dur(1).S4_5o2 S1Dur(1).S4_6 S1Dur(1).S4_6o8];
    case "clickTrainLongTerm_Ratio_6_v2_1"
        S1Duration = [S1Dur(1).S6_6 S1Dur(1).S6_6o6 S1Dur(1).S6_7o8 S1Dur(1).S6_9 S1Dur(1).S6_10o2];
    case "clickTrainLongTerm_Ratio_8_v2_1"
        S1Duration = [S1Dur(1).S8_8 S1Dur(1).S8_8o8 S1Dur(1).S8_10o4 S1Dur(1).S8_12 S1Dur(1).S8_13o6];
    case "clickTrainLongTerm_Ratio_12_v2_1"
        S1Duration = [S1Dur(1).S12_12 S1Dur(1).S12_13o2 S1Dur(1).S12_15o6 S1Dur(1).S12_18 S1Dur(1).S12_20o4];
    case "clickTrainLongTerm_duration_0o51234s_2_3"
        S1Duration = [499.7542 S1Dur(1).S2_3_ord2 S1Dur(1).S2_3_ord3 S1Dur(1).S2_3_ord4 S1Dur(1).S2_3_ord5];
    case "clickTrainLongTerm_duration_0o51234s_4_6"
        S1Duration = [496.4774 S1Dur(1).S4_6_ord2 S1Dur(1).S4_6_ord3 S1Dur(1).S4_6_ord4 S1Dur(1).S4_6_ord5];
    case "clickTrainLongTerm_duration_0o51234s_6_9"
        S1Duration = [498.0544 S1Dur(1).S6_9_ord2 S1Dur(1).S6_9_ord3 S1Dur(1).S6_9_ord4 S1Dur(1).S6_9_ord5];
    case "clickTrainLongTerm_duration_0o51234s_8_12"
        S1Duration = [496.4774 S1Dur(1).S8_12_ord2 S1Dur(1).S8_12_ord3 S1Dur(1).S8_12_ord4 S1Dur(1).S8_12_ord5];
    case "clickTrainLongTerm_Oscillation_250500ms_2_3"
        S1Duration = [0, 0];
    case "clickTrainLongTerm_Oscillation_250500ms_4_6"
        S1Duration = [0, 0];
    case "clickTrainLongTerm_Oscillation_250500ms_6_9"
        S1Duration = [0, 0];
    case "clickTrainLongTerm_Oscillation_250500ms_8_12"
        S1Duration = [0, 0];  
    case "clickTrainLongTerm_Rhythm_1824_1o522o5"
        S1Duration = [S1Dur(1).S18_27 S1Dur(1).S18_36 S1Dur(1).S18_45 S1Dur(1).S24_36 S1Dur(1).S24_48 S1Dur(1).S24_60];
    case "clickTrainLongTerm_Rhythm_1824_1o522o5Rev"
        S1Duration = [S1Dur(2).S18_27 S1Dur(2).S18_36 S1Dur(2).S18_45 S1Dur(2).S24_36 S1Dur(2).S24_48 S1Dur(2).S24_60];
    case "clickTrainLongTerm_Rhythm_1824_1100"
        S1Duration = [S1Dur(1).S18_18 S1Dur(1).S18_1800 S1Dur(1).S24_24 S1Dur(1).S24_2400];
    case "clickTrainLongTerm_Var_4_6"
        S1Duration = [S1Dur(1).S4_6_ord1 S1Dur(1).S4_6_ord2 S1Dur(1).S4_6_ord3 S1Dur(1).S4_6_ord4 S1Dur(1).S4_6_ord5];
    case "clickTrainLongTerm_Var_6_9"
        S1Duration = [S1Dur(1).S6_9_ord1 S1Dur(1).S6_9_ord2 S1Dur(1).S6_9_ord3 S1Dur(1).S6_9_ord4 S1Dur(1).S6_9_ord5];
    case "clickTrainLongTerm_Var_8_12"
        S1Duration = [S1Dur(1).S8_12_ord1 S1Dur(1).S8_12_ord2 S1Dur(1).S8_12_ord3 S1Dur(1).S8_12_ord4 S1Dur(1).S8_12_ord5];
    case "clickTrainLongTerm_RegInIrreg_03_2_3"   
        S1Duration = [S1Dur(1).S2_3 S1Dur(2).S2_3 S1Dur(3).S2_3 S1Dur(4).S2_3 S1Dur(5).S2_3 S1Dur(6).S2_3];
    case "clickTrainLongTerm_RegInIrreg_03_4_6" 
        S1Duration = [S1Dur(1).S4_6 S1Dur(2).S4_6 S1Dur(3).S4_6 S1Dur(4).S4_6 S1Dur(5).S4_6 S1Dur(6).S4_6];
    case "clickTrainLongTerm_RegIrreg_Change_2_3"   
        S1Duration = [S1Dur(1).S2_3 S1Dur(2).S2_3 S1Dur(3).S2_3 S1Dur(4).S2_3];
    case "clickTrainLongTerm_RegIrreg_Change_4_6"   
        S1Duration = [S1Dur(1).S4_6 S1Dur(2).S4_6 S1Dur(3).S4_6 S1Dur(4).S4_6];
    case "clickTrainLongTerm_RegIrreg_Norm_2_3"   
        S1Duration = [S1Dur(1).S2_3 S1Dur(2).S2_3 S1Dur(3).S2_3 S1Dur(4).S2_3];
    case "clickTrainLongTerm_RegIrreg_Norm_4_6"   
        S1Duration = [S1Dur(1).S4_6 S1Dur(2).S4_6 S1Dur(3).S4_6 S1Dur(4).S4_6];
    case "clickTrainLongTerm_Tone_500250_1o051o5"
        S1Duration = [S1Dur(1).S500_492 S1Dur(1).S250_246 S1Dur(1).S500_333 S1Dur(1).S250_166];
    case "clickTrainLongTerm_TITS_16_40"   
        S1Duration = [S1Dur(1).S16_16 S1Dur(1).S16_40 S1Dur(2).S16_40];
    case "clickTrainLongTerm_TITS_Offset_12_Reg_Irreg_DiffDur"   
        S1Duration = [252 504.100000000000 996.100000000000 2004.20000000000 3996.40000000000 253.600000000000 503.900000000000 1004.80000000000 2012.50000000000 3996.30000000000 0 0 0 0 0];
    case "clickTrainLongTerm_TITS_Offset_12_16_24_Reg_Irreg_Rep"
        S1Duration = [2004.21889080036 1985.58204309003 2000.64512165151 2000.01024002621 2016.22020152372 2010.04546571639];
    case "clickTrainLongTerm_Ratio_2_3"
        S1Duration = [S1Dur(1).S2_2 S1Dur(1).S2_2o2 S1Dur(1).S2_2o6 S1Dur(1).S2_3 S1Dur(1).S2_3o4 S1Dur(1).S2_3o8];
    case "clickTrainLongTerm_Offset_2_128_4s"
        S1Duration = [4014.1, 4014.1, 4003.9, 4003.9, 4001.3, 4000, 4032, 3968, 504.5, 4000, 4000];
    case "clickTrainLongTerm_Offset_256_512_10s"
        S1Duration = [9984, 10240];
    case "clickTrainLongTerm_Offset_Duration_Effect_2ms_Reg"
        S1Duration = [1025.6, 511.8, 254.9, 126.4, 62.2, 30.1, 14, 6, 2, 128, 1024];
    case "clickTrainLongTerm_Offset_Variance_Effect_2ms_16ms_sigma250_2_Reg"
        S1Duration = [488.8, 466, 479.7, 480, 499.8, 501.1, 499.9, 500, 500, 480.2];
    case "clickTrainLongTerm_Offset_Duration_Effect_16ms_Reg"
        S1Duration = [1008.3, 496.2, 240.1, 112, 48, 16, 0, 128, 1024];
    case "clickTrainLongTerm_Offset_Duration_Effect_4ms_Reg"
        S1Duration = [1021, 508.5, 252.2, 124.1, 60.1, 28, 12, 4, 0, 128, 1024];
    case "clickTrainLongTerm_Offset_Variance_Effect_4ms_8ms_sigma250_2_Reg"
        S1Duration = [486.3, 495.4, 496.3, 496, 496.5, 490.6, 495.1, 496.1, 496, 496.5];
    case "clickTrainLongTerm_Offset_Duration_Effect_8ms_Reg"
        S1Duration = [1017, 504.5, 248.2, 120.1, 56.1, 24, 8, 0, 128, 1024];
end





