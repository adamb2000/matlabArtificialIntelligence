% Description: take a large array of 9-bin HOG features extracted from a
% set of images, and search for 500 clusters (or 'visual words') within the
% 9D histogram-space distribution
% 
% Inputs:
% H: an array of HOG features (we recommend one row for each image)
% 
% Outputs:
% words: a 2D array containing the coordinates of the 500 resulting cluster
% centres in the 9D histogram space, one cluster per row.
% 
% Notes: You can use the k-means algorithm to identify the K=500 cluster
% centres. But consider if/how you will need to reshape the data inside H
% before you call it. Be careful to initialise the k-means algorithm in a
% repeatable way, selecting K points in your data as the starting estimates
% for the cluster centres (see also the lecture slides) - this will
% eventually allow you implement the k-means algorithm for yourself and
% check the technical correctness of your work by using exactly the same
% initialisation
% 
function words = get_words(H)
    
    rng(0); % please leave this re-seeding of the random number generator in place so we can compare results
    mydata = [];
    z = 1;   %z is set to 1 as the first row will be index 1
    for i=1:1:size(H,1)               
        for j=1:9:size(H,2) %each hog features is 9 bins long so the jump is 9
            y=1;%y initially set to 1 for each bin 
            for k=j:1:j+8  %passes along each value in the 9 long bin 
                mydata(z,y) = H(i,k);   %moves each value to the defined row and column 
                y=y+1;  %y is increased to move to the next bin value in the same feature
            end
            z = z+1;    %z is increased to move to a new row as there needs to be a new row per binQQ
        end      
    end
    k=500; %500 clusters
    words = [];
    samples = randi([1 size(mydata, 1)], k, 1);%sets out random starting points from 'mydata'
    %[~, words] = kmeans(mydata, k, 'Start', mydata(samples,:));
    words = my_kmeans(mydata,k,samples);  
    

end