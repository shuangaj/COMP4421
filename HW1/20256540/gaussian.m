function [ f ] = gaussian( size, cutoff )
%   This is a MATLAB function
%   Detailed explanation goes here

f = zeros(size);
cen_x = size(1)/2;
cen_y = size(2)/2;
for i = 1:size(1)
    for j = 1:size(2)
        f(i,j) = 1 - exp(-(((((i-cen_x)/cen_x)*0.5)^2+(((j-cen_y)/cen_y)*0.5)^2)/(2*cutoff^2)));
    end
end

end

