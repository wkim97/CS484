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
    error("Error: even-sized filter!");
end

filter = rot90(filter, 2);
filter_row = floor(filter_size(1)/2);
filter_col = floor(filter_size(2)/2);

image_size = size(image);
image = padarray(image, [filter_row, filter_col]);
ret = zeros(image_size);

for i = filter_row + 1:image_size(1) + filter_row
    for j = filter_col + 1:image_size(2) + filter_col
        temp = image(i - filter_row:i + filter_row, j - filter_col:j + filter_col, :) .* filter;
        ret(i - filter_row, j - filter_col, :) = sum(sum(temp, 1), 2);
    end
end 

% for k = 1:image_size(3)
%     col = im2col(image(:,:,k), [filter_size(1), filter_size(2)]);
%     filtered_col = filter2 * col;
%     ret(:,:,k) = col2im(filtered_col, [filter_row, filter_col], [image_size(1), image_size(2)]);
% end
% 
output = ret;



%%%%%%%%%%%%%%%%

