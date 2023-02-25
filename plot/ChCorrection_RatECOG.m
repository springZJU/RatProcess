function dataNew = ChCorrection_RatECOG(data)
    remapFile = strcat(fileparts(mfilename("fullpath")), "\ch_validate_1_32.xlsx");
    temp = sortrows(table2array(readtable(remapFile)), 3);
    remapIdx = temp(:, 1);
    dataNew = zeros(size(data, 1), size(data, 2));
    for i = 1 : size(data, 1)
        dataNew(i, :) = data(remapIdx(i), :);
    end
end