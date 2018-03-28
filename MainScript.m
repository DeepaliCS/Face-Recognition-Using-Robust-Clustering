
clc
% This the main script - Prototype

%_____________________________

% This is the image being tested
image =imread('E:\CS_Level_3\CS3072-3605-FYP3\TestImages\test13.jpg');

%Creating certain combination of bounding box (BB) Lists

BBF = FaceDetector(image); % BBF
BBE = EyeDetector(image); % BBE 
BBM = MouthDetector(image); % BBM
BBN = NoseDetector(image); %BBN


BBFaceRec = BBF;
BBComRec = [BBM;BBN;BBE];
%BBDisplay(BBComRec)

% This is the percentage thresholding. Will be useful for 
% Eliminating unnecessary BB's
alpha = 0.052;

%_____________________________

% Creating a table with all relevant data

% First the FaceList BB list (10 Columns)
FacesList = [0,0,0,0,0,0,0,0,0,0];

% BBType identifying it as face recognition
BBType = 1;

% Setting the variable names for better view of data
colNames = {'x1','y1','w1','h1','x2','y2','BBtype','Area','x1CentrePoint','y1CentrePoint'};

% Calling the function to calculate all details needed of a BB
%x1,y1,w1,h1,x2,y2,BBType,Area,Index,x1centreP,y1centreP
FacesList =tableMatrix(BBFaceRec, FacesList,BBType);
FaceDetectionBB = array2table(FacesList,'VariableNames',colNames)

% Do the same for Features List BB (10 Columns)
FeaturesList = [0,0,0,0,0,0,0,0,0,0];

BBType = 2;

% Calling the function to calculate all details needed of a BB
%x1,y1,w1,h1,x2,y2,BBType,Area,Index,x1centreP,y1centreP
FeaturesList=tableMatrix(BBComRec, FeaturesList, BBType);
FeaturesDetectionBB = array2table(FeaturesList,'VariableNames',colNames)

%_____________________________

% First Elimination Stage

% Checking the components against the Face recognition BB's
for i = 1:size(FacesList,1) 

    for j = 1:size(FeaturesList,1)

        % Variables for CoorInit Script/ Function
        ith =i;
        jth=j;
        
        CoorInit;
        CheckConditions;
        
        % sumCondition variable is from the CheckConditions Script
        if sumCondition ==4
            FeaturesList(j:j,:)= [0,0,0,0,0,0,0,0,0,0];
        end        
     
    end
end

FeaturesList;

