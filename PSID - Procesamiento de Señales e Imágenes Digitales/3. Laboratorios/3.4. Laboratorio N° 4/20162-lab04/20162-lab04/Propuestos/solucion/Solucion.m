
close all; clear all;


%% Pregunta 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTE A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lectura de la imagen
img = imread('bowieRB.jpg');
imgR =img(:,:,1);
imgG =img(:,:,2);
imgB =img(:,:,3);

figure(1)
subplot(232);
imshow(img) 
title('Original');

subplot(234);
imshow(imgR) 
title('Red');

subplot(235);
imshow(imgG) 
title('Green');
subplot(236);
imshow(imgB) 
title('Blue');


Redless=img;
figure(2)
subplot(211)
imshow(Redless)

indx2=(Redless(:,:,3) >120 )&(Redless(:,:,1) <150 );
    

R=Redless(:,:,1);
G=Redless(:,:,2);
B=Redless(:,:,3);

R(indx2)=0;
G(indx2)=0;
B(indx2)=0;

Redless(:,:,1)=R;
Redless(:,:,2)=G;
Redless(:,:,3)=B;

subplot(212)
imshow(Redless)
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTE B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 figure(1)
subplot(141)
 imshow(img)
 title('original')

subplot(142)
sigma=0.1;
Dbowie=imgaussfilt(img,sigma);
imshow(Dbowie)
title('gaussian 0.1')
subplot(143)
sigma=0.5;
Dbowie=imgaussfilt(img,sigma);
imshow(Dbowie)
title('gaussian 0.5')


 subplot(144)
sigma=1;
Dbowie=imgaussfilt(img,sigma);
imshow(Dbowie)
title('gaussian 1')
figure(2)
subplot(131)
 imshow(img)
 title('original')
 
subplot(132)
Mbowie(:,:,1) = medfilt2(img(:,:,1),[3,3]);
Mbowie(:,:,2) = medfilt2(img(:,:,2),[3,3]);
Mbowie(:,:,3) = medfilt2(img(:,:,3),[3,3]);

 imshow(Mbowie)
 title('Median 3x3')
 
 subplot(133)
Mbowie(:,:,1) = medfilt2(img(:,:,1),[5,5]);
Mbowie(:,:,2) = medfilt2(img(:,:,2),[5,5]);
Mbowie(:,:,3) = medfilt2(img(:,:,3),[5,5]);

 imshow(Mbowie)
 title('Median 5x5')
 
  

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTE C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img=img(:,:,1);
sigma=1;
Dbowie=imgaussfilt(img,sigma);

alpha=0.1;
H = fspecial('laplacian',alpha);
BowieBorders = imfilter(Dbowie,H,'replicate');


BB=uint8(BowieBorders>8).*BowieBorders;

figure(1)
imshow(10*BB);
title('gaussian')

Mbowie = medfilt2(img,[5,5]);

alpha=0.1;
H = fspecial('laplacian',alpha);
BowieBorders = imfilter(Mbowie,H,'replicate');


BB=uint8(BowieBorders>8).*BowieBorders;
figure(2)
 imshow(10*BB)
 title('Median 5x5')

 
 

%% Pregunta 4

% Cargamos la imagen 

load('x_ray.mat');

%calculamos la constante de la transformacion logaritmica

c=255/(1+round(255*max(J(:))));
%Aplicamos la transformacion logaritmica
Log_J=c*log(1+J);

%Aplicamos la transformacion gamma
gamma=2.35;
gamma2=1.25;
Gam_J=J.^gamma;
Gam_J1=J.^gamma2;

% Graficamos las imagenes originales y transformadas
figure(1)
subplot(221), imshow(J);
title('Imagen Original');
subplot(222), imshow(Log_J);
title('Imagen con Transformacion Logaritmica');
subplot(223), imshow(Gam_J);
title('Imagen con Transformacion Gamma=2.35');
subplot(224), imshow(Gam_J1);
title('Imagen con TransformacionGamma=1.25');

%Generamos imagenes de zeros para la umbralizacion
J_um=zeros(size(J));
LJ_um=J_um;
GJ_um=J_um;
Gj1_um=J_um;

% En la imagen con Transformacion Gamma=2.5 es donde se observa mejor las
% microcalcificaciones. Haciendo zoom en dicha zona en cada una de las
% imagenes, y con ayuda de la herramienta Data Cursor, observamos que las
% intensidades de las microcalcificaciones son las siguientes

% Para la imagen Original J, las microcalcificaciones tienen intensidad
% mayor a 0.7

% Para la imagen con Transformacion Logaritmica Log_J, las
% microcalcificaciones tienen intensidad mayor a 0.65

% Para la imagen con Transformacion Gamma=2.35, las microcalcificaciones
% tienen intensidad mayor a 0.5

% Para la imagen con Transformacion Gamma=2.35, las microcalcificaciones
% tienen intensidad mayor a 0.65

% Umbralizamos con los valores hallados

J_um(J>0.7)=1;
LJ_um(Log_J>0.65)=1;
GJ_um(Gam_J>0.5)=1;
Gj1_um(Gam_J1>0.65)=1;

figure(2)
subplot(221), imshow(J_um);
title('Imagen Original');
subplot(222), imshow(LJ_um);
title('Imagen con Transformacion Logaritmica');
subplot(223), imshow(GJ_um);
title('Imagen con Transformacion Gamma=2.35');
subplot(224), imshow(Gj1_um);
title('Imagen con TransformacionGamma=1.25');

%De las imagenes podemos observar que la Transformacion Gamma=2.35 permite
%definir mejor las microcalcificaciones. Si aplicamos el mismo nivel de
%umbralizacion al resto de imagenes observaremos solo manchas blancas.

J_um2=zeros(size(J));
LJ_um2=J_um2;
GJ_um2=J_um2;
Gj1_um2=J_um2;


J_um2(J>0.5)=1;
LJ_um2(Log_J>0.5)=1;
GJ_um2(Gam_J>0.5)=1;
Gj1_um2(Gam_J1>0.5)=1;

figure(3)
subplot(221), imshow(J_um2);
title('Imagen Original');
subplot(222), imshow(LJ_um2);
title('Imagen con Transformacion Logaritmica');
subplot(223), imshow(GJ_um2);
title('Imagen con Transformacion Gamma=2.35');
subplot(224), imshow(Gj1_um2);
title('Imagen con TransformacionGamma=1.25');