clc

%function image = WatershedImageTesting(rgb)

% Reading in the image, and turning it into grayscale
rgb = imread('E:\CS_Level_3\CS3072-3605-FYP3\TestImages\test10.jpg');
	%rgb = imread('coins.jpg');
    
% Either/OR
I = rgb2gray(rgb);
    %imshow(I)
%I = rgb; % Use this if input image is already grayscaled

% Not too sure what this is..
text(732,501,'Image courtesy of Corel(R)',...
     'FontSize',7,'HorizontalAlignment','right')
 
% Sobel edge marks - imfilter. Higher gradient in the outer borders
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
%figure
%imshow(gradmag,[]);
title('Gradient magnitude (gradmag)');

% This brings errors. Cannot apply watershed directly on gradient magnitude

%L = watershed(gradmag);
%Lrgb = label2rgb(L);
%figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')

% Marking the foreground object. 
% The Opening version

se = strel('disk', 20);
Io = imopen(I, se);
%figure
%imshow(Io), title('Opening (Io)')

% The Opening by reconstruction

Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
%figure
imshow(Iobr), title('Opening-by-reconstruction (Iobr)')

% SAVING THE IMAGE
%imwrite(Iobr,'C:\Users\deepa\Desktop\CS3072-3605-FYP\watershedIobr.jpg','jpg');
imwrite(Iobr,'E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\watershedIobr.jpg','jpg');

% The Closing version

Ioc = imclose(Io, se);
%figure
%imshow(Ioc), title('Opening-closing (Ioc)')

% Opening and Closing morph, opening and closing values used here
% Key functions- imdilate and imreconstruct

Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
%figure
%imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

% SAVING THE IMAGE
%imwrite(Iobrcbr,'C:\Users\deepa\Desktop\CS3072-3605-FYP\watershedIob.jpg','jpg');
imwrite(Iobrcbr,'E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\watershedIob.jpg','jpg');

% Calculating the regional maxima of Iobrcbr

fgm = imregionalmax(Iobrcbr);
%figure
%imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')

% Superimposed version

I2 = I;
I2(fgm) = 255;
%figure
%imshow(I2), title('Regional maxima superimposed on original image (I2)')

% Closing and Erosion

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);

% Previous picture clean-up, bwareaopen

fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;
%figure
%imshow(I3)
%title('Modified regional maxima superimposed on original image (fgm4)')

% Marking background

bw = imbinarize(Iobrcbr);
%figure
%imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

% Watershed ridge lines

D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
%figure
%imshow(bgm), title('Watershed ridge lines (bgm)')

% Function imimposemin used to find desired regiinal minima

gradmag2 = imimposemin(gradmag, bgm | fgm4);

% Watershed segmentation

L = watershed(gradmag2);

% Superimposed version of image

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
%figure
%imshow(I4)
%title('Markers and object boundaries superimposed on original image (I4)')

% Colouring it in

Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
%figure
%imshow(Lrgb)
%title('Colored watershed label matrix (Lrgb)')

% Real life type coloured image

%figure
%imshow(I)
%hold on
%himage = imshow(Lrgb);
%himage.AlphaData = 0.3;
%title('Lrgb superimposed transparently on original image')

% https://uk.mathworks.com/help/images/examples/marker-controlled-watershed-segmentation.html