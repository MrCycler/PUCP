function [ frames ] = video2frames( name )
%VIDEO2FRAMES Summary of this function goes here
%   Detailed explanation goes here
    v = VideoReader(name);
    ii=1;
    while hasFrame(v)
        frames(:,:,:,ii) = double(readFrame(v))/255;
        ii=ii+1;
    end

end

