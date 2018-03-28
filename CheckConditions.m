

        % Checking if any of the lines/point intersect
        % (Assumming x,y Face BB is bigger than a,b Features BB)
        
        if ((x1<=a1) && (a1<=x2)) % If a1 left vertical line is between the left x1 and right x2
            firstCondition= 1;
        else 
            firstCondition = 0;
        end
        
        if ((x1<=a2) && (a2<=x2)) % If a2 right vertical line is between left x1 and right x2 
            secondCondition= 1;
        else 
            secondCondition = 0;
        end
        
        if ((y1<=b1) && (b1<=y2)) % If b1 bottom horizontal line is between y1 and top y2
            thirdCondition= 1;
        else 
            thirdCondition = 0;
        end
            
        if ((y1<=b2) && (b2<=y2)) % If b2 top horizontal line is between bottom y1 and top y2
            fourthCondition= 1;
        else 
            fourthCondition = 0;
        end
        
        sumCondition= firstCondition+secondCondition+thirdCondition+fourthCondition;


        
        
        