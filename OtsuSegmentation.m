clc
%function image = SmallOtsu(X)

 X = imread('E:\CS_Level_3\CS3072-3605-FYP3\TestImages\test10.jpg');
 imshow(X);
 IDX = otsu(X,2);
 otsuimg = uint8(IDX*75);
 imshow(otsuimg)

 imwrite(otsuimg,'E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\otsuimg.jpg','jpg');
 