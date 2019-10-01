clear;

% tic;
A = imread('grizzlypeak.jpg');
[m1, n1] = size(A);
for i = 1: m1
    for j = 1 : n1
        if A(i, j) <= 10
            A(i, j) = 0;
        end
    end
end
% toc;
% imshow(A) 