function [ num ] = contar_elementos( I_base )
%CONTAR_ELEMENTOS Summary of this function goes here
%   Detailed explanation goes here
    bw = (im2bw(I_base, graythresh(I_base)));
bw2 = imfill(bw, 'holes');
[~,num] = bwlabel(bw2);


end

