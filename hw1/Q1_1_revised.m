clear;

% tic;
A = imread('grizzlypeak.jpg');
B = A <= 10;
A(B) = 0;
% toc;
%imshow(A)