% Description: take an array of HOG features extracted from a single image,
% and an array of visual words (or cluster centres within a 9D
% histogram-space), and return a bag (histogram) of visual words
%
% Inputs: 
% h: an array of HOG features for one image 
% words: a 2D array containing the visual words (coordinates of cluster
% centres, one cluster per row)
% 
% Outputs: 
% bag: an array containing the resulting bag (a set of bin scores, one bin
% per visual word)
% 
% Notes: You need to work with one HOG feature at a time, so consider
% reshaping h, or looping over it appropriately; you can initialise an
% empty bag with the zeros() function; you don't need to take any steps to
% normalise your bags
%
function bag = get_bag(h, words)

    bag = [];
    rH = [];
    % add your code and comments on the lines below:
    bag = zeros(1,size(words,1));   %variable made to be same size as words but filled with zeros

    %hog featues will need to be reshaped to have 1 hog feature per row
    %(currently all in 1 row)

    z = 1; %z is set to 1 as the first row will be index 1
    for i=1:1:size(h,1)               
        for j=1:9:size(h,2) %each hog features is 9 bins long so the jump is 9
            y=1;    %y initially set to 1 for each bin
            for k=j:1:j+8   %passes along each value in the 9 long bin 
                rH(z,y) = h(i,k);   %moves each value to the defined row and column 
                y=y+1;  %y is increased to move to the next bin value in the same feature
            end
            z = z+1;%z is increased to move to a new row as there needs to be a new row per bin
        end      
    end

    min = 999999;   %starts off with a large minimum to compare against the values
    minIndex = 0;
    for i=1:1:size(rH,1)    %loop over all values in the reshaped hog features array 
        min = 99999;    %min reset to a large number after every interation to compare against the new values
        for j=1:1:size(words,1)
            x = ((rH(i,:) - words(j,:)).^2);        %finds the euclidian distance between the 2, 9 point vectors
            d = sqrt(sum(x));
            if(d<min)
                min = d;    %finds which "word" the specific hog feature is closest to
                i;
                minIndex = j;
            end
        end
        bag(1,minIndex) = bag(1,minIndex) +1;   %adds 1 to the bin at the same index in which the closest word was found
    end
   


end