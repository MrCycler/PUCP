% IEE239: laboratorio 01
% freqspec: Análisis de frecuencia a partir de la Transformada Discreta de
% Fourier
% 
% Parametros de entrada: 
% x_v: senal unidimensaional en espacio de muestras
% Parametros de salida:
% X_v: espectro de magnitud de la senal de entrada
% f_v: vector de frecuencias analizadas
% 
% Ejemplo:
% n_v= -100: 100; % vector de muestras
% x_v= cos( pi/4* n_v); % senal de interes
% [ X_v, f_v]= freqspec( x_v); % espectro de la senal

function [ X_v, f_v]= freqspec( x_v)

f_v= 2* pi* ( 0: ( 2048- 1))/ 2048;
f_v= fftshift( f_v);
f_v= unwrap( f_v - 2*pi);
X_v= abs( fftshift( fft( x_v, 2048)));

fig_freqspec= figure;
figure( fig_freqspec); plot( f_v, X_v);
xlabel( 'Frecuencia Normalizada (rad)'); ylabel( 'Magnitud');
title( 'Espectro de Frecuencia');