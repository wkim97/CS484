% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'descriptor_window_image_width', in pixels.
%   This is the local feature descriptor width. It might be useful in this function to 
%   (a) suppress boundary interest points (where a feature wouldn't fit entirely in the image, anyway), or
%   (b) scale the image filters being used. 
% Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, descriptor_window_image_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% Placeholder that you can delete -- random points
% x = ceil(rand(500,1) * size(image,2));
% y = ceil(rand(500,1) * size(image,1));


% After computing interest points, here's roughly how many we return
% For each of the three image pairs
% - Notre Dame: ~1300 and ~1700
% - Mount Rushmore: ~3500 and ~4500
% - Episcopal Gaudi: ~1000 and ~9000

cell_size = descriptor_window_image_width/2;

% 1. Compute image derivatives
filter_x = [1 0 -1; 2 0 -2; 1 0 -1];
filter_y = [1 2 1; 0 0 0; -1 -2 -1];
Ix = imfilter(image, filter_x);
Iy = imfilter(image, filter_y);

% 2. Compute M components as squares of derivatives
Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;

% 3. Apply a Gaussian filter
G = fspecial('gaussian', [cell_size/2,cell_size/2], 2); % To be experimented around
Ixx = imfilter(Ixx, G);
Iyy = imfilter(Iyy, G);
Ixy = imfilter(Ixy, G);

% 4. Compute cornerness
alpha = 0.06; % Also to be experimented around
threshold = 0.01; % Also to be experimented around
C = (Ixx.*Iyy - Ixy.*Ixy) - alpha*(Ixx+Iyy).*(Ixx+Iyy); % det(A) - alpha*trace(A)^2

% 5. Threshold on C to pick high cornerness
thres_block = (C > threshold);
C = C.*thres_block;

% 6. Non-maximaa suppression to pick peaks
maxC = colfilt(C, [4, 4], 'sliding', @max);
result = (C == maxC);
C = C.*result;
[y, x] = find(C);

end

