function words = my_kmeans(H,k,samples)
    
    for i=1:1:k
        clust(i,:) = H(samples(i),:);   %make a new variable containing all of the starting cluster centers determined by random
    end
    count = 0;
    comp = 0;
    underTol = false;%underTolarence used to determine if the difference between the point every iteration is different enough
    newClust = [];

   while(count < 100 & underTol == false )  %will finish loop if there isnt much change or it goes over 100 iterations
       count = count+1; %increase the count every iteration
       underTol = true; %set the unbdertol true to only be changed if the difference is still above the tolerance (0.0001 difference)
        for i=1:1:size(H,1)     %loops over all rows in H
            min = 999999;
            for j=1:1:size(clust,1)  %for every row in H, loop over all the rows in clust (cluster centers)
                x = sum(((H(i,:)-clust(j,:)).^2));
                d = sqrt(x);            %find the Euclidian distance
                if(d<min)
                    min = d;            %find which cluster center is closest to this particular point from H
                    minIndex = j;       %if its closer than the current closest point, save this center as the closest
                end
            end
            
            clustIndex(i) = minIndex;       %array containing the the index for the closest cluster center for every point in H
        end
        
        for i=1:1:size(clust,1) %iterate over all of the cluster centers
            temp = [];
            for j=1:1:size(clustIndex,2)        %for every cluster center, itertate over the array containing the closest centers for each point in H
                if(clustIndex(1,j)==i)  
                    temp = [temp;H(j,:)];  %gathers up points belonging to this specific cluster center
                end
            end
            if(size(temp,1)>0)  
                temp;
                mean(temp);                     
                newClust(i,:) = mean(temp);     %find the average of all the points in the custer and set new center
            else
                newClust(i,:) = clust(i,:);       %if cluster didnt have any points, keep the same 
            end
                
            if(underTol == true)   %only look at differences if underTol is still true 
                for c=1:1:9   
                    comp = newClust(i,c)-clust(i,c);
                    if(abs(comp)>0.0001)                %calculating if any points are still changing
                        underTol = false;               %set underTol to false if there is still a significant change
                    end
                    
                end
            end
        end
   clust = newClust;    %set cluster centers to the new points that have been made
   end
   words = clust;   %return cluster centers after iterations have finsihed

end