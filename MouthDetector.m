function [BBM] = MouthDetector(image)

%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);

%Read the input image
%I = imread('E:\CS_Level_3\CS3072-3605-FYP2\TestImages\test1.jpg');

BBM=step(MouthDetect,image);
% BBCount = 0;

% figure,
% imshow(image); 
% hold on
% 
% for i = 1:size(BBM,1)
%     
%  rectangle('Position',BBM(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
% 
%  
% end

% %disp(BBM)
% title('Mouth Detection');
% 
% %('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\mouthimg1.fig');
% %img = openfig('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\mouthimg1.fig');
% %saveas(img,'E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\mouthimg.jpg');
% %DeleteFigs;
% 
% %BBCount
% hold off;