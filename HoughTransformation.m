clc
%function image = HoughWorking(I)
I = imread('E:\CS_Level_3\CS3072-3605-FYP3\TestImages\test10.jpg');

grayImg = rgb2gray(I); 
%grayImg = I; % If image is already grayscaled

% Finding the edge using the edge function
BW = edge(grayImg, 'canny');

%[H,theta,rho] = hough(BW); % Prints the lines of the image
imshow(BW)
imwrite(BW,'E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\houghimg.jpg','jpg');


