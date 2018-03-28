function [BBE] = EyeDetector(image)

%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

%Read the input image
%I = imread('E:\CS_Level_3\CS3072-3605-FYP2\TestImages\test1.jpg');

BBE=step(EyeDetect,image);

% figure,
% imshow(image);
% 
% hold on
% %disp(BBE)
% 
% for i = 1:size(BBE,1)
%     
%     rectangle('Position',BBE(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
%     
% end

% title('Eyes Detection');
% %savefig('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\eyesimg1.fig');
% %img = openfig('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\eyesimg1.fig');
% %saveas(img,'E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\eyesimg.jpg');
% %DeleteFigs;
% 
% %BBCount
% 
% hold off;