clear all
close all
clc

%% a) Señal discreta 
N= 400;
n= 0:N-1;
Fs= 800;
nt= n/ Fs;
d= 2* cos(2* pi* 30* nt)+ cos(2* pi* 20* nt) + 0.5* cos(2* pi* 50* nt);  

%% b) Señal con ruido blanco 
wn = 0.5* randn(1, N); 
x = d + wn;
x=x';

%% c) Calcular el filtro optimo

M = 50; %orden del filtro 
r= xcorr(x);
Rx= toeplitz(r(N: N+M-1));%matriz de autocorrelacion

rdx1= xcorr(x, d); % vector de correlacion cruzada 
rdx= rdx1(N: N+M-1);

w= Rx\ rdx; %estimacion del filtro optimo

%% d) Senal luego del filtro
de = filter(w, 1, x);

%% e) Grafica en el espacio de muestras
figure();
subplot(3,1,1); plot(nt, d); title('Señal original');
subplot(3,1,2); plot(nt, x); title('Señal con ruido'); 
subplot(3,1,3); plot(nt, de); title(['Señal con estimada con el filtro Wiener de orden ' num2str(M)]); 

% Grafica en  frecuencia

figure();
Nf= 512; % numero de puntos a evaluar en frecuencia
d_f= fft(d, Nf)/Nf; %dft de la senal original
d_f= fftshift( d_f);

x_f= fft(x, Nf)/Nf; %dft de la senal con ruido
x_f= fftshift( x_f);

de_f= fft(de, Nf)/Nf; %senal estimada
de_f= fftshift( de_f);

w_f= 2* pi* ( 0: Nf-1)/ Nf; % crear el vector de frecuencias 
w_f= fftshift( w_f);
w_f= unwrap( w_f- 2* pi); 


subplot(3,1,1), plot( w_f, abs( d_f)); title('Señal deseada'); 
subplot(3,1,2), plot( w_f, abs( x_f)); title('Señal recibida'); 
subplot(3,1,3), plot( w_f, abs( de_f)); title('Señal estimada con Filtro Wiener')

% Repetir cambiando el orden del filtro


