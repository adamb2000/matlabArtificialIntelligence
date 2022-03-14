% Description: reproduce the im2gray() function behaviour for
% yourself (including some simple Inputs/Outputs comments, below)
%
% Inputs:
% im: an image
% 
% Outputs: 
% im_g: a greyscale image consisting of uint8 values
% 
% Notes: the function should return uint8 values (matching what is passed
% in) but you'll get rounding errors if you perform the conversion
% calculation with uint8 values, so some recasting is needed here
%
function im_g = my_im2gray(im)

    im_g = [];


    for i=1:1:size(im,1)
        for j=1:1:size(im,2)
            im_g(i,j) = uint8(0.2989 * im(i,j,1) + 0.5870 * im(i,j,2) + 0.1140 * im(i,j,3));
        end
    end

    % write your code on the lines below:
    
    
    
end