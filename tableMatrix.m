function [nameOfNewMatrix] = tableMatrix(nameOfOldMatrix, nameOfNewMatrix, BBType)

% Index Count Initialization
indexCount = 0;


for i = 1:size(nameOfOldMatrix,1) 
    
% First 4 Values (Original BB generated values)
    
    % Extracting the x,1 coordinates;
    x1=nameOfOldMatrix(i:i,1);
    y1=nameOfOldMatrix(i:i,2);
    
    % Initializing the values to the new list
    nameOfNewMatrix(i:i,1)=x1;
    nameOfNewMatrix(i:i,2)=y1;
    
    % Extracting width & height
    w1=nameOfOldMatrix(i:i,3);
    h1=nameOfOldMatrix(i:i,4);
    
    % Initializing the values to the new list
    nameOfNewMatrix(i:i,3)=w1;
    nameOfNewMatrix(i:i,4)=h1;
    
    % x2 & y2 values        
    x2=x1+w1;
    y2=y1+h1;
    
    nameOfNewMatrix(i:i,5)=x2;
    nameOfNewMatrix(i:i,6)=y2;
    
    % The BB type will be useful to identify when FaceRec &
    % BBComRec lists are combined
    % The amount of runs will identify which list is FaceRec and
    % which is feature (only 2 runs be used by this script)
    
    if BBType ==1 
    nameOfNewMatrix(i:i,7)=1;
    else
        nameOfNewMatrix(i:i,7)=2;
    end
    
    % Calculating the Area using width and height
    nameOfNewMatrix(i:i,8) = w1*h1;
    
%     % The index value will be useful to identify when 
%     % FaceRec & BBComRec lists are combined
%     indexCount= indexCount+1;
%     nameOfNewMatrix(i:i,9)= indexCount;
    
    % Calculation the centre point coordinates, will be 
    % useful to compare distance between other BB's
     nameOfNewMatrix(i:i,9)=((w1+x1)/2); 
     nameOfNewMatrix(i:i,10)=((h1+y1)/2); 
  
end


 %colNames = {'x1','y1','w1','h1','x2','y2','BBtype','Index','Area','x1CentrePoint','y1CentrePoint'};
 %sTable = array2table(nameOfNewMatrix,'VariableNames',colNames)


