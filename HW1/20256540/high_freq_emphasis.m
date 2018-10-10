function [ img_result ] = high_freq_emphasis( img_input, a, b, type )
%   This is a MATLAB function
%   Detailed explanation goes here

%   FFT of original image
img = imread(img_input);
img_size = size(img);
fft_img = fft2(img);
fft_img = fftshift(fft_img);

%   Butterworth filter
if strcmp(type,'butterworth')
    but_filter = butterworth(img_size, 0.1, 1);
    img_result = uint8(real(ifft2(ifftshift(fft_img.*(but_filter*b+a)))));
    name = sprintf('butter_emphasis_%g_%g.png',a,b);
    imwrite(img_result, name);
end

%   Gaussian filter
if strcmp(type,'gaussian')
    gau_filter = gaussian( img_size, 0.1 );
    img_result = uint8(real(ifft2(ifftshift(fft_img.*(gau_filter*b+a)))));
    name = sprintf('gaussian_emphasis_%g_%g.png',a,b);
    imwrite(img_result, name);
end

end

