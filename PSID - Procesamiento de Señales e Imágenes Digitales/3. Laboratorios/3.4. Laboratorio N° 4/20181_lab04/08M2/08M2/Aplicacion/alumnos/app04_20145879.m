%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% App 04
clear all;
close all;
clc;
%% Pregunta 1
%% Parte A
img=imread('checkers.jpg'); %leemos

img_r=double(img(:,:,1))/255;
img_g=double(img(:,:,2))/255;
img_b=double(img(:,:,3))/255;
%% Parte B

[r,c]=size(img_r);
% tamaño de cada cuadro en pixeles

fila=242:278;
columna=42:80;

cuadro_r=img_r(fila,columna);
cuadro_g=img_g(fila,columna);
cuadro_b=img_b(fila,columna);
cuadro_orig=img(fila,columna);
figure
subplot(321),imshow(cuadro_r),title('R');
subplot(323),imshow(cuadro_g),title('G');
subplot(325),imshow(cuadro_b),title('B');
subplot(322),imshow(cuadro_orig),title('Orig');

%% Parte C

figure
subplot(321),imhist(cuadro_r),title('R');
subplot(323),imhist(cuadro_g),title('G');
subplot(325),imhist(cuadro_b),title('B');
subplot(322),imhist(cuadro_orig),title('Orig');


mask=img_r<0.6745;

seg=zeros(size(img));

seg(:,:,1) = mask.*img_r;
seg(:,:,2) = mask.*img_g;
seg(:,:,3) = mask.*img_b;

img2=double(img)/255;

img2(fila,columna,1)=not(mask).*img2(fila,columna,1)+seg(:,:,1);
img2(fila,columna,2)=not(mask).*img2(fila,columna,2)+seg(:,:,2);
img2(fila,columna,3)=not(mask).*img2(fila,columna,3)+seg(:,:,3);


figure
subplot(2,2,1), imshow(img), title('Imagen Orig.')
subplot(2,2,2), imshow(mask), title('mascara Bin.')
subplot(2,2,3), imshow(seg), title('Imagen Segm.')
subplot(2,2,4), imshow(img2), title('Fondo Sust.')

%% Parte D

img_f=img;
fila2=202:238;
columna2=1:39;
img_f(fila2,columna2,1)=cuadro_orig(:,:)*255;
img_f(fila2,columna2,2)=cuadro_orig(:,:);
img_f(fila2,columna2,3)=cuadro_orig(:,:);


img_f(fila,columna,1)=255;
img_f(fila,columna,2)=255;
img_f(fila,columna,3)=255;


figure 
subplot(121),imshow(img),title('Imagen original 7b');
subplot(122),imshow(img_f),title('Imagen final 6b');









