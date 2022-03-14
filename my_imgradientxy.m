% Description: reproduce the imgradientxy() function behaviour (using
% 'Prewitt') for yourself.
%
% Inputs: im: an image
% 
% Outputs: Gx an array of horizontal local gradient estimates in double
% precision Gy an array of vertical local gradient estimates in double
% precision
% 
% Notes: you might want to start by calling imfilter() to do the
% convolutions for you, before then trying to replace them for yourself, or
% you might prefer to jump straight into the convolutions. (Note if you do
% use it that imfilter() will return the same data types you pass it, and
% so you'll lose information if you pass it uint8s.) A full implementation
% should add padding around the image (by copying the closest pixel
% values)


function [Gx, Gy] = my_imgradientxy(im)

    Gx = [];
    Gy = [];
    fx = [ -1 0 1;-1 0 1;-1 0 1 ];     %arrays containing filters
    fy = [ -1 -1 -1;0 0 0;1 1 1];
    
    % write your code on the lines below:
    im = padarray(im,[1,1],'replicate');    %adds the padding around the image so the pixels on the edge of the image can still be evaluated
    im = double (im);
    

    
    for i=2:1:(size(im,1)-1)
        for j=2:1:(size(im,2)-1)    %nested for loops to go accross image and then down 
            tempX=[];
            tempY=[];%temporary variables holding the convolutions before they're added up to make 1 number 
            temp = [im(i-1,j-1),im(i-1,j),im(i-1,j+1);
                    im(i,j-1),im(i,j),im(i,j+1);        %3x3 grid taken from the image with the current pixel in the loop being the center point
                    im(i+1,j-1),im(i+1,j),im(i+1,j+1)];
            tempX = temp.*fx;                   %both x and y are multiplied by their relative filter
            Gx(i-1,j-1) = sum(tempX(:));%sums for x and y are made and added to Gx/Gy respectively
            tempY = temp.*fy;
            Gy(i-1,j-1) = sum(tempY(:));
        end
    end

  
end