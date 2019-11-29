% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'descriptor_window_image_width', in pixels, is the local feature descriptor width. 
%   You can assume that descriptor_window_image_width will be a multiple of 4 
%   (i.e., every cell of your local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations, then you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, descriptor_window_image_width)

% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)
% features = double(zeros(length(x), 128));
% for p = 1:length(x)
%     q = 1;
%     for i = -8:7
%         for j = -8:7
%             features(p,q) = image(y(p)+j,x(p)+i);
% %             image(y(p)+j, x(p)+i)
% %             features(p,q)
%             q = q + 1;
%         end
%     end
% %     features(p,:)
%     features(p,:) = features(p,:)/norm(features(p,:),2);
% %     features(p,:)
% end

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each descriptor_window_image_width/4. 'cell' in this context
%    nothing to do with the Matlab data structue of cell(). It is simply
%    the terminology used in the feature literature to describe the spatial
%    bins where gradient distributions will be described.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length

cell_size = descriptor_window_image_width/4;
features = double(zeros(length(x), descriptor_window_image_width));
theta_range = -pi:pi/4:pi;
[M, N] = size(image);
for p = 1:length(x)
    if (x(p)-8 > 1 && y(p)-8 > 1 && x(p)+7 < N && y(p)+7 < M)
        cell_num = 1;
        for c1 = 1:4
            for c2 = 1:4
                theta = zeros(16,1);
                mag = zeros(16,1);
                index = 1;
                for i = -8+cell_size*(c1-1) : -8+cell_size*c1-1
                    for j = -8+cell_size*(c2-1) : -8+cell_size*c2-1
                        x_grad = image(y(p)+i,x(p)+j+1) - image(y(p)+i,x(p)+j-1);
                        y_grad = image(y(p)+i+1,x(p)+j) - image(y(p)+i-1,x(p)+j);
                        theta(index) = atan2(y_grad,x_grad); % 16x1 theta values
                        mag(index) = sqrt(x_grad^2 + y_grad^2); % 16x1 magnitude values
                        [~,theta_inds] = histc(theta,theta_range); % 16x1 theta indices
                        index = index+1;
                    end
                end
                
                feat_theta = zeros(8,1);
                for t=1:length(theta_inds)
                    theta_val = theta_inds(t);
                    if (theta_val == 0)
                        feat_theta(1) = feat_theta(1) + mag(t);
                    else
                        feat_theta(theta_val) = feat_theta(theta_val) + mag(t);
                    end
                end
                features(p,8*(cell_num-1)+1:8*(cell_num)) = feat_theta;
                cell_num = cell_num + 1;
            end
        end
    end
end

%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

%Placeholder that you can delete. Empty features.
% features = zeros(size(x,1), 128, 'single');
end








