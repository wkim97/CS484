%% HW3-d
% Generate the disparity map from two rectified images. Use NCC for the
% mathing cost function.
function d = calculate_disparity_map(img_left, img_right, window_size, max_disparity)
    % img_left, img_right = 640x1015 double

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    tic;
    [h, w] = size(img_left);
    temp = zeros([h, w, max_disparity]);
    half = floor(window_size/2);
    
    for i = 1+half:h-half
        for j = 1+half:w-half
            for d = 1:min(max_disparity, w-j-half)
                window_A = img_left(i-half:i+half, j-half:j+half);
                window_B = img_right(i-half:i+half, j-half+d:j+half+d);
                if isequal(window_A, zeros(window_size, window_size)) || isequal(window_B, zeros(window_size, window_size))
                    continue
                else 
                    A = window_A - mean2(window_A);
                    B = window_B - mean2(window_B);
                    denom_A = A.^2;
                    denom_B = B.^2;
                    comp_A = A./sqrt(sum(denom_A(:)));
                    comp_B = B./sqrt(sum(denom_B(:)));
                    temp(i,j,d) = sum(sum(comp_A.*comp_B),2);
                end
            end
        end
    end
    
    cost_vol = zeros(h,w);
    for i = 1:h
        for j = 1:w
            max_d = 0;
            for d = 1:max_disparity
                if temp(i,j,d) >= max_d
                    max_d = temp(i,j,d);
                end
            end
            cost_vol(i,j) = max_d;
        end
    end 
    toc;
    d = cost_vol;

end
