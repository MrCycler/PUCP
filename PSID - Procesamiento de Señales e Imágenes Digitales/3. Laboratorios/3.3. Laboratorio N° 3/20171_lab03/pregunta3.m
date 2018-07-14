%%
clear all; 
close all; 
clc;
%% Definiendo parametros inicales
wc = 0.4*pi;     
N=512;  %numero de muestars alto para poder visualizar adecuadamente la rpta ideal
M = 20; % orden del filtro
%% Rpta impulso ideal
n= -round( N/ 2): round( N/2);                                   
den = pi* (n - M/2);
num = sin(wc* (n-M/2));

fa=num./ den;
fa(den ==0)= wc;

figure;plot(n,fa); title('Rpta ideal al impulso');
%% generacion de la ventana
ventana_rectangular= n>=0 & n<= M-1;

wh=hamming(M);
ventana_hamming=zeros(size(ventana_rectangular));
ventana_hamming(ventana_rectangular==1)=wh;

%% Diseño del filtro por enventanado
H1 = (fa) .* ventana_rectangular;
H2 = (fa) .* ventana_hamming;
figure();
subplot(2,2,1); plot(n,ventana_rectangular); title('Ventana rectangular')
subplot(2,2,2); plot(n,H1); title('Rpta del filtro diseniado con la ventana rectangular')
subplot(2,2,3); plot(n,ventana_hamming); title('Ventana hamming')
subplot(2,2,4); plot(n,H2); title('Rpta del filtro diseniado con la ventana hamming')


%% Graficas de magnitud y fase del filtro diseñado
%-------Rectangular
H1f=fftshift(fft(H1)); 
w_H1= 2*pi* ( 0:N)/ N; 
w_H1= fftshift( w_H1);
w_H1= unwrap( w_H1 - 2*pi); 

figure; 
subplot(2,1,1),plot( w_H1, 20*log10(abs( H1f))); title('filtro diseniado con la ventana rectangular')
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Magnitud (dB)');
subplot(2,1,2), plot(w_H1, unwrap(angle(H1f))); 
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Fase(grados)');


H2f=fftshift(fft(H2)); 
w_H2= 2*pi* ( 0:N)/ N; 
w_H2= fftshift( w_H2);
w_H2= unwrap( w_H2 - 2*pi); 

figure; 
subplot(2,1,1),plot( w_H2, 20*log10(abs( H2f)));title('filtro diseniado con la ventana rectangular')
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Magnitud (dB)');
subplot(2,1,2), plot(w_H2, unwrap(angle(H2f))); 
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Fase(grados)');


%% Cambio de orden N
%---------
M=6;
den = pi* (n - M/2);
num = sin(wc* (n-M/2));

fa=num./ den;
fa(den ==0)= wc;

ventana_rectangular= n>=0 & n<= M-1;
H12 = (fa) .* ventana_rectangular;

H12f=fftshift(fft(H12)); 
w_H12= 2*pi* ( 0:N)/ N; 
w_H12= fftshift( w_H12);
w_H12= unwrap( w_H12 - 2*pi); 

figure;
subplot(2,1,1),plot( w_H12, 20*log10(abs( H12f)));
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Magnitud (dB)');
subplot(2,1,2), plot(w_H12, unwrap(angle(H12f))); 
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Fase(grados)');

%----------
M = 40;
den = pi* (n - M/2);
num = sin(wc* (n-M/2));

fa=num./ den;
fa(den ==0)= wc;

ventana_rectangular= n>=0 & n<= M-1;
H13 = (fa) .* ventana_rectangular;

H13f=fftshift(fft(H13)); 
w_H13= 2*pi* ( 0:N)/ N; 
w_H13= fftshift( w_H13);
w_H13= unwrap( w_H13 - 2*pi); 

figure;
subplot(2,1,1),plot( w_H13, 20*log10(abs( H13f)));
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Magnitud (dB)');
subplot(2,1,2), plot(w_H13, unwrap(angle(H13f))); 
xlabel('Frecuencia (pi rad/muestras)'), ylabel('Fase(grados)');

