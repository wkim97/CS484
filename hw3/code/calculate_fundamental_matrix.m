%% HW3-b
% Calculate the fundamental matrix using the normalized eight-point
% algorithm.
function f = calculate_fundamental_matrix(pts1, pts2) % pts1, pts2 = 8x2 double

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    % Normalize the points to get 3x8 npts1 and npts2
    l = length(pts1);
    center1 = [mean(pts1(:,1)) mean(pts1(:,2))]; 
    center2 = [mean(pts2(:,1)) mean(pts2(:,2))];
    center1 = repmat(center1, 8, 1); % Centroid of pts1
    center2 = repmat(center2, 8, 1); % Centroid of pts2
    
%     dist1 = sum((pts1 - center1).^2, 2);
%     mean_dist1 = mean(dist1); % Square mean distance of pts1 from center1
%     dist2 = sum((pts2 - center2).^2, 2);
%     mean_dist2 = mean(dist2); % Square mean distance of pts2 from center2
%     norm1 = [sqrt(2) / sqrt(mean_dist1), 0, (-sqrt(2) / sqrt(mean_dist1)) * center1(1,1);...
%              0, sqrt(2) / sqrt(mean_dist1), (-sqrt(2) / sqrt(mean_dist1)) * center1(2,2);...
%              0, 0, 1];
%     norm2 = [sqrt(2) / sqrt(mean_dist2), 0, (-sqrt(2) / sqrt(mean_dist2)) * center2(1,1);...
%              0, sqrt(2) / sqrt(mean_dist2), (-sqrt(2) / sqrt(mean_dist2)) * center2(2,2);...
%              0, 0, 1];
%          
    dist1 = sqrt(sum((pts1 - center1).^2, 2));
    mean_dist1 = mean(dist1); % Square mean distance of pts1 from center1
    dist2 = sqrt(sum((pts2 - center2).^2, 2));
    mean_dist2 = mean(dist2); % Square mean distance of pts2 from center2
    norm1 = [sqrt(2) / mean_dist1, 0, (-sqrt(2) / mean_dist1) * center1(1,1);...
             0, sqrt(2) / mean_dist1, (-sqrt(2) / mean_dist1) * center1(2,2);...
             0, 0, 1];
    norm2 = [sqrt(2) / mean_dist2, 0, (-sqrt(2) / mean_dist2) * center2(1,1);...
             0, sqrt(2) / mean_dist2, (-sqrt(2) / mean_dist2) * center2(2,2);...
             0, 0, 1];
         
%     mean1 = mean(pts1);
%     center1 = pts1 - repmat(mean1, [size(pts1, 1), 1]);
%     var1 = var(center1);
%     sd1 = sqrt(var1);
%     norm1 = [sqrt(2)/sd1(1), 0, 0; 0, sqrt(2)/sd1(2), 0; 0, 0, 1] * [1, 0, -sqrt(2)*mean1(1); 0, 1, -sqrt(2)*mean1(2); 0, 0, 1];
%     
%     mean2 = mean(pts2);
%     center2 = pts2 - repmat(mean2, [size(pts2, 1), 1]);
%     var2 = var(center2);
%     sd2 = sqrt(var2);
%     norm2 = [sqrt(2)/sd2(1), 0, 0; 0, sqrt(2)/sd2(2), 0; 0, 0, 1] * [1, 0, -sqrt(2)*mean2(1); 0, 1, -sqrt(2)*mean2(2); 0, 0, 1];
  
    npts1 = norm1 * (transpose([pts1 ones(l, 1)])); % 3x8 normalized pts1
    npts2 = norm2 * (transpose([pts2 ones(l, 1)])); % 3x8 normalized pts2
    
    % Implement eight point algorithm
    npts1 = [transpose(npts1(1,:)) transpose(npts1(2,:))];
    npts2 = [transpose(npts2(1,:)) transpose(npts2(2,:))];
    
%     test = 0;
%     for i = 1:8
%         test = test + sqrt(npts2(i,1)^2 + npts2(i,2)^2);
%     end
%     test/8
    
    x = npts1(:,1);
    y = npts1(:,2);
    xp = npts2(:,1);
    yp = npts2(:,2);
    A = [x.*xp x.*yp x y.*xp y.*yp y xp yp ones(l, 1)];
    [V,D] = eig(A'*A);
    F=reshape(V(:,1), 3, 3);
    [U,S,V] = svd(F);
    F = U*diag([S(1,1) S(2,2) 0])*V';
    F = norm2'*F*norm1;
    
    f = F;    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
