clear;
close all;
clc;

%%%%%%%%%%%%%
% Pregunta 2
%%%%%%%%%%%%%

% 2a Diseño del filtro pasabajos
Fs = 1000; %frecuencia de muestreo
Fc = 40/(Fs/2); % frecuencia de corte normalizada 
orden = 32;
NFFT = 512;
b_bajos = fir1(orden,Fc,hamming(orden+1));
H = abs(fftshift(fft(b_bajos,NFFT)));
w_axis = 2*pi*(-NFFT/2+1:NFFT/2)/NFFT; % eje de frecuencia normalizada
figure, plot(w_axis,20*log10(H));
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Magnitud');
title('Filtro pasa-bajos usando fir1');

% 2b Diseño del filtro pasaaltos
Fs = 1000; %frecuencia de muestreo
Fc = 80/(Fs/2); % frecuencia de corte normalizada 
long_filtro = 10;
frec_vector = linspace(0,1,long_filtro)'; %valores de frecuencia
amp_vector = zeros(long_filtro,1); amp_vector(frec_vector>Fc)=1; %definir valores deseados de respuesta
orden = 32;
NFFT = 512;
b_altos = fir2(orden,frec_vector,amp_vector);
H = abs(fftshift(fft(b_altos,NFFT)));
w_axis = 2*pi*(-NFFT/2+1:NFFT/2)/NFFT; % eje de frecuencia normalizada
figure, plot(w_axis,20*log10(H));
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Magnitud');
title('Filtro pasa-altos usando fir2');

% 2c
b_paralelo = b_bajos + b_altos; % respuesta de filtros en paralelo
NFFT=512;
H = abs(fftshift(fft(b_paralelo,NFFT)));
w_axis = 2*pi*(-NFFT/2+1:NFFT/2)/NFFT; % eje de frecuencia normalizada
figure, plot(w_axis,20*log10(H));
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Magnitud');
title('Filtro notch en estructura paralela');


% 2d Filtrar señal
load 'emg.mat'
Fs = 1000; %frecuencia de muestreo
filtrada1 = filter(b_bajos,1,emg) + filter(b_altos,1,emg);
NFFT = 2^nextpow2(length(emg)); % nextpow proporciona el exponentes de la siguiente potencia de dos. La ejecución FFT es más rápida si se realiza en una secuencia cuya longitud es una potencia de dos.
Mag_entrada = abs(fftshift(fft(emg,NFFT)));
Mag_salida = abs(fftshift(fft(filtrada1,NFFT)));
w_axis = 2*pi*(-NFFT/2+1:NFFT/2)/NFFT; % eje de frecuencia normalizada
figure;
subplot(1,2,1), plot(w_axis,(Mag_entrada));
title('Espectro de Magnitud - Entrada');
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Amplitud');
subplot(1,2,2), plot(w_axis,(Mag_salida));
title('Espectro de Magnitud - Filtrada');
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Amplitud')
[minimo,pos] = min(abs(w_axis-2*pi*60/Fs));  % buscar la frecuencia más cercana a 2*pi*60/1000
atenuacion = 20*log10(Mag_salida(pos)/Mag_entrada(pos))

% 2e Transformada bilineal
wc = 2*pi*60;
sigma = 20;
NFFT = 512;
num_analog = [1 0 wc^2];
den_analog = [1 sigma wc^2];
[numd,dend] = bilinear(num_analog,den_analog,Fs);
figure, freqz(numd,dend,NFFT);
title('Filtro notch con transformada bilineal');

% 2f Transformada bilineal
load 'emg.mat'
Fs = 1000; %frecuencia de muestreo
filtrada2 = filter(numd,dend,emg);
NFFT = 2^nextpow2(length(emg)); % nextpow proporciona el exponentes de la siguiente potencia de dos. La ejecución FFT es más rápida si se realiza en una secuencia cuya longitud es una potencia de dos.
Mag_entrada = abs(fftshift(fft(emg,NFFT)));
Mag_salida = abs(fftshift(fft(filtrada2,NFFT)));
w_axis = 2*pi*(-NFFT/2+1:NFFT/2)/NFFT; % eje de frecuencia normalizada
figure
subplot(1,2,1), plot(w_axis,(Mag_entrada));
title('Espectro de Magnitud - Entrada');
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Amplitud');
subplot(1,2,2), plot(w_axis,(Mag_salida));
title('Espectro de Magnitud - Filtrada')
xlabel('Frecuencia normalizada (rad/muestra)');
ylabel('Amplitud');
[minimo,pos] = min(abs(w_axis-2*pi*60/Fs));  % buscar la frecuencia más cercana a  2*pi*60/1000
atenuacion = 20*log10(Mag_salida(pos)/Mag_entrada(pos))

% 2g tiempos
tic
filtrada1 = filter(b_bajos,1,emg) + filter(b_altos,1,emg);
toc
tic
filtrada2 = filter(numd,dend,emg);
toc