% Cleaning list (Removing row containing 0's)
TempFeaturesList = [0,0,0,0,0,0,0,0,0,0];
for i = 1:size(FeaturesList,1)
    if FeaturesList(i:i,:) ~= [0,0,0,0,0,0,0,0,0,0]
             TempFeaturesList = [TempFeaturesList; FeaturesList(i:i,:)];        
    end
end

% Deleting the very first row of 0's
TempFeaturesList(1:1,:)= [];
FeaturesList = TempFeaturesList;

%disp('Elmination Stage 1 Complete: Containment')
%TempFeaturesList = array2table(FeaturesList,'VariableNames',colNames)

%_____________________________
% Elimination stage 2: Uneccessary Features BB near Faces BB
for i = 1:size(FacesList,1) 
    for j = i+1:size(FeaturesList,1)
        
     % Checking for intersections either 1,2,3   
     CheckConditions;
     if (sumCondition > 0) && (sumCondition < 4)

     % Identifying the areas column      
     area1= FacesList(i:i,8);
     area2 = FeaturesList(j:j,8);
     
     % Making number smaller to work with feasible values
     area1 = area1/10000; area2 = area2/10000;
         
     % Calculating percentage, Face Area (a1) is bigger
     multiplybyOneHundred=area1/area2;
     
     % Making number smaller to work with feasible values
     multiplybyOneHundred = multiplybyOneHundred/10000;
     
     % Final percentage value
     answer =multiplybyOneHundred*100;

     % If the answer is bigger than the threshold value
     % then it is to be deleted
     if answer >= alpha
         FeaturesList(j:j,:)= [0,0,0,0,0,0,0,0,0,0];
      end   
    end
  end
end
FeaturesList;

% Cleaning list (Removing row containing 0's)
TempFeaturesList = [0,0,0,0,0,0,0,0,0,0];
for i = 1:size(FeaturesList,1)
    if FeaturesList(i:i,:) ~= [0,0,0,0,0,0,0,0,0,0]
             TempFeaturesList = [TempFeaturesList; FeaturesList(i:i,:)];        
    end
end

% Deleting the very first row of 0's
TempFeaturesList(1:1,:)= [];
FeaturesList = TempFeaturesList;

%disp('Elmination Stage 2 Complete: Unnecessary OverLaps');
%TempFeaturesList = array2table(FeaturesList,'VariableNames',colNames)

% Setting variables for the next loop
DisplayList = [0,0,0,0];
newVector=[0,0,0,0];
x1=0;y1=0;w1=0;h1=0;

% Loops is to extract values useful to display the features
% (testing for thresholding)
for i = 1:size(FeaturesList,1)
    
    % Extracting values
    x1 =FeaturesList(i:i,1);
    y1 =FeaturesList(i:i,2);
    w1 =FeaturesList(i:i,3);
    h1 =FeaturesList(i:i,4);
    
    % Setting newVector insert as a row
    newVector = [x1,y1,w1,h1];
    
    % Inserting row in the DisplayList
    DisplayList = [DisplayList;newVector];
    
end

% Deleting the very first row of 0's
DisplayList(1:1,:)= [];

% Displaying the newly formed Features List
%BBDisplay(DisplayList);

%_____________________________

% Features that may represent the same face, Robust Clustering Input

% Calculating the average face size from face detection list
widthAverage = mean(FacesList(:,3)); % Average Width
heightAverage = mean(FacesList(:,4)); % Average Height


% Setting variables needed for next loop
saveFeaturesIndex = [0,0];
newVector = [0,0];

for i = 1:size(FeaturesList,1) 

    for j = i+1:size(FeaturesList,1)

        % Getting the distance between two features using centre-point metrics
        xdistance = abs((FeaturesList(i:i,9) -(FeaturesList(j:j,9))));
        ydistance = abs((FeaturesList(i:i,10) - FeaturesList(j:j,10)));
        
        % Add the pair in saveFeatureIndex if the distance is smaller than
        % average face size
        if (xdistance < widthAverage) && (ydistance < heightAverage)
            newVector = [i, j]; 
        end
        saveFeaturesIndex = [saveFeaturesIndex;newVector];
 
    end 
end

% Deleting the very first row of 0's
saveFeaturesIndex(1:1,:)= []
 
 % Creating a large variables list (will include duplications)
 variables = [saveFeaturesIndex(:,1);saveFeaturesIndex(:,2)];
 
 % Getting the size of the large variable list (duplications)
 Size = size(variables);
 Size = Size(:,1);
 
 % Sorting the list into an ascending order
 variables = sort(variables)
 
 % Initialising this variable to check duplicates in the variables list
 checkvalue = variables(i:i,1)

 % Returning a zero value for duplucate variable values
 for i = 1:Size
     
      for j = 1+1:Size
          
     % Set zero for duplicate values     
     if checkvalue == variables(j:j,1);
         variables(j:j,1) = 0;
     else 
         checkvalue = variables(j:j,1);
     end

     end 
 end 

  % Deleting the very first row of 0's 
  variables(1:1,:)= [];
 
  % Initialising newlist
 newlist = 0;
 
 % Getting the size of the new large variable list (with zeros)
 Size = size(variables);
 Size = Size(:,1);
 
 % Removing the zeros so only the variables remain in the list
  for i = 1:Size
      
    if (variables(i:i,1) ~= 0)
        newlist = [newlist; variables(i:i,1)];
    end
    
  end
  
  % Deleting the very first row of 0's 
  newlist(1:1,:)= [];
  variables = newlist;
  
  % newlist size
  Size = size(variables);
  variableSize = Size(:,1);
 
  % Creating cluster IDs (-1 means un-assigned)
  minusOneVector = -1;
  for i = 1:variableSize
      minusOneVector = [minusOneVector; -1]; 
  end
  minusOneVector;
  % Deleting the very first row of -1
  minusOneVector(1:1,:)= [];
 
  % Appending the variables with the cluster IDS
  clusterTable =[variables,minusOneVector]
  
 % Getting the size of variable pairs (saveFeaturesIndex) (column size)
 Size = size(saveFeaturesIndex);
 saveFeaturesIndexSize = Size(:,1);
 
  % clusterTable size (column size)
  Size = size(clusterTable);
  clusterTableSize = Size(:,1);
  
  % Initialising newCluster ID
  NC = -1;
  
  % Variables to save iteration Index
  itrj =0;
  itrk =0;
 
  % Robust Clustering
  
   % saveFeaturesIndex size (column size)
   for i = 1:saveFeaturesIndexSize
       
          % Extracting the pair values in saveFeaturesIndex
          rowVector = saveFeaturesIndex(i:i,:);
          
          % Value in the left column
          rowVector1 = rowVector(:,1);
          
          % Value in the right column
          rowVector2 = rowVector(:,2);

        % clusterTable size (row size)
        for j = 1:clusterTableSize
            
            % Find the value of the saveFeaturesIndex in to the
            % clusterTable
            if rowVector1 == clusterTable(j:j,1)

                % Save the clusterID of this value
                clusterID1 = clusterTable(j:j,2);
                
                % Initialising the iteration index for future operations
                % (left valaue of the pair in the saveFeaturesIndex)
                itrj = j;
            end
            
        end
        
        % clusterTable size (row size)
        for k = 1:clusterTableSize
            
            % Find the value of the saveFeaturesIndex in to the
            % clusterTable
            if rowVector2 == clusterTable(k:k,1)

                % Save the clusterID of this value
                clusterID2 = clusterTable(k:k,2);

                % Initialising the iteration index for future operations
                % (right valaue of the pair in the saveFeaturesIndex)
                itrk = k;
            end
            
        end
        
         % If both variables (pair) are assigned (-1), make an assingment
            if clusterID1== -1 && clusterID2== -1
                %disp('YES')
                
                % Iterating clusterID
                NC = NC +1;
                
                % Initialising new clusterID 
                clusterTable(itrj:itrj,2) = NC;
                clusterTable(itrk:itrk,2) = NC;
            end
     
         % If clusterID1 is in another cluster then put in the same cluster
         if clusterID1 > -1 && clusterID2 == -1
             %disp('here1')
             clusterTable(itrk:itrk,2) = clusterTable(itrj:itrj,2);
         end
   
         % If clusterID2 is in another cluster then put in the same cluster
         if clusterID2 > -1 && clusterID1 == -1
             clusterTable(itrj:itrj,2) = clusterTable(itrk:itrk,2);
         end
        
         % If both variables are in different clusters
         if clusterID2 > -1 && clusterID1 > -1
             
             % Choosing the smaller clusterID to merge     
             
             if clusterID1 < clusterID2
                 clusterTable(itrk:itrk,2) = clusterTable(itrj:itrj,2);               
             end
                      
             if clusterID2 < clusterID1    
                clusterTable(itrj:itrj,2) = clusterTable(itrk:itrk,2);   
             end  
             
         end
   end 
   
  clusterTable
  
 % Extracting and sorting the ClusterIDs
 clusterIDs = sort(clusterTable(:,2));
 
 % Getting the size of the clusterIDs (column)
 clusterIDsSize= size(clusterIDs);
 clusterIDsSize = clusterIDsSize(1:1,1);
 
  % Returning a -1 value for duplicate number of clusters
 checkvalue =0;
 for i = 1:clusterIDsSize
     
      for j = 1+1:clusterIDsSize
          
     % Set zero for duplicate values     
     if checkvalue == clusterIDs(j:j,1);
         clusterIDs(j:j,1) = -1;
         
     else 
         checkvalue = clusterIDs(j:j,1);
     end

     end 
 end 
 
 % Removing the -1 so only the number of clusters remain in the list
 newlist = [];
  for i = 1:clusterIDsSize
      
    if (clusterIDs(i:i,1) ~= -1)
        newlist = [newlist; clusterIDs(i:i,1)];
    end
    
  end
 clusterIDs = newlist;
 
 % Getting the size of the clusterIDs (column)
 clusterIDsSize= size(clusterIDs);
 clusterIDsSize = clusterIDsSize(1:1,1);
 
 % Getting the size of the Detected Faces
 FacesListSize= size(FacesList);
 FacesListSize = FacesListSize(1:1,1);
 
 TotalNumberOfPeopleDetectedInTheImage = FacesListSize + clusterIDsSize
 % Add the face detection BB to clusters and that is the final answer


