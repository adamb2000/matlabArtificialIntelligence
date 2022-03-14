 % Description: convert an image to grayscale and extract HOG
% features from patches of size 16*16 pixels
%
% Inputs:
% im: an image
% 
% Outputs:
% h: an array containing all the HOG features for the image
% 
% Notes: just a simple wrapper function for the built-in
% extractHOGFeatures() function that makes sure the conversion to
% grayscale happens first, and that the 'CellSize' input is set
%
function h = get_hogs(im)

    h = [];

    im = im2gray(im);   %image converted to greyscale

    CELLSIZE = [16 16];
    h = my_extractHOGFeatures(im); %hog features extracted and then returned 
    %h = extractHOGFeatures(im, 'CellSize', CELLSIZE,'BlockSize', [floor(size(im,1)/CELLSIZE(1)) floor(size(im,2)/CELLSIZE(2))],'UseSignedOrientation', true);

    

end