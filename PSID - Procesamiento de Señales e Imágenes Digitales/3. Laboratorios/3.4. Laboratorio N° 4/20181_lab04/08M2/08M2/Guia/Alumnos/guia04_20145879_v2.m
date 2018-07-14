%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% Guia 04
clear all;
close all;
clc;
%%  Problema 01
%% Parte A

img1=double(rgb2gray(imread('tree.png')))/255;
hist1=histeq(img1); % histograma
imad1=imadjust(img1,[0 1],[1 0],2);
imad2=imcomplement(imad1);

figure
subplot (3,2,1), imshow(img1),title('Imagen original');
subplot (3,2,3),imshow(hist1),title('Ecualizada');
subplot(3,2,5),imshow(imad2),title('Transf gamma=2');
%histogramas
subplot (3,2,2),imhist(img1),title('Histogramas');
subplot(3,2,4),imhist(hist1);
subplot(3,2,6),imhist(imad2);

%% Parte B

img2=double(imread('tree.png'))/255;
% RGB por separado
img2_r=img2(:,:,1);
img2_g=img2(:,:,2);
img2_b=img2(:,:,3);

numerador=0.5*((img2_r-img2_g)+(img2_r-img2_b));
denominador=((img2_r-img2_g).^2+(img2_r-img2_b).*(img2_g.*img2_b)).^(1/2)+eps;

teta=acos(numerador/denominador); %calculamos teta
[r_max,c_max]=size(img2_r); %sacamos las dimensiones

h=zeros(r_max,c_max); %creamos la matriz

for r=1:r_max
    for c=1:c_max 
       if (img2_g(r,c)>=img2_b(r,c)) 
          h=teta;           
       end
       if (img2_g(r,c)<img2_b(r,c)) 
          h=360-teta;        
       end
    end
end

min_r=min(min(img2_r));
min_g=min(min(img2_g));
min_b=min(min(img2_b));
x=[min_r min_g min_b];
minimo=min(x);

s=1-(1./(img2_r+img2_g+img2_b)).*minimo;
v=(1/3).*(img2_r+img2_g+img2_b);

histV=histeq(v); % histograma
imadV=imadjust(histV,[0 1],[1 0],2);
imadV=imcomplement(imadV);

figure
subplot (3,2,1), imshow(img2),title('Imagen original');
subplot (3,2,3),imshow(histV),title('Ecualizada');
subplot(3,2,5),imshow(imadV),title('Transf gamma=2');
%histogramas
subplot (3,2,2),imhist(img2),title('Histogramas');
subplot(3,2,4),imhist(histV);
subplot(3,2,6),imhist(imadV);


%% Parte C
% creamos los filtros
h1=fspecial('average',3);
h2=fspecial('average',9);
% convolucionamos el filtro con la imagen
img1_filtroV1=conv2(v,h1,'full');
img1_filtroV2=conv2(v,h2,'full');
% se grafica los resultados
figure
subplot (3,2,1), imshow(v),title('Imagen V');
subplot (3,2,3),imshow(img1_filtroV1),title('FILTRO 1');
subplot(3,2,5),imshow(img1_filtroV2),title('FILTRO 2');
%histogramas
subplot (3,2,2),imhist(v),title('Histogramas');
subplot(3,2,4),imhist(img1_filtroV1);
subplot(3,2,6),imhist(img1_filtroV2);

%% PARTE D 
orden=9;
%% PARTE E

h2=fspecial('average',9); % filtro 2
img1_filtroS2=conv2(s,h2,'full'); % aplicamos el filtrado
d_filtrado=img1_filtroV2-img1_filtroS2; % ambos con matriz de filtrado 9x9

%Transformamos
fft_d=fft2(d_filtrado);
fft_d=fftshift(fft_d);
%fft_d=unwrap(fft_d-2*pi);

mag1=abs(fft_d);
ang1=angle(fft_d);

figure
subplot (2,2,1), plot(0:fft_d,mag),title('Magnitud original');
subplot (2,2,2), plot(fft_img1,mag),title('Fase original');
subplot (2,2,3), plot(fft_img1,mag),title('Magnitud filtrada');
subplot (2,2,4), plot(fft_img1,mag),title('Fase filtrada');

% ¿ Se verifica ?
% Sí ya que aparecen cambios en la
% magnitud que evidencian la existencia
% de un ruido entre los bordes.


%% Problema 2
clear all;
close all;
clc;
%% Parte A

img2_dist=imread('distorted.jpg');

m=[1 -0.7 0;0 1 0; 0 0 1]; % matriz de transformacion
tform = maketform('affine',m);
%maket=maketform(reshape(img2_dist(:), [1 211800]));
img2_recup=imtransform(img2_dist,tform,'bilinear');
figure
subplot(1,2,1), imshow(img2_dist),title('Imagen distorsionada');
subplot(1,2,2),imshow(img2_recup),title('Imagen recuperada');

% ¿ A qué se debe el cambio de dimensión resultante?

% Se debe a que cuando aplicamos una
% interpolacion bilineal
% se usa el método de zero-padding
% creando así espacios con valor 0
% 0 = ausencia de luz

%% Parte B

[r,c]=size(img2_recup);
%img2_recup_double=double(img2_recup_double)./255;
suma_c=zeros(1,c);
for m=1:c
    for n=1:r
        suma_c(m)=suma_c(m)+img2_recup(n,m)/255;        
    end
end
minimo=90;
maximo=500;
img2_recup2=img2_recup(:,90:500);
figure,
subplot(121),plot(suma_c),title('Suma por columnas');
subplot(122),imshow(img2_recup2),title('Sin columnas padding');

%% Parte C

img2_orig=imread('orig.jpg');
teta=-pi/4;
m=[cos(teta) -sin(teta) 0;sin(teta) cos(teta) 0; 0 0 1];
tform = maketform('affine',m);
%maket=maketform(reshape(img2_dist(:), [1 211800]));
img2_recup_f1=imtransform(img2_dist,tform,'bilinear');
img2_recup_f1=imresize(img2_recup_f1,0.2,'bilinear');
img_recup_f2=imrotate(img2_orig,-1,'bilinear','crop');

% ¿En que caso se preservan mejor los bordes?
% en el caso de rotación ya que el método de
% vecinos más cercanos contempla el aliasing
% en su definicion
figure
subplot(1,2,1), imshow(img2_recup_f1),title('Vecinos cercanos');
subplot(1,2,2),imshow(img_recup_f2),title('bilineal');

%% Problema 3
clear all;
close all;
clc;
%% Parte A

sobel=[1 2 1; 0 0 0 ; -1 -2 -1];
M=128;
N=M;
seg=zeros(size(2));


%% Parte B

cam=double(rgb2gray(imread('cam.jpg')))/255;
camn1=double(rgb2gray(imread('camn1.jpg')))/255;
camn2=double(rgb2gray(imread('camn2.jpg')))/255;

varianza_1=0.02;
varianza_2=0.2;

cam_cor1=imnoise(cam,'gaussian',varianza_1);
camn1_cor1=imnoise(camn1,'gaussian',varianza_1);
camn2_cor1=imnoise(camn2,'gaussian',varianza_1);

cam_cor2=imnoise(cam,'gaussian',varianza_2);
camn1_cor2=imnoise(camn1,'gaussian',varianza_2);
camn2_cor2=imnoise(camn2,'gaussian',varianza_2);

figure
subplot(221),imshow(cam),title('cam');
subplot(223),imshow(camn1_cor1),title('camn1_cor1');
subplot(224),imshow(camn2_cor2),title('camn2_cor2');

%% Parte C

%% Parte D

%% Parte E

