        
        % Init component features BB with x,y
        
                
        x1=FacesList(ith:ith,1);
        y1=FacesList(ith:ith,2);
        
        w1=FacesList(ith:ith,3);
        h1=FacesList(ith:ith,4);
        
        x2=x1+w1;
        y2=y1+h1;
        
        % Init face BB a,b
        
        a1=FeaturesList(jth:jth,1);   
        b1=FeaturesList(jth:jth,2);
        
        w1=FeaturesList(jth:jth,3);
        h1=FeaturesList(jth:jth,4);
      
        a2=a1+w1;
        b2=b1+h1;