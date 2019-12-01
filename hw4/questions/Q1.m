image = imread('LaddObservatory2.jpg');
g_image = rgb2gray(image);
C = corner(g_image, 1000);
imshow(image)
hold on
plot(C(:,1),C(:,2),'r*');