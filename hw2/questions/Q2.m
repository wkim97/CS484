clear;

kernel = [8 1 6; 3 5 7; 4 9 2];
image = zeros(5);
image(:) = 1:25;

corr_output = imfilter(image, kernel);
conv_output = imfilter(image, kernel, 'conv');
conv_output
corr_output

 
