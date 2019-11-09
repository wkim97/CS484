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
    r1 = imwarp(img1, hform1);
    hform2 = projective2d(h2);
    r2 = imwarp(img2, hform2);
%     figure(2); imshow(r1);
%     figure(3); imshow(r2);
    
    rectified1 = r1;
    rectified2 = r2;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
