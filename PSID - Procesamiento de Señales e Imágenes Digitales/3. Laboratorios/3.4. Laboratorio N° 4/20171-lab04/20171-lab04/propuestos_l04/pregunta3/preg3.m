I=imread('grain.png');
%% Interpolando
imgOut1=imresize(I,30,'bilinear');
imgOut1f=imresize(imgOut1,1/30,'bilinear');
%% hallando el brillo del fondo
I=double(imgOut1f);
H = fspecial('disk',30);
B = imfilter(I,H,'replicate'); 
coef=I./B;
C=mean(I(:))*(1/mean(coef(:)));
g=coef*C;
%% Transformación Gamma
im = double(g);
gamma=1.2;
out = (im.^gamma)*(1/(255^(gamma - 1)));
out = uint8(out);
subplot(121),imshow(g,[])
subplot(122),imshow(out)
%% Mejora del contraste
im2=out/max(out(:)); 
im3=histeq(out);
%% contruir histogramas
numberOfBins = 256;
[PixelCounts1, GrayLevels] = imhist(out, numberOfBins); 
subplot(121),bar(PixelCounts1);
[PixelCounts2, GrayLevels] = imhist(im3, numberOfBins); 
subplot(122),bar(PixelCounts2);