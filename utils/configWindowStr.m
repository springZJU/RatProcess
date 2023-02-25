%% plot Figure
switch protocolStr
    case "clickTrainLongTermS4D4o6"
        stimStr = ["4-4.06 Reg", "4.06-4 Reg", "4-4.06 Irreg", "4.06-4 Irreg"];
    case "clickTrainLongTermS4D5D4o6"
        stimStr = ["4-4.06 Reg", "4-5 Reg", "4-4.06 Irreg", "4-5 Irreg"];
    case "clickTrainLongTermCTS4D3D4o6"
        stimStr = ["4-4.06 Reg", "4-3 Reg", "complexTone", "4-3 Irreg"];
    case "clickTrainLongTermS4D3D5"
        stimStr = ["4-3 Reg", "3-4 Reg", "4-5 Reg", "5-4 Reg"];
    case "clickTrainLongTermS4D3D5o4"
        stimStr = ["4-3 Reg", "3-4 Reg", "4-5.4 Reg", "5.4-4 Reg"];
    case "clickTrainLongTermS2o3D1o76D3"
        stimStr = [ "2.3-1.76 Reg", "1.76-2.3 Reg", "2.3-3 Reg", "3-2.3 Reg"];window = [0 8000];
    case "clickTrainLongTermNormS2o3D1o76D3"
        stimStr = [ "2.3-1.76 Reg", "1.76-2.3 Reg", "2.3-3 Reg", "3-2.3 Reg"];
    case "clickTrainLongTermS4D3o2468"
        stimStr = ["4-3.2 Reg", "4-3.4 Reg", "4-3.6 Reg", "4-3.8 Reg"];
    case "clickTrainLongTerm2345681o1"
        stimStr = ["2-2.2 Reg", "3-3.3 Reg", "4-4.4 Reg", "5-5.5 Reg", "6-6.6 Reg", "8-8.8 Reg"];
    case "clickTrainLongTerm2345681o1Rev"
        stimStr = ["2.2-2 Reg", "3.3-3 Reg", "4.4-4 Reg", "5.5-5 Reg", "6.6-6 Reg", "8.8-8 Reg"];
    case "clickTrainLongTerm2345681o3"
        stimStr = ["2-2.6 Reg", "3-3.9 Reg", "4-5.2 Reg", "5-6.5 Reg", "6-7.8 Reg", "8-10.4 Reg"];
    case "clickTrainLongTerm2345681o3Rev"
        stimStr = ["2.6-2 Reg", "3.9-3 Reg", "5.2-4 Reg", "6.5-5 Reg", "7.8-6 Reg", "10.4-8 Reg"]; window = [-1500 1500];
    case "clickTrainLongTermS4D001020306"
        stimStr = ["4-4 Reg", "4-4.01 Reg", "4-4.02 Reg", "4-4.03 Reg", "4-4.06 Reg"];
    case "clickTrainLongTermS4D001020306Rev"
        stimStr = ["4-4 Reg", "4.01-4 Reg", "4.02-4 Reg", "4.03-4 Reg", "4.06-4 Reg"];
    case "clickTrainLongTermS2D01234"
        stimStr = ["2-2 Reg", "2-2.1 Reg", "2-2.2 Reg", "2-2.3 Reg", "2-2.4 Reg"];
    case "clickTrainLongTermS2D01234Rev"
        stimStr = ["2-2 Reg", "2.1-2 Reg", "2.2-2 Reg", "2.3-2 Reg", "2.4-2 Reg"];
    case "clickTrainLongTermS2D02468"
        stimStr = ["2-2 Reg", "2-2.2 Reg", "2-2.4 Reg", "2-2.6 Reg", "2-2.8 Reg"];
    case "clickTrainLongTermS2D02468Rev"
        stimStr = ["2-2 Reg", "2.2-2 Reg", "2.4-2 Reg", "2.6-2 Reg", "2.8-2 Reg"];
    case "clickTrainLongTermS4D005101520"
        stimStr = ["4-4 Reg", "4-4.05 Reg", "4-4.10 Reg", "4-4.15 Reg", "4-4.20 Reg"];
    case "clickTrainLongTermS4D005101520Rev"
        stimStr = ["4-4 Reg", "4.05-4 Reg", "4.10-4 Reg", "4.15-4 Reg", "4.20-4 Reg"];
    case "clickTrainLongTerm2s_2345681o3Rev"
        stimStr = ["2s-2.6-2 Reg", "2s-3.9-3 Reg", "2s-5.2-4 Reg", "2s-6.5-5 Reg", "2s-7.8-6 Reg", "2s-10.4-8 Reg"];window = [-3000 2000];
    case "clickTrainLongTerm3s_2345681o3Rev"
        stimStr = ["3s-2.6-2 Reg", "3s-3.9-3 Reg", "3s-5.2-4 Reg", "3s-6.5-5 Reg", "3s-7.8-6 Reg", "3s-10.4-8 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm4s_2345681o3Rev"
        stimStr = ["4s-2.6-2 Reg", "4s-3.9-3 Reg", "4s-5.2-4 Reg", "4s-6.5-5 Reg", "4s-7.8-6 Reg", "4s-10.4-8 Reg"];window = [-5000 2000];
    case "clickTrainLongTerm5s_2345681o3Rev"
        stimStr = ["5s-2.6-2 Reg", "5s-3.9-3 Reg", "5s-5.2-4 Reg", "5s-6.5-5 Reg", "5s-7.8-6 Reg", "5s-10.4-8 Reg"];window = [-6000 2000];
    case "clickTrainLongTerm_tone_500_124816"
        stimStr = ["tone 500-500", "tone 500-1000", "tone 500-2000", "tone 500-4000", "tone 500-8000"];
    case "clickTrainLongTerm_tone_500_333_1o3"
        stimStr = ["tone 256-333", "tone 333-256", "tone 384-500", "tone 500-384"];
    case "clickTrainLongTerm2s_1o522o6_2o333o9"
        stimStr = ["2s-1.5-2 Reg", "2s-2-1.5 Reg", "2s-2.6-2 Reg", "2s-2-2.6 Reg", "2s-2.3-3 Reg", "2s-3-2.3 Reg", "2s-3.9-3 Reg", "2s-3-3.9 Reg"];window = [-3000 2000];
    case "clickTrainLongTerm3s_1o522o6_2o333o9"
        stimStr = ["3s-1.5-2 Reg", "3s-2-1.5 Reg", "3s-2.6-2 Reg", "3s-2-2.6 Reg", "3s-2.3-3 Reg", "3s-3-2.3 Reg", "3s-3.9-3 Reg", "3s-3-3.9 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm4s_1o522o6_2o333o9"
        stimStr = ["4s-1.5-2 Reg", "4s-2-1.5 Reg", "4s-2.6-2 Reg", "4s-2-2.6 Reg", "4s-2.3-3 Reg", "4s-3-2.3 Reg", "4s-3.9-3 Reg", "4s-3-3.9 Reg"];window = [-5000 2000];
    case "clickTrainLongTerm5s_1o522o6_2o333o9"
        stimStr = ["5s-1.5-2 Reg", "5s-2-1.5 Reg", "5s-2.6-2 Reg", "5s-2-2.6 Reg", "5s-2.3-3 Reg", "5s-3-2.3 Reg", "5s-3.9-3 Reg", "5s-3-3.9 Reg"];window = [-6000 2000];
    case "clickTrainLongTerm1s_1o522o6_2o333o9"
        stimStr = ["1s-1.5-2 Reg", "1s-2-1.5 Reg", "1s-2.6-2 Reg", "1s-2-2.6 Reg", "1s-2.3-3 Reg", "1s-3-2.3 Reg", "1s-3.9-3 Reg", "1s-3-3.9 Reg"];
    case "clickTrainLongTerm_duration_1235s_3_2o3"
        stimStr = ["1s-2.3-3 Reg", "1s-3-2.3 Reg", "2s-2.3-3 Reg", "2s-3-2.3 Reg","3s-2.3-3 Reg", "3s-3-2.3 Reg","5s-2.3-3 Reg", "5s-3-2.3 Reg"];window = [-6000 2000];
    case "clickTrainLongTerm_duration_1235s_3_3o9"
        stimStr = ["1s-3.9-3 Reg", "1s-3-3.9 Reg", "2s-3.9-3 Reg", "2s-3-3.9 Reg","3s-3.9-3 Reg", "3s-3-3.9 Reg","5s-3.9-3 Reg", "5s-3-3.9 Reg"];window = [-6000 2000];
    case "clickTrainLongTerm_duration_1235s_4_4o06"
        stimStr = ["1s-4.06-4 Reg", "1s-4-4.06 Reg", "2s-4.06-4 Reg", "2s-4-4.06 Reg","3s-4.06-4 Reg", "3s-4-4.06 Reg","5s-4.06-4 Reg", "5s-4-4.06 Reg"];window = [-6000 2000];
    case "clickTrainLongTerm_Ratio_3_v1_1"
        stimStr = ["3s-3-3 Reg", "3s-3-3.3 Reg", "3s-3-3.9 Reg", "3s-3-4.5 Reg", "3s-3-5.1 Reg", "3s-3-5.7 Reg"];window = [-4000 2000];FFTWin = [0, 1000]; ICI2 = [3 3.3 3.9 4.5 5.1 5.7];
    case "clickTrainLongTerm_Ratio_3_v1_2"
        stimStr = ["3s-3-3 Reg", "3s-3-3.3 Reg", "3s-3-3.6 Reg", "3s-3-3.9 Reg", "3s-3-4.2 Reg", "3s-3-4.5 Reg"];window = [-4000 2000];FFTWin = [0, 1000]; ICI2 = [3 3.3 3.6 3.9 4.2 4.5];
    case "clickTrainLongTerm_Ratio_3_v1_3"
        stimStr = ["3s-3-3 Reg", "3s-3-3.15 Reg", "3s-3-3.3 Reg", "3s-3-3.45 Reg", "3s-3-3.6 Reg", "3s-3-3.75 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm_Ratio_2_v1_1"
        stimStr = ["3s-2-2 Reg", "3s-2-2.2 Reg", "3s-2-2.6 Reg", "3s-2-3 Reg", "3s-2-3.4 Reg", "3s-2-3.8 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [2 2.2 2.6 3 3.4 3.8];
    case "clickTrainLongTerm_Ratio_2_v1_1Rev"
        stimStr = ["3s-2-2 Reg", "3s-2.2-2 Reg", "3s-2.6-2 Reg", "3s-3-2 Reg", "3s-3.4-2 Reg", "3s-3.8-2 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [2 2 2 2 2 2];
    case "clickTrainLongTerm_Ratio_3_v1_1Rev"
        stimStr = ["3s-3-3 Reg", "3s-3.3-3 Reg", "3s-3.9-3 Reg", "3s-4.5-3 Reg", "3s-5.1-3 Reg", "3s-5.7-3 Reg"];window = [-4000 2000];FFTWin = [0, 1000]; ICI2 = [3 3 3 3 3 3];
    case "clickTrainLongTerm_3s_123468_1o5"
        stimStr = ["3s-1-1.5 Reg", "3s-2-3 Reg", "3s-3-4.5 Reg", "3s-4-6 Reg", "3s-6-9 Reg", "3s-8-12 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm_3s_123468_1o5Rev"
        stimStr = ["3s-1.5-1 Reg", "3s-3-2 Reg", "3s-4.5-3 Reg", "3s-6-4 Reg", "3s-9-6 Reg", "3s-12-8 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm_3s_123468_1o9"
        stimStr = ["3s-1-1.9 Reg", "3s-2-3.8 Reg", "3s-3-5.7 Reg", "3s-4-7.6 Reg", "3s-6-11.4 Reg", "3s-8-15.2 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm_3s_123468_1o9Rev"
        stimStr = ["3s-1.9-1 Reg", "3s-3.8-2 Reg", "3s-5.7-3 Reg", "3s-7.6-4 Reg", "3s-11.4-6 Reg", "3s-15.2-8 Reg"];window = [-4000 2000];
    case "clickTrainLongTerm_3s_123468_1o3"
        stimStr = ["3s-1-1.3 Reg", "3s-2-2.6 Reg", "3s-3-3.9 Reg", "3s-4-5.2 Reg", "3s-6-7.8 Reg", "3s-8-10.4 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [1.3 2.6 3.9 5.2 7.8 10.4];
    case "clickTrainLongTerm_3s_123468_1o3Rev"
        stimStr = ["3s-1.3-1 Reg", "3s-2.6-2 Reg", "3s-3.9-3 Reg", "3s-5.2-4 Reg", "3s-7.8-6 Reg", "3s-10.4-8 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [1 2 3 4 6 8];
    case "clickTrainLongTerm_3s_124816_1o5"
        stimStr = ["3s-1-1.5 Reg", "3s-2-3 Reg", "3s-4-6 Reg", "3s-8-12 Reg", "3s-16-24 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [1.5 3 6 12 24];
    case "clickTrainLongTerm_3s_124816_1o5Rev"
        stimStr = ["3s-1.5-1 Reg", "3s-3-2 Reg", "3s-6-4 Reg", "3s-12-8 Reg", "3s-24-16 Reg"];window = [-4000 2000]; FFTWin = [0, 1000]; ICI2 = [1 2 4 8 16];
    case "clickTrainLongTerm_duration_0o512345s_2_3"
        stimStr = ["0.5s-2-3 Reg", "1s-2-3 Reg", "2s-2-3 Reg", "3s-2-3 Reg", "4s-2-3 Reg", "5s-2-3 Reg"];window = [-6000 2000]; FFTWin = [0, 1000]; ICI2 = [3 3 3 3 3 3];
    case "clickTrainLongTerm_duration_0o512345s_2_3Rev"
        stimStr = ["0.5s-3-2 Reg", "1s-3-2 Reg", "2s-3-2 Reg", "3s-3-2 Reg", "4s-3-2 Reg", "5s-3-2 Reg"];window = [-6000 2000]; FFTWin = [0, 1000]; ICI2 = [3 3 3 3 3 3];
    case "clickTrainLongTerm_Oscillation_2_3"
        stimStr = ["2-3-30ms Reg", "2-3-60ms Reg", "2-3-125ms Reg", "2-3-250ms Reg", "2-3-500ms Reg"];window = [-1000 11000]; FFTWin = [1000, 9000]; ICI2 = [0.03, 0.06, 0.125, 0.25, 0.5];
    case "clickTrainLongTerm_Var_2_3"
%         stimStr = ["2-3-10 Irreg", "2-3-25 Irreg", "2-3-50 Irreg", "2-3-100 Irreg", "2-3-200 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 3, 3, 3, 3];
        stimStr = ["2-3-2 Irreg", "2-3-10 Irreg", "2-3-25 Irreg", "2-3-50 Irreg", "2-3-100 Irreg", "2-3-200 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 3, 3, 3, 3, 3];
    case "clickTrainLongTerm_Ratio_2_v2_1"
        stimStr = ["3s-2-2 Reg", "3s-2-2.2 Reg", "3s-2-2.6 Reg", "3s-2-3 Reg", "3s-2-3.4 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [2, 2.2, 2.6, 3, 3.4];
    case "clickTrainLongTerm_Ratio_4_v2_1"
        stimStr = ["3s-4-4 Reg", "3s-4-4.4 Reg", "3s-4-5.2 Reg", "3s-4-6 Reg", "3s-4-6.8 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [4, 4.4, 5.2, 6, 6.8];
    case "clickTrainLongTerm_Ratio_6_v2_1"
        stimStr = ["3s-6-6 Reg", "3s-6-6.6 Reg", "3s-6-7.8 Reg", "3s-6-9 Reg", "3s-6-10.2 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [6, 6.6, 7.8, 9, 10.2];
    case "clickTrainLongTerm_Ratio_8_v2_1"
        stimStr = ["3s-8-8 Reg", "3s-8-8.8 Reg", "3s-8-10.4 Reg", "3s-8-12 Reg", "3s-8-13.6 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [8, 8.8, 10.4, 12, 13.6];
    case "clickTrainLongTerm_Ratio_12_v2_1"
        stimStr = ["3s-12-12 Reg", "3s-12-13.2 Reg", "3s-12-15.6 Reg", "3s-12-18 Reg", "3s-12-20.4 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [12, 13.2, 15.6, 18, 20.4];
    case "clickTrainLongTerm_duration_0o51234s_2_3"
        stimStr = ["0.5s-2-3 Reg", "1s-2-3 Reg", "2s-2-3 Reg", "3s-2-3 Reg", "4s-2-3 Reg"];window = [-6000 2000]; FFTWin = [0, 1000];ICI2 = [3 3 3 3 3];
    case "clickTrainLongTerm_duration_0o51234s_4_6"
        stimStr = ["0.5s-4-6 Reg", "1s-4-6 Reg", "2s-4-6 Reg", "3s-4-6 Reg", "4s-4-6 Reg"];window = [-6000 2000]; FFTWin = [0, 1000];ICI2 = [6 6 6 6 6];
    case "clickTrainLongTerm_duration_0o51234s_6_9"
        stimStr = ["0.5s-6-9 Reg", "1s-6-9 Reg", "2s-6-9 Reg", "3s-6-9 Reg", "4s-6-9 Reg"];window = [-6000 2000]; FFTWin = [0, 1000];ICI2 = [9 9 9 9 9];
    case "clickTrainLongTerm_Oscillation_250500ms_2_3"
        stimStr = ["250ms", "500ms"];window = [0 10000]; FFTWin = [0, 10000];ICI2 = [2,3];
    case "clickTrainLongTerm_Oscillation_250500ms_4_6"
        stimStr = ["250ms", "500ms"];window = [0 10000]; FFTWin = [0, 10000];ICI2 = [2,3];
    case "clickTrainLongTerm_Oscillation_250500ms_6_9"
        stimStr = ["250ms", "500ms"];window = [0 10000]; FFTWin = [0, 10000];ICI2 = [2,3];
    case "clickTrainLongTerm_Oscillation_250500ms_8_12"
        stimStr = ["250ms", "500ms"];window = [0 10000]; FFTWin = [0, 10000];ICI2 = [2,3];
    case "clickTrainLongTerm_duration_0o51234s_8_12"
        stimStr = ["0.5s-8-12 Reg", "1s-8-12 Reg", "2s-8-12 Reg", "3s-8-12 Reg", "4s-8-12 Reg"];window = [-6000 2000]; FFTWin = [0, 1000];ICI2 = [12 12 12 12 12];
    case "clickTrainLongTerm_Rhythm_1824_1o522o5"
        stimStr = ["18-27 Reg", "18-36 Reg", "18-45 Reg", "24-36 Reg", "24-48 Reg","24-60 Reg"];window = [-4000 3000];  FFTWin = [0, 2000];  ICI2 = [27,36,45,36,48,60];
    case "clickTrainLongTerm_Rhythm_1824_1o522o5Rev"
        stimStr = ["27-18 Reg", "36-18 Reg", "45-18 Reg", "36-24 Reg", "48-24 Reg","60-24 Reg"];window = [-4000 3000];  FFTWin = [0, 2000];  ICI2 = [18,18,18,24,24,24];
    case "clickTrainLongTerm_Rhythm_1824_1100"
        stimStr = ["18-18 Reg", "18-18000 Reg", "24-24 Reg", "24-2400 Reg"];window = [-4000 3000];  FFTWin = [0, 2000];  ICI2 = [18,1800,24,2400];
    case "clickTrainLongTerm_Var_4_6"
        stimStr = ["4-6-10 Irreg", "4-6-25 Irreg", "4-6-50 Irreg", "4-6-100 Irreg", "4-6-200 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 3, 3, 3, 3];
    case "clickTrainLongTerm_Var_6_9"
        stimStr = ["6-9-10 Irreg", "6-9-25 Irreg", "6-9-50 Irreg", "6-9-100 Irreg", "6-9-200 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [4, 4, 4, 4, 4];
    case "clickTrainLongTerm_Var_8_12"
        stimStr = ["8-12-10 Irreg", "8-12-25 Irreg", "8-12-50 Irreg", "8-12-100 Irreg", "8-12-200 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [4, 4, 4, 4, 4];
    case "clickTrainLongTerm_RegInIrreg_03_2_3"   
        stimStr = ["2-3 Reg", "3-2 Reg", "2-3-0 Irreg", "3-2-0 Irreg", "2-3-3 Irreg", "3-2-3 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 2, 3, 2, 3, 2];
    case "clickTrainLongTerm_RegInIrreg_03_4_6" 
        stimStr = ["4-6 Reg", "6-4 Reg", "4-6-0 Irreg", "6-4-0 Irreg", "4-6-3 Irreg", "6-4-3 Irreg"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [4, 6, 4, 6, 4, 6];
    case "clickTrainLongTerm_RegIrreg_Change_2_3"   
        stimStr = ["2-3 Reg", "3-2 Reg", "2-3 Change", "3-2 Change"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 2, 3, 2];
    case "clickTrainLongTerm_RegIrreg_Change_4_6"   
        stimStr = ["4-6 Reg", "6-4 Reg", "4-6 Change", "6-4 Change"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [4, 6, 4, 6];
    case "clickTrainLongTerm_RegIrreg_Norm_2_3"   
        stimStr = ["2-3 Reg", "3-2 Reg", "2-3 Norm", "3-2 Norm"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [3, 2, 3, 2];
    case "clickTrainLongTerm_RegIrreg_Norm_4_6"   
        stimStr = ["4-6 Reg", "6-4 Reg", "4-6 Norm", "6-4 Norm"];window = [-6000 2000]; FFTWin = [0, 1000];  ICI2 = [4, 6, 4, 6];
    case "clickTrainLongTerm_Tone_500250_1o051o5"
        stimStr = ["500-492 Reg", "250-246 Reg", "500-333 Reg", "250-166 Reg"];window = [-6000 2000];  FFTWin = [0, 1000];  ICI2 = [492, 246, 333, 166];
    case "clickTrainLongTerm_TITS_16_40"   
        stimStr = ["16-16 Reg", "16-40 Reg", "40-16 Reg"];window = [-4000 3000];  FFTWin = [0, 2000];  ICI2 = [16,40,16];
    case "clickTrainLongTerm_TITS_Offset_12_Reg_Irreg_DiffDur"   
        stimStr = ["250ms-12-Reg" "500ms-12-Reg" "1000ms-12-Reg" "2000ms-12-Reg" "4000ms-12-Reg" "250ms-12-Irreg" "500ms-12-Irreg" "1000ms-12-Irreg" "2000ms-12-Irreg" "4000ms-12-Irreg" "250ms-Noise" "500ms-Noise" "1000ms-Noise" "2000ms-Noise" "4000ms-Noise"];window = [-3000 3000];  FFTWin = [0, 2000];  ICI2 = [12,12,12,12,12,12,12,12,12,12,12,12,12,12,12];
    case "clickTrainLongTerm_TITS_Offset_12_16_24_Reg_Irreg_Rep"
        stimStr = ["2s-2s-12-Reg-Rep" "2s-2s-12-Irreg-Rep" "2s-2s-16-Reg-Rep" "2s-2s-16-Irreg-Rep" "2s-2s-24-Reg-Rep" "2s-2s-24-Irreg-Rep"];window = [-3000 3000];  FFTWin = [0, 2000];  ICI2 = [12,12,16,16,24,24];
    case "clickTrainLongTerm_Ratio_2_3"
        stimStr = ["3s-2-3 Reg"];window = [-4000 2000];  FFTWin = [0, 1000];  ICI2 = [3];
    case "clickTrainLongTerm_Offset_2_128_4s"
        stimStr = ["4s-1 Reg" "4s-2 Reg" "4s-4 Reg" "4s-8 Reg" "4s-16 Reg" "4s-32 Reg" "4s-64 Reg" "4s-128 Reg" "500ms-8" "4s-noise" "4s-15899"];window = [-5000 1000];  FFTWin = [0, 1000];  ICI2 =[1,2,4,8,16,32,64,128,500];
    case "clickTrainLongTerm_Offset_256_512_10s"
        stimStr = ["4s-256 Reg" "4s-512 Reg"];window = [-11000 1000];  FFTWin = [0, 1000];  ICI2 =[256,512];
    case "clickTrainLongTerm_Offset_Duration_Effect_2ms_Reg"
        stimStr = ["D-1024ms-2 Reg" "D-256ms-2 Reg" "D-128ms-2 Reg" "D-64ms-2 Reg" "D-32ms-2 Reg" "D-16ms-2 Reg" "D-8ms-2 Reg" "D-4ms-2 Reg"  "D-512ms-2 Reg" "D-128ms noise" "D-1024ms noise"];window = [-2000 1000];  FFTWin = [0, 1000];  ICI2 =[2,2,2,2,2,2,2,2,2,2,2];
    case "clickTrainLongTerm_Offset_Variance_Effect_2ms_16ms_sigma250_2_Reg"
        stimStr = ["16ms_Var2" "16ms_Var10" "16ms_Var50" "16ms_Var250" "500ms-16ms Reg" "2ms_Var2" "2ms_Var10" "2ms_Var50" "2ms_Var250" "500ms-2ms Reg"];window = [-1500 1000];  FFTWin = [0, 1000];  ICI2 =[16,16,16,16,16,4,4,4,4,4];
    case "clickTrainLongTerm_Offset_Duration_Effect_16ms_Reg"
        stimStr = ["D-1024ms-16 Reg"  "D-512ms-16 Reg" "D-256ms-16 Reg" "D-128ms-16 Reg" "D-64ms-16 Reg" "D-32ms-16 Reg" "D-16ms-16 Reg" "D-8ms-16 Reg" "D-4ms-16 Reg" "D-128ms noise" "D-1024ms noise"];window = [-2000 1000];  FFTWin = [0, 1000];  ICI2 =[16,16,16,16,16,16,16,16,16];
    case "clickTrainLongTerm_Offset_Duration_Effect_4ms_Reg"
        stimStr = ["D-1024ms-4 Reg"  "D-512ms-4 Reg" "D-256ms-4 Reg" "D-128ms-4 Reg" "D-64ms-4 Reg" "D-32ms-4 Reg" "D-16ms-4 Reg" "D-8ms-4 Reg" "D-4ms-4 Reg" "D-128ms noise" "D-1024ms noise"];window = [-2000 1000];  FFTWin = [0, 1000];  ICI2 =[2,2,2,2,2,2,2,2,2,2,2];
    case "clickTrainLongTerm_Offset_Variance_Effect_4ms_8ms_sigma250_2_Reg"
        stimStr = ["8ms_Var2" "8ms_Var10" "8ms_Var50" "8ms_Var250" "500ms-8ms Reg" "4ms_Var2" "4ms_Var10" "4ms_Var50" "4ms_Var250" "500ms-4ms Reg"];window = [-1500 1000];  FFTWin = [0, 1000];  ICI2 =[8,8,8,8,8,4,4,4,4,4];
    case "clickTrainLongTerm_Offset_Duration_Effect_8ms_Reg"
        stimStr = ["D-1024ms-8 Reg"  "D-512ms-8 Reg" "D-256ms-8 Reg" "D-128ms-8 Reg" "D-64ms-8 Reg" "D-32ms-8 Reg" "D-16ms-8 Reg" "D-8ms-8 Reg" "D-128ms noise" "D-1024ms noise"];window = [-2000 1000];  FFTWin = [0, 1000];  ICI2 =[8,8,8,8,8,8,8,8];

end




