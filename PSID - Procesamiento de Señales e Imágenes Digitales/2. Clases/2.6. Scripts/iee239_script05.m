% IEE239: Series y Transformada de Fourier
% Descripcion: el script determina el espectro de magnitud de una senal
% discreta no periodica basada en multiples escalones en frecuencia
% utilizando los comandos 'fft' y 'fftshift'. Luego, se describen
% graficamente ambas representaciones.

close all; clear all;

% --- senal en espacio de muestras --- %
n_v= -1024: 1023;
f_v= ( 2* sinc( n_v)- 8/ 10* sinc( 8/10* n_v)- 9/ 10* sinc( 9/10* n_v));
% --- END senal en espacio de muestras --- %


% --- senal en frecuencia --- %
N= length( n_v);
w_v= 2* pi* ( 0: N- 1)/ N;
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);
F_v= fftshift( fft( f_v));
% --- senal en frecuencia --- %


% --- descripcion grafica --- %
figure;
subplot( 2, 1, 1); plot( f_v);
title( 'senal en espacio de muestras');
subplot( 2, 1, 2); plot( w_v, abs( F_v), 'r');
title( 'espetro de magnitud');
% --- END descripcion grafica --- %