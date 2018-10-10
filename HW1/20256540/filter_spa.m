function [ img_result ] = filter_spa( img_input,filter )
%   This is a MATLAB function
%   Detailed explanation goes here

%   Get dimension of original image
img = imread(img_input);
[img_row,img_col] = size(img);

%   Get filter dimension
[filter_row,~] = size(filter);
filter_range = (filter_row-1)/2;

%   Pad original image with zero values
img_paded = zeros(size(img)+filter_row-1);
img_paded(filter_range+1:end-filter_range,filter_range+1:end-filter_range) = img;
img_result = uint8(zeros(img_row, img_col));
%   Convolution

for i = 1:img_row
    for j = 1:img_col
        img_result(i,j) = uint8(round(sum(sum(img_paded(i:i+2*filter_range,j:j+2*filter_range).*filter))));
    end
end

%   bonus part
%   The following part is one loop version of convolutuion
%{
total_length = img_row*img_col;
for i = 1:total_length
    if mod(i,img_col) == 0
        col = img_col;
        row = floor(i/img_col);
    else 
        col = mod(i,img_col);
        row = floor(i/img_col)+1;
    end
    img_result(row,col) = uint8(round(sum(sum(img_paded(row:row+2*filter_range,col:col+2*filter_range).*filter))));
end
%}
end

 