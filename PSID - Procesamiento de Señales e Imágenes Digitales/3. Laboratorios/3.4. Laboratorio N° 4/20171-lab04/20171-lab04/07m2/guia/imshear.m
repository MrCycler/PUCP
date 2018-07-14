function [ test_im ] = imshear( I, shear_value )
%IMSHEAR Summary of this function goes here
%   Detailed explanation goes here
    tform = affine2d([1 shear_value 0; 0 1 0; 0 0 1]);
    test_im = imwarp(I,tform,'OutputView',imref2d(size(I)));

end

