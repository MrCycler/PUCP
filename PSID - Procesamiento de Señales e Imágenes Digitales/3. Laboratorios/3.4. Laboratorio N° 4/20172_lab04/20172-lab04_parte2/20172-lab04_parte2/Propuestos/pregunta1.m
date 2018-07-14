clc
close all
clear all

%% Pregunta a

% Lectura de imagen
Im1_color = imread('flash.png');
% Conversion RGB a escala de grises 
Im1_gray = rgb2gray(Im1_color);
% Conversion a double y Normalizacion
Im1 = double(Im1_gray)/255;

Im2 = double(rgb2gray(imread('towers.png')))/255;
Im3 = double(imread('marvel.png'))/255;
Im4 = double(imread('fondo.png'))/255;

% Se genera ruido gaussiano blanco con media cero y de varianza igual a sigma cuadrado
Im_cor1 = imnoise(Im1,'gaussian', 0.05^2);
Im_cor2 = imnoise(Im1,'gaussian', 0.2^2);


% Graficas
figure
subplot(2,2,1), imshow(Im1_gray), title('Imagen Original')
subplot(2,2,3), imshow(Im_cor1), title('Imagen corrompida con sigma = 0.05')
subplot(2,2,4), imshow(Im_cor2), title('Imagen corrompida con sigma = 0.2')


%% Pregunta a

% Se define los filtros gaussiano 
h1 = fspecial('average',5);
h2 = fspecial('average',10);
h3 = fspecial('average',15);


% Filtrado del ruido signa = 0.05
Im_filt1 = conv2(Im_cor1,h1,'same');
Im_filt2 = conv2(Im_cor1,h2,'same');
Im_filt3 = conv2(Im_cor1,h3,'same');


% Graficas
figure
subplot(2,2,1), imshow(Im_filt1), title('Imagen resultante 1 | filtro de 5x5')
subplot(2,2,3), imshow(Im_filt2), title('Imagen resultante 3 | filtro de 10x10')
subplot(2,2,4), imshow(Im_filt3), title('Imagen resultante 3 | filtro de 15x15')


% Filtrado del ruido sigma = 0.2
Im_filt1 = conv2(Im_cor2,h1,'same');
Im_filt2 = conv2(Im_cor2,h2,'same');
Im_filt3 = conv2(Im_cor2,h3,'same');

% Graficas
figure
subplot(2,2,1), imshow(Im_filt1), title('Imagen resultante 1 | filtro de 5x5')
subplot(2,2,3), imshow(Im_filt2), title('Imagen resultante 2 | filtro de 10x10')
subplot(2,2,4), imshow(Im_filt3), title('Imagen resultante 3 | filtro de 15x15')


%% Pregunta C

% Se corrompe la imagen 0.1 de ruido sal y pimienta
Im_cor = imnoise(Im1,'salt & pepper',0.1);

% Denoising con un filtro medio
Im_filt_mean = conv2(Im_cor,h1,'same');
% Denoising con un filtro mediano
Im_filt_median = medfilt2(Im_cor, [5 5]);

snr(Im1,Im_filt_mean)
snr(Im1,Im_filt_median)

% Graficas
figure
subplot(2,2,1), imshow(Im_cor), title('Imagen corrompida con 0.1 salt and pepper')
subplot(2,2,3), imshow(Im_filt_mean), title('filtro medio')
subplot(2,2,4), imshow(Im_filt_median), title('filtro mediano')

%% Pregunta d

% Se escala la imagenen 2 con diferente tipos de interpolacion
Im_near = imresize(Im2, 0.2, 'nearest');
Im_bil =  imresize(Im2, 0.2, 'bilinear');
Im_bic =  imresize(Im2, 0.2, 'bicubic');

figure
subplot(2,2,1), imshow(Im2), title('Imagen original')
subplot(2,2,2), imshow(Im_near), title('escalamiento 0.2 | vecino mas cercano')
subplot(2,2,3), imshow(Im_bil), title('0.2 | bilineal')
subplot(2,2,4), imshow(Im_bic), title('0.2 | bilicubica')

% Se rota la la imagenen 2 con diferente tipos de interpolacion
Im_near = imrotate(Im2, 45, 'nearest');
Im_bil = imrotate(Im2, 45, 'bilinear');
Im_bic = imrotate(Im2, 45, 'bicubic');

Im_near = Im_near(205:305, 160:280);
Im_bil = Im_bil(205:305, 160:280);
Im_bic = Im_bic(205:305, 160:280);

figure
subplot(2,2,1), imshow(Im2), title('Imagen original')
subplot(2,2,2), imshow(Im_near), title('45 grados | vecino mas cercano')
subplot(2,2,3), imshow(Im_bil), title('45 grados | bilineal')
subplot(2,2,4), imshow(Im_bic), title('45 grados | bilicubica')



%% Pregunta e

Im3_r = Im3(:,:,1);
Im3_g = Im3(:,:,2);
Im3_b = Im3(:,:,3);

figure
subplot(2,2,1), imshow(Im3), title('Imagen Original')
subplot(2,2,2), imshow(Im3_r), title('Capa Roja')
subplot(2,2,3), imshow(Im3_g), title('Capa Verde')
subplot(2,2,4), imshow(Im3_b), title('Capa Azul')

% Por inspeccion grafica de la capa verde se hallo el umbral 0.6863 para
% separa la imagen objetivo (hombre araña) del fondo
mask = Im3_g < 0.6863;

% Segmentacion
seg = zeros(size(Im3));
seg(:,:,1) = mask.*Im3_r;
seg(:,:,2) = mask.*Im3_g;
seg(:,:,3) = mask.*Im3_b;

%  la imagen segmentada en el nuevo fondo
Im4(1:494, 1:668, 1) = not(mask).*Im4(1:494, 1:668, 1) + seg(:,:,1);
Im4(1:494, 1:668, 2) = not(mask).*Im4(1:494, 1:668, 1) + seg(:,:,2);
Im4(1:494, 1:668, 3) = not(mask).*Im4(1:494, 1:668, 1) + seg(:,:,3) ;

figure
subplot(2,2,1), imshow(Im3), title('Imagen original')
subplot(2,2,2), imshow(mask), title('mascara binaria')
subplot(2,2,3), imshow(seg), title('Imagen segmentada')
subplot(2,2,4), imshow(Im4), title('Fondo sustituido')

 
 


 
