function res = getPosAxis(posStr)
    for i = 1 : length(posStr)
        res(i, 1) = str2double(strrep(posStr{i}{1, 2}, 'o', '.'));
        res(i, 2) = str2double(strrep(posStr{i}{1, 3}, 'o', '.'));
    end
end

