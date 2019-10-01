tic;
A = imread('grizzlypeakg.png');
f = [1 0 -1; 2 0 -2; 1 0 -1];
h = imfilter(A, f, 'conv');
toc;
imshow(h)