function trueFalse = needCorrection(DateStr)
    wrongDays = ["20221110", "20221112", "20221114", "20221115", "20221117"];
    if contains(DateStr, wrongDays)
        trueFalse = true;
    else
        trueFalse = false;
    end
end
