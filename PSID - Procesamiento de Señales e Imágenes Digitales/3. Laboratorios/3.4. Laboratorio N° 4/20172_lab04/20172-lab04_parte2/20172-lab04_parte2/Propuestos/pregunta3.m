%% Pregunta 3
%% a)
clear all;close all;clc;
% leemos la imagen
I=imread('parrot.jpg');
% transformar a escala de grises. Se usa rgb2gray(), que asigna pesos diferentes a cada canal, buscando retener solo informacion de luminosidad de la imagen.
I2=rgb2gray(I);
% calcular el histograma
imhist(I2(:))
%% b) TRANFORMACION LOGARITMICA
% Realizamos un cast a double, para que los valores se encuentren entre 0 y 255.
f=double(I2);
C=1;
%Aplicamos la ecuacion (1)
G=C*log(1+f);
%Para mostrar la imagen entre [0 255], hallamos un factor de normalizacion.
factor=255/max(G(:));
%Multiplicamos la imagen resultante por dicho factor (comprobar que en efecto,B tiene valores entre 0 y 255).
B=factor*G;
%Se grafica la imagen resultante, y se coloca el titulo adecuado.
figure,imshow(B,[]);title('Transformacion Log -> G = c*log(1+f)');
%Realizamos un cast a uint8 para proceder a hallar el histograma. Notar que si no se realizaba el cast, imhist() solo iba a considerar valores entre 0 y 1.
B2=uint8(B);
imhist(B2)
%% c) ECUALIZACION DEL HISTOGRAMA
%realizamos la ecualizacion directamente a la imagen en escala de grises.
ee=histeq(I2);
figure,imshow(ee);title('Ecualizacion del histograma');
% transformacion logaritmica inversa (segun ecuacion 3)
f_inv=exp(G./C)-1;
figure,imshow(f_inv,[]);title('Transformacion Log Inversa-> f_{inv} = exp(G/C)-1');

% Para el caso de la ecualizacion, no es posible obtener nuevamente la imagen original, por el motivo mencionado anteriormente.
% transformacion logaritmica inversa (segun ecuacion 3)

%% d)bit-plane
% Se hace un cast a tipo double a la imagen en escala de grises. 
  I22=double(I2);
  [r,c]= size(I2);
  % Se trabaja para los 7 bits de intensidad. La imagen es dividida por 2^n, donde n es el numero de bits a mostrar. Luego, para efectivamente emplear solo n bits, se emplea ceil(), cuya funcion es  cuantizar la imagen. Luego, para recuperar el rango de valores original, se vuelve a multiplicar por 2^n.
  for m = 1:r
      for n = 1:c
          b(m,n,1)=ceil(I22(m,n)/power(2,7))*power(2,7);
          b(m,n,2)=ceil(I22(m,n)/power(2,6))*power(2,6);
          b(m,n,3)=ceil(I22(m,n)/power(2,5))*power(2,5);
          b(m,n,4)=ceil(I22(m,n)/power(2,4))*power(2,4);
          b(m,n,5)=ceil(I22(m,n)/power(2,3))*power(2,3);
          b(m,n,6)=ceil(I22(m,n)/power(2,2))*power(2,2);
          b(m,n,7)=ceil(I22(m,n)/power(2,1))*power(2,1);
      end
  end
  % Se grafica las 8 imagenes en una misma ventana. Se hace un cast a uint8 para su correcta visualizacion.
  for i=7:-1:1
      subplot(2,4,i+1),imshow(uint8(b(:,:,i)));
      plot_header = sprintf('bit - %d',i);
      title(plot_header);
  end
  subplot(2,4,1),imshow(I2); plot_header = sprintf('Imagen original');
  title(plot_header);