function [ img_result ] = medfilt2d( img_input, mask_size )
%   This is a MATLAB function
%   Detailed explanation goes here

%   Get dimension of original image
img = imread(img_input);
[img_row,img_col] = size(img);

%   Get filter dimension
filter_range = (mask_size-1)/2;

%2.3.1   Gaussian noise
%   Add noise to image
noise_gau_image = noiseGenerate(img,0,0,30);
imwrite(noise_gau_image, 'img_gaussian.png');

%   pad noised image with zero values
img_paded = zeros(size(noise_gau_image)+ mask_size-1);
img_paded(filter_range+1:end-filter_range,filter_range+1:end-filter_range) = noise_gau_image;

%   Apply median filter
img_result = uint8(zeros(img_row, img_col));
for i = 1:img_row
    for j = 1:img_col
        mask = sort(reshape(img_paded(i:i+2*filter_range,j:j+2*filter_range),[1,mask_size*mask_size]));
        img_result(i,j) = uint8(mask((mask_size*mask_size+1)/2));
    end
end

imwrite(img_result, 'med_gaussian.png');

%2.3.2   salt_and_pepper noise
%   Add noise to image
noise_sap_image = noiseGenerate(img,1,0.3,0.3);
imwrite(noise_sap_image, 'img_sp.png');

%   pad noised image with zero values
img_sap_paded = zeros(size(noise_sap_image)+ mask_size-1);
img_sap_paded(filter_range+1:end-filter_range,filter_range+1:end-filter_range) = noise_sap_image;


%   Apply median filter
img_sap_result = uint8(zeros(img_row, img_col));
for i = 1:img_row
    for j = 1:img_col
        mask = sort(reshape(img_sap_paded(i:i+2*filter_range,j:j+2*filter_range),[1,mask_size*mask_size]));
        img_sap_result(i,j) = uint8(mask((mask_size*mask_size+1)/2));
    end
end

imwrite(img_sap_result, 'med_sp.png');


end

