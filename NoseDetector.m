function [BBN] = NoseDetector(image)

%To detect Nose
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);

%Read the input image
%I = imread('E:\CS_Level_3\CS3072-3605-FYP2\TestImages\test1.jpg');

BBN=step(NoseDetect,image);

% figure,
% imshow(image); 
% hold on
% %disp(BBN)
% 
% for i = 1:size(BBN,1)
%     
%     rectangle('Position',BBN(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
% 
% end


% title('Nose Detection');
% 
% %savefig('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\noseimg1.fig');
% %img = openfig('E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\noseimg1.fig');
% %saveas(img,'E:\CS_Level_3\CS3072-3605-FYP2\OutputImages\noseimg.jpg');
% %DeleteFigs;
% 
% %BBCount
% 
% 
% hold off;