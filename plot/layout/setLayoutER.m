
temIMG = imread("ER1.jpg");
ER1_square = temIMG(1:3:end, 1:3:end, :);
save('layout.mat', "ER1_square");
