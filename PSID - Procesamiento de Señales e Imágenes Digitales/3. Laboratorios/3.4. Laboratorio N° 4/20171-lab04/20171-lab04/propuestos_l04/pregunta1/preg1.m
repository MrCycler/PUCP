clc
clear all
close all

% Pregunta a
Im1 = double(imread('airplane.png'))/255;
Im2 = double(imread('university.png'))/255;
Im3 = double(imread('tire.png'))/255;


figure, 
subplot(3,1,1), imshow(Im1), title('Imagen Original 1')
subplot(3,1,2), imshow(Im2), title('Imagen Original 2')
subplot(3,1,3), imshow(Im3), title('Imagen Original 3')

% Pregunta b
figure, 
subplot(1,3,1), imhist(Im1), title('Histograma Imagen 1')
subplot(1,3,2), imhist(Im2), title('Histograma Imagen 2')
subplot(1,3,3), imhist(Im3), title('Histograma Imagen 3')


% Pregunta c
Im_neg1 = imadjust(Im1,[0 1],[1 0]);
Im_neg2 = imcomplement(Im1);

figure; 
subplot(1,2,1), imshow(Im_neg1), title('Imagen negativa por imadjust')
subplot(1,2,2), imshow(Im_neg2), title('Imagen negativa por imcomplement')


% Pregunta d
Im_transf = imadjust(Im2,[0 0.25], [0 1]);

figure;
subplot(1,2,1), imshow(Im2), title('Imagen Original')
subplot(1,2,2), imshow(Im_transf), title('Imagen Resultante (Mejoramiento de contraste)')

% Pregunta e
figure;
subplot(1,2,1), imhist(Im2), title('Histograma de la Imagen Original 2')
subplot(1,2,2), imhist(Im_transf), title('Imagen Resultante (Mejoramiento de contraste)')


% Pregunta f

gamma1 = 1; 
gamma2 = 0.5; 
gamma3 = 2;

c = 1;

Im_gamma1 = c*Im3.^gamma1;
Im_gamma2 = c*Im3.^gamma2;
Im_gamma3 = c*Im3.^gamma3;

% Otro forma de realizar la transf. gamma
% Im_gamma1 = c*imadjust(Im3,[],[],gamma1);
% Im_gamma2 = c*imadjust(Im3,[],[],gamma2);
% Im_gamma3 = c*imadjust(Im3,[],[],gamma3);


figure, 
subplot(3,2,1), imshow(Im_gamma1), title('gamma = 1')
subplot(3,2,2), imhist(Im_gamma1)

subplot(3,2,3), imshow(Im_gamma2), title('gamma = 0.5')
subplot(3,2,4), imhist(Im_gamma2)

subplot(3,2,5), imshow(Im_gamma3), title('gamma = 2')
subplot(3,2,6), imhist(Im_gamma3)





