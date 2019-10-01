clear;

I = im2double( imread('gigi.jpg') );
I = I - 20/255;
imshow(I);
imwrite(I, 'D:\KAIST\2019 가을\CS484 컴퓨터비전개론\Homework\hw1\fixedgigi.jpg');