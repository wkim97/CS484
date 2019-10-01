function [hybrid_image,low_frequencies,high_frequencies] = gen_hybrid_image( image1, image2, cutoff_frequency )
% Inputs:
% - image1 -> The image from which to take the low frequencies.
% - image2 -> The image from which to take the high frequencies.
% - cutoff_frequency -> The standard deviation, in pixels, of the Gaussian 
%                       blur that will remove high frequencies.
%
% Task:
% - Use my_imfilter to create 'low_frequencies' and 'high_frequencies'.
% - Combine them to create 'hybrid_image'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
high_pass_image = my_imfilter(image1, filter);
low_frequencies = [high_pass_image];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
low_pass_image = my_imfilter(image2, filter);
low_pass_image = image2 - low_pass_image;
high_frequencies = [low_pass_image];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hybrid_image = [high_pass_image + low_pass_image];