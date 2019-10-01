clear; 
hpf = [-1 -1 -1; -1 8 -1; -1 -1 -1];
lpf = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];

image = imread('RISDance.jpg');
HPF = imfilter(image, hpf, 'same');
LPF = imfilter(image, lpf, 'same');
imwrite(HPF, 'HPF.jpg');
imwrite(LPF, 'LPF.jpg');