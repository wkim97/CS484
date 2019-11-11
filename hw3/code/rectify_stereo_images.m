%% HW3-c
% Given two homography matrices for two images, generate the rectified
% image pair.
function [rectified1, rectified2] = rectify_stereo_images(img1, img2, h1, h2) % img1, img2 = MxNx3 image file, h1, h2 = 3x3 homography matrix
                                                                              % returns [MxNx3 MxNx3] image matrix

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here

    % Hint: Note that you should care about alignment of two images.
    % In order to superpose two rectified images, you need to create
    % certain amount of margin.
    
    hform1 = projective2d(h1);
    hform2 = projective2d(h2);
    s = size(img1);
    corners = [1, 1; s(2), 1; 1, s(1); s(2), s(1)];
    dim1 = zeros(4,2);
    dim2 = zeros(4,2);
    dim1 = transformPointsForward(hform1, corners);
    dim2 = transformPointsForward(hform2, corners);
    dim = [dim1(:,2), dim1(:,1) ; dim2(:,2), dim2(:,1)];
    x_min = floor(min(dim(:,1)));
    x_max = ceil(max(dim(:,1)));
    y_min = floor(min(dim(:,2)));
    y_max = ceil(max(dim(:,2)));
    
    r1 = imwarp(img1, hform1, 'OutputView', imref2d([(x_max-x_min), (y_max-y_min)], [y_min y_max], [x_min x_max]));
    r2 = imwarp(img2, hform2, 'OutputView', imref2d([(x_max-x_min), (y_max-y_min)], [y_min y_max], [x_min x_max]));

    rectified1 = r1;
    rectified2 = r2;    
end
