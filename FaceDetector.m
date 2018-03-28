function [BBF] = FaceDetector(image)

% To detect Face
FDetect = vision.CascadeObjectDetector;

% Read the input image
% image = imread('E:\CS_Level_3\CS3072-3605-FYP2\TestImages\test1.jpg');

% Returns Bounding Box values based on number of objects
BBF = step(FDetect,image);
% BBCount = 0;
% 
% figure,
% imshow(image); 
% hold on
% BBF
% % Displaying detected faces
% for i = 1:size(BBF,1) 
%     rectangle('Position',BBF(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
%     BBCount = BBCount +1;
% end

% Saving the output image
% savefig('E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\faceimg1.fig');
% img = openfig('E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\faceimg1.fig');
% saveas(img,'E:\CS_Level_3\CS3072-3605-FYP3\OutputImages\faceimg.jpg');
% DeleteFigs;

%BBCount;
%hold off;
