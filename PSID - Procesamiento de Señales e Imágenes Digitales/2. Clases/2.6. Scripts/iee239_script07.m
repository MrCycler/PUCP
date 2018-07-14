% IEE239: convolucion circular
% El script muestra la comparacion entre convolucion en espacio de muestras
% y producto en espacio. Este ultimo es hallado a partir de la DFT inversa
% y a partir de convolucion circular. Se demuestra que para un muestreo en
% frecuencia mayor o igual a la suma de longitudes, los efectos de
% periodicidad de la DFT no afectan el resultado de producto en frecuencia
% y por lo tanto son comparables con convolucion en espacio.

close all; clear all;


% --- argumentos de entrada --- %
x01_v= [ 1 1 1 1 1 1];  % senal cuadrada de longitud 6
x02_v= [ 1 1 1];  % senal cuadrada de longitud 3
N01= length( x01_v);
N02= length( x02_v);
M= N01;    % numero de muestras en frecuencia; periodo para la convolucion circular
% M= N01+ N02- 1;    % numero de muestras en frecuencia; periodo para la convolucion circular
% --- END argumentos de entrada --- %


% --- convolucion en espacio --- %
N_cont= 2048;
x03_conv_v= conv( x01_v, x02_v, 'full');
X03_cont_v= fftshift( fft( x03_conv_v, N_cont));   % aproximacion de transformada de Fourier en tiempo discreto de x03_conv
% --- END convolucion en espacio --- %


% --- espectros de frecuencia --- %
X01_cont_v= fftshift( fft( x01_v, N_cont));   % aproximacion de transformada de Fourier en tiempo discreto de x01
X02_cont_v= fftshift( fft( x02_v, N_cont));   % aproximacion de transformada de Fourier en tiempo discreto de x02
X01_v= fftshift( fft( x01_v, M));   % transformada discreta de Fourier  de M puntos de x01
X02_v= fftshift( fft( x02_v, M));   % transformada discreta de Fourier de M puntos de x01

w_cont_v= 2* pi* ( 0: N_cont- 1)/ N_cont;  % dominio en frecuencia para aproximacion de DTFT
w_cont_v= fftshift( w_cont_v);
w_cont_v= unwrap( w_cont_v - 2*pi);

w_v= 2* pi* ( 0: M- 1)/ M;  % dominio en frecuencia para DFT
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);
% --- END espectros de frecuencia --- %


% --- producto en frecuencia --- %
X03_v= X01_v.* X02_v;   % producto en frecuencia de DFTs
x03_fft_v= ifft( ifftshift( X03_v));    % transformada inversa de producto
% --- END producto en frecuencia --- %


x03_circ_v= cconv( x01_v, x02_v, M);  % convolucion circular en espacio de M puntos


% --- descripcion grafica --- %
fig01= figure;  % comparacion de espectros de frecuencia
subplot( 1, 3, 1); stem( w_v, abs( X01_v)); hold on;
plot( w_cont_v, abs( X01_cont_v), 'r');
title( 'X01(k) vs. X01(e^{j\omega})'); legend( 'X01(k)', 'X01(e^{j\omega})');
subplot( 1, 3, 2); stem( w_v, abs( X02_v)); hold on;
plot( w_cont_v, abs( X02_cont_v), 'r');
title( 'X02(k) vs. X02(e^{j\omega})'); legend( 'X02(k)', 'X02(e^{j\omega})');
subplot( 1, 3, 3); stem( w_v, abs( X03_v)); hold on;
plot( w_cont_v, abs( X03_cont_v), 'r');
title( 'X03(k) vs. X03(e^{j\omega})'); legend( 'X03(k)', 'X03(e^{j\omega})');


fig02= figure;  % comparacion de secuencia en espacio de muestras
subplot( 1, 3, 1); stem( x03_conv_v); title( 'convolucion lineal'); hold on;
subplot( 1, 3, 2); stem( x03_fft_v, 'r'); title( 'inversa del producto de DTFs en frecuencia'); hold on;
subplot( 1, 3, 3); stem( x03_circ_v, 'k'); title( 'convolucion circular');
% --- END descripcion grafica --- %