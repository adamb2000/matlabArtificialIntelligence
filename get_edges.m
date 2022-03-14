% Description: generate estimates of the fraction of vertical and
% horizontal edge pixels in an image by calling imgradientxy to compute
% local gradients in each direction and thresholding the magnitudes in the
% two resulting matrices
%
% Inputs: im: an image
% 
% Outputs: edges: array containing the fraction of all gradient magnitudes
% above the threshold in the horizontal direction (inside edges(1)) and the
% fraction of all gradient magnitudes above the threshold in the vertical
% direction (inside edges(2))
% 
function edges = get_edges(im)

    edges = [0 0];
    
    im = im2gray(im);   %image converted to greyscale
    [Gx, Gy] = my_imgradientxy(double(im)); %local gradients computed and returned
    %[Gx, Gy] = imgradientxy(double(im));
    Gx = abs(Gx);%all the numbers turned into posatives as it doesnt matter if its posative or negative - makes next step more simple 
    Gy = abs(Gy);

    total1 = 0;
    total2 = 0;%totals initially set to 0 to be incremented

    for i=1:1:size(Gx,1)
        for j=1:1:size(Gx,2)    %looping over every number within Gx
            if (Gx(i,j)>=45)    
                total1 = total1+ 1; %if the gradient is above 45 then add 1 to the total
            end
        end
    end
    
    for i=1:1:size(Gy,1)        %same process for Gy
        for j=1:1:size(Gy,2)
            if (Gy(i,j)>=45)
                total2 = total2 +1;
            end
        end
    end
    % write your code on the lines below:
    total1 = total1 / (size(im,1)*size(im,2)); %totals for x and y are divided by the total amount of numbers - creating an average
    total2 = total2 / (size(im,1)*size(im,2));
    edges(1) = total1;
    edges(2) = total2;  %averages returned in array
    

end