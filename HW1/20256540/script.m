%   Average filter, 5X5
average_filter = 1/25*ones(5);
imwrite(filter_spa( '40.png',average_filter ), 'img_ave.png');

%   Sobel operator
Sobel_operator_Gx = [-1 0 1;-2 0 2;-1 0 1];
Sobel_operator_Gy = [-1 -2 -1;0 0 0;1 2 1];
imwrite(filter_spa( '40.png',Sobel_operator_Gx ), 'img_dy.png');
imwrite(filter_spa( '40.png',Sobel_operator_Gy ), 'img_dx.png');

%   Laplacian filter
Laplacian_filter = [-1 -1 -1;-1 8 -1;-1 -1 -1];
imwrite(filter_spa( '40.png',Laplacian_filter ), 'img_sharpen.png');