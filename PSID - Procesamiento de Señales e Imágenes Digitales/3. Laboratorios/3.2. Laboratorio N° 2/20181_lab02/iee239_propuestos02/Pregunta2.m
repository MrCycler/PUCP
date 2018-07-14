%% Propuesta 2
%% Solucion
clear
clc
% Frecuencias de la expresion discreta
f1=120;
f2=240;
% Frecuencia y periodo de muestreo
Fs =1440;
Ts = 1/Fs;
%Numero de muestras y vector de secuencia
N1=360;
n1=0:N1-1;
% Secuencia discreta
x1=sin(2*pi*f1*n1*Ts)+cos(2*pi*f2*n1*Ts);
% Grafica en el tiempo discreto
subplot(311),plot(n1*Ts,x1);
ylabel('x_c(nTs)'),xlabel('Tiempo(s)'),grid on
% Transformada de Fourier
Y1=fft(x1);
% Centrar el espectro
Y_shift1=fftshift(Y1);
% Magnitud de la transformada
Y_mag1=abs(Y_shift1);
% Fase de la transformada de Fourier
Fase=unwrap(angle(Y1));
% Vector de muestra de frecuencia en el rango fundamental
w_n=2*pi*(0:N1-1)/N1;
w_n=unwrap(fftshift(w_n)-2*pi);
% Gráficas del espectro de magnitud y fase
subplot(312),stem(w_n,Y_mag1,'-r'); 
ylabel('|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on
subplot(313),plot(w_n,Fase,'-k');
ylabel('\angle|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on
%%
% Solucion
% Frecuencias de la expresion discreta
f1=120;
f2=240;
% Frecuencia y periodo de muestreo
Fs =1440;
Ts = 1/Fs;
%Numero de muestras y vector de secuencia
N=640;
n=0:N-1;
% Secuencia discreta
x=sin(2*pi*f1*n*Ts)+cos(2*pi*f2*n*Ts);
% Grafica en el tiempo discreto
subplot(311),plot(n*Ts,x);
ylabel('x_c(nTs)'),xlabel('Tiempo(s)'),grid on
% Magnitud de la transformada de Fourier
Y=fft(x);
Y_shift=fftshift(Y);
Y_mag=abs(Y_shift);
% Fase de la transformada de Fourier
Fase=unwrap(angle(Y));
% Vector de muestra de frecuencia en el rango fundamental
w=2*pi*(0:N-1)/N;
w=unwrap(fftshift(w)-2*pi);
% Gráficas del espectro de magnitud y fase
subplot(312),stem(w,abs(Y_mag),'-r'); 
ylabel('|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on
subplot(313),plot(w,Fase,'-k');
ylabel('\angle|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on

%%
% Solucion
% Hard thresholding
Y_HT=Y_mag>150;
% Producto punto en frecuencia.
Y_new=fftshift(Y).*Y_HT;
Y_new_mag=abs(Y_new);
Y_new_phase=unwrap(phase(Y_new));
% Graficas
figure,
subplot(121),stem(w,Y_new_mag),title('Espectro de magnitud'),
ylabel('|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on
subplot(122),plot(w,Y_new_phase,'-k'),title('Espectro de fase'),
ylabel('\angle|X(e^{j \omega})|'),xlabel('Frecuencia (\omega)'),grid on
%%
% Solucion
% Transformada inversa de Fourier de ambas secuencias
x_orig=ifft(ifftshift(Y_shift));
x_inv_new=ifft(ifftshift(Y_new));
% Graficas
figure,
subplot(211),plot(n*Ts,x_orig), title('Original'),grid on,ylabel('x_c(nTs)'),xlabel('Tiempo(s)')
subplot(212),plot(n*Ts,x_inv_new,'-r'), title('Reconstruccion por hard thresholding'),grid on,ylabel('x_{ci}(nTs)'),xlabel('Tiempo(s)')
