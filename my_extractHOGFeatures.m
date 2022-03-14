% Description: given a greyscale image, extract HOG features from patches
% of size 16*16 pixels using 9-bin histograms, and return all the bin
% totals in a single large array
%
% Inputs: im: an image
% 
% Outputs: h an array containing all the resulting bin totals (all
% individual histograms concatenated together)
% 
% Notes: perhaps start with calls to the built-in imgradient_xy() and
% imgradient() functions for computing the maximum rate of increase
% information (you can switch over to your my_*() equivalents once finished
% and check for equivalent results); we suggest a nested for loop over
% image patches; careful with your indices - the function should accept any
% greyscale image and width/height isn't guaranteed to be a multiple of 16
% (practice at the Command Window first is strongly recommended); note it
% doesn't matter whether you loop down columns and then across rows or vice
% versa; there's a tip in the function body below for making the histograms
% (you can take any approach you like but note we do expect you to code
% this process up for yourself - if you start off by using a built-in
% function to help you, then you need to replace it with your own code at a
% later stage; the zeros() function (met in the Matlab Fundamentals) is a
% nice way to initialise an empty 9-bin histogram; you saw how to
% concatenate arrays using []-notation in the Matlab Fundamentals (check
% back or have a play around at the Command Window if unsure); for the
% final standardisation step, you need to treat your final h array as
% definining the coordinates of a point in a feature space and calculate
% its Euclidean distance from the origin; you may have code from your k-NN
% work that you can reuse? - or you can check the k-NN lecture slides for
% the Euclidean distance equation, but notice it simplifies if one of the
% points has all-zeros for its coordinates (as the origin does); once you
% have the distance you simply divide all values in your h array by it (the
% new distance from the origin is then equal to 1)
% 

 % One possible approach to computing histogram bin scores from
    % orientations (but you can use any approach you like as long as you
    % code it for yourself and don't just call another built-in function):
    
    % Start by constructing an array holding the exact centres (not edges)
    % of each bin. Remember the 9 bins span the range -180 to +180 degrees
    % but the first and last bins aren't centred on 0 or 180 degrees
    % (perhaps sketch how the histogram bins cover the full range to get an
    % accurate picture in your mind first). This is a one-time job you can
    % do up at the top of this function. Then whenever you have a new value
    % (direction) that you want to assign to the correct bin, you can
    % simply subtract that value from your array and compute the absolute
    % size of the resulting values to get the distances to each
    % centre-point (using a call to abs()); calling min() on these
    % distances then allows you to find the index of the closest bin.
    
    % add your code and comments on the lines below:
    
function h = my_extractHOGFeatures(im)

    h = [];
    
    cellsize = [16,16];
    jump = cellsize;    %jump can be smaller than cell size but in this case each cell is directly next to the previous
    rowsend = (fix(size(im,1)/cellsize(1)))*cellsize(1);    %rows/colsend calculated by finding out what how many full cells can be fit into an image
    colsend = (fix(size(im,1)/cellsize(2)))*cellsize(2);
    bin = [-160,-120,-80,-40,0,40,80,120,160]; %array of the center of each bin is created
    [x,y] = my_imgradientxy(im);    
    [Gmag,Gdir] = my_imgradient(x,y);
    %[x,y] = imgradientxy(im);    
    %[Gmag,Gdir] = imgradient(x,y);

    
    
    for i = 1:jump(1):rowsend           %looping over the values in the image with each cell not intersecting each other 
        for j = 1:jump(2):colsend
            
            tempMag = Gmag(i:i+15,j:j+15);  %temoprary variables set up to hold values for each cell
            tempDir = Gdir(i:i+15,j:j+15);
            tempBin = zeros(1,9);       %array of zeros created that representy each bin  
            for k=1:1:size(tempDir,1)
                for l=1:1:size(tempDir,2)       %loop over each value in the temporary 'cell' arrays 
                    index = 0;  %index starts at 0
                    x = abs(bin - tempDir(k,l)); %the value is subtracted from each bin center and all the answers are made posative 
                    mini = min(x);  %finds the min in the subtracted bin vlaues (the bin value that was closest to the value in tempDir)
                    for q=1:1:size(x,2)
                        if(x(q) == mini)    %loops over all the subtracted bin values and finds the index of which was the smallest 
                            index = q;
                     
                        end
                    end
                    tempBin(index) = tempBin(index) + tempMag(k,l); %adds the magnitude to the correct bin 

                end
            end
            h = [h,tempBin];    %after each iteration, the temp bin is added on the end of the rest of the bins
            

        end
    end
    temph = sqrt(sum(h.^2));    %list of bins is standardised
    h = h ./temph;
   
    

    
end