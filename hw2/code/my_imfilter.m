function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% when operating in convolution mode. See 'help imfilter'. 
% While "correlation" and "convolution" are both called filtering, 
% there is a difference. From 'help filter2':
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.
 
% Your function should meet the requirements laid out on the project webpage.

% Boundary handling can be tricky as the filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% we look at 'help imfilter', we see that there are several options to deal 
% with boundaries. 
% Please recreate the default behavior of imfilter:
% to pad the input image with zeros, and return a filtered image which matches 
% the input image resolution. 
% A better approach is to mirror or reflect the image content in the padding.

% Uncomment to call imfilter to see the desired behavior.
% output = imfilter(image, filter, 'conv');

%%%%%%%%%%%%%%%%
% Your code here
filter_size = size(filter);
if rem(filter_size(1), 2) == 0 || rem(filter_size(2), 2) == 0
    error("Error: even-sized filter!"); % Error message for even sized filters
end

filter_row = floor(filter_size(1)/2);
filter_col = floor(filter_size(2)/2);

image_size = size(image);
pimage = padarray(image, [filter_row, filter_col]);
pimage_size = size(pimage);
pfilter = zeros(pimage_size(1), pimage_size(2));
pfilter(1:filter_size(1), 1:filter_size(2)) = filter;
ret = zeros(image_size);

for k = 1:image_size(3)
    f_image = fft2(pimage(:,:,k));
    f_filter = fft2(pfilter);
    padded_conv = ifft2(f_image .* f_filter);
    ret(:,:,k) = padded_conv(2 * filter_row + 1 : pimage_size(1), ...
         2 * filter_col + 1 : pimage_size(2));
end 

output = ret;

%%%%%%%%%%%%%%%%

