clear all
close all
clc

% ******************* %
%     Pregunta (a)    %
% ******************* %

Fs = 2000;
Ts = 1/Fs;
Time = 0.5;
% **** Vectores de muestras **** %
N = Time/Ts;
n = 0 : 1 : 0.5/Ts - 1;
% **** Generacion la expresion discreta **** %
r1 = 10*sin(2*pi*50*n*Ts) + 5*cos(2*pi*100*n*Ts) + 2*cos(2*pi*250*n*Ts);
r2 = 20*sin(2*pi*50*n*Ts) + 10*cos(2*pi*150*n*Ts) ;

% **** Calculo del espectro de magnitud **** %
R1f=abs(fftshift(fft(r1,1024))); % Espectro de magnitud
R2f=abs(fftshift(fft(r2,1024))); % Espectro de magnitud

wr1 = 2*pi* ( 0: ( length(R1f)- 1))/ length(R1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wr1 = unwrap( fftshift(wr1) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

wr2 = 2*pi* ( 0: ( length(R2f)- 1))/ length(R2f);  % puntos discretos en frecuencia (de 0 a 2pi)
wr2 = unwrap( fftshift(wr2) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)


% **** Graficas **** %
figure;
subplot(2,2,1);
plot(n,r1); title('r1 en espacio de muestras'); ylabel('amplitud'); xlabel('muestras (n)'); axis tight;
subplot(2,2,2);
plot(wr1,R1f); title('Espectro de magnitud de r1'); ylabel('|R1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,2,3);
plot(n,r2); title('r2 en espacio de muestras'); ylabel('amplitud'); xlabel('muestras (n)'); axis tight;
subplot(2,2,4);
plot(wr2,R2f); title('Espectro de magnitud de r2'); ylabel('|R2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;


% ******************* %
%     Pregunta (b)    %
% ******************* %

D = 2; 

% **** Decimacion (Opcion 1) **** %
% Generar el filtro pasabajos
M = 50;
m = 0:M-1;
hlp = 1/D * sinc(1/D*(m-M/2));

z1 = conv(r1,hlp,'same'); % Filtrado
z1 = z1(1:D:end); % Submuestreo
% z1 = donwsample(r,D); % dowsampling usando el comando propio de MATLAB 

% **** Decimacion (Opcion 2) **** %
z2 = decimate(r1,D);

% **** Calculo del espectro de magnitud **** %
Z1f=abs(fftshift(fft(z1,1024))); 
Z2f=abs(fftshift(fft(z2,1024)));

wz = 2*pi* ( 0: ( length(Z1f)- 1))/ length(Z1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wz = unwrap( fftshift(wz) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

figure
subplot(1,3,1)
plot(wr1,R1f); title('Señal original'); ylabel('|R1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(1,3,2)
plot(wz,Z1f,'r'); title('Opcion 1'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(1,3,3)
plot(wz,Z2f,'g'); title('Opcion 2'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;



% ******************* %
%     Pregunta (c)    %
% ******************* %
D1 = 2;
D2 = 3;

% Generar el filtro pasabajos
M = 50;
m = 0:M-1;
hlp1 = 1/D1 * sinc(1/D1*(m-M/2)); % Filtro 1
hlp2 = 1/D2 * sinc(1/D2*(m-M/2)); % Filtro 2

% Convolucion y submuestreo
y1 = conv(r1,hlp1,'same'); % Primera diezmado
y1 = y1(1:D1:end);
z1 = conv(y1,hlp2,'same'); % Segunda diezmado

y2 = conv(r2,hlp2,'same'); 
y2 = y2(1:D1:end); 
z2 = conv(y2,hlp2,'same'); 
z2 = z2(1:D2:end); 


% **** Calculo del espectro de magnitud **** %
Y1f=abs(fftshift(fft(y1,1024))); 
Z1f=abs(fftshift(fft(z1,1024))); 

Y2f=abs(fftshift(fft(y2,1024))); 
Z2f=abs(fftshift(fft(z2,1024)));

wy = 2*pi* ( 0: ( length(Y1f)- 1))/ length(Y1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wy = unwrap( fftshift(wy) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

wz = 2*pi* ( 0: ( length(Z1f)- 1))/ length(Z1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wz = unwrap( fftshift(wz) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

figure
subplot(2,3,1)
plot(wr1,R1f); title('Señal r1'); ylabel('|R1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,2)
plot(wy,Y1f,'g'); title('Señal y1'); ylabel('|Y1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,3)
plot(wz,Z1f,'r'); title('Señal z1'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;

subplot(2,3,4)
plot(wr1,R2f); title('Señal r2'); ylabel('|R2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,5)
plot(wy,Y2f,'g'); title('Señal y2'); ylabel('|Y2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,6)
plot(wz,Z2f,'r'); title('Señal z2'); ylabel('|Z2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;


% ******************* %
%     Pregunta (d)    %
% ******************* %

D1 = 2;

% Generar el filtro pasabajos
M = 50;
m = 0:M-1;
hlp3 = 1/D1 * sinc(1/D1*(m-M/2));

% Diezmar y submuestrear en la secuencia r1
y1 = conv(r1,hlp3,'same'); 
y1 = y1(1:D1:end); 
z1 = y1(1:D2:end); 

% Diezmar y submuestrear en la secuencia r2
y2 = conv(r2,hlp3,'same'); 
y2 = y2(1:D1:end); 
z2 = y2(1:D2:end); 

% **** Calculo del espectro de magnitud **** %
Y1f=abs(fftshift(fft(y1,1024))); 
Z1f=abs(fftshift(fft(z1,1024))); 

Y2f=abs(fftshift(fft(y2,1024))); 
Z2f=abs(fftshift(fft(z2,1024)));

wy = 2*pi* ( 0: ( length(Y1f)- 1))/ length(Y1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wy = unwrap( fftshift(wy) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

wz = 2*pi* ( 0: ( length(Z1f)- 1))/ length(Z1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wz = unwrap( fftshift(wz) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

figure
subplot(2,3,1)
plot(wr1,R1f); title('Señal r1'); ylabel('|R1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,2)
plot(wy,Y1f,'g'); title('Señal y1'); ylabel('|Y1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,3)
plot(wz,Z1f,'r'); title('Señal z1'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;

subplot(2,3,4)
plot(wr1,R2f); title('Señal r2'); ylabel('|R2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,5)
plot(wy,Y2f,'g'); title('Señal y2'); ylabel('|Y2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(2,3,6)
plot(wz,Z2f,'r'); title('Señal z2'); ylabel('|Z2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;


% ******************* %
%     Pregunta (e)    %
% ******************* %

D3 = 6;

% Generar el filtro pasabajos
M = 50;
m = 0:M-1;
hlp4 = 1/D3 * sinc(1/D3*(m-M/2));

% Diezmado
z1 = conv(r1,hlp4,'same'); 
z1 = z1(1:D3:end); 

% **** Calculo del espectro de magnitud **** %
Z1f=abs(fftshift(fft(z1,1024))); 

wz = 2*pi* ( 0: ( length(Z1f)- 1))/ length(Z1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wz = unwrap( fftshift(wz) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

figure
subplot(1,2,1)
plot(wr1,R1f); title('Señal r1'); ylabel('|R1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(1,2,2)
plot(wz,Z1f,'r'); title('Señal z1'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;



% ******************* %
%     Pregunta (f)    %
% ******************* %

% **** Sistema Original **** %
I1 = 2; 
I2 = 2; 
D1 = 3; 
D2 = 2;

% Generar los filtro pasabajos
M = 50; 
m = 0:M-1;
hlp1 = 1/I1 * sinc(1/I1*(m-M/2)); % Filtro 1
hlp2 = 1/I2 * sinc(1/I2*(m-M/2)); % Filtro 2
hlp3 = 1/D1 * sinc(1/D1*(m-M/2)); % Filtro 3
hlp4 = 1/D2 * sinc(1/D2*(m-M/2)); % Filtro 4

up1 = zeros(I1*length(r1)-1, 1);
up1(1:I1:end) = r1;
up1 = conv(up1,hlp1,'same'); 

up2 = zeros(I2*length(up1)-1, 1);
up2(1:I2:end) = up1;
up2 = conv(up2,hlp2,'same'); 

dw1 = conv(up2,hlp3,'same'); 
dw1 = dw1(1:D1:end); 
dw2 = conv(dw1,hlp4,'same'); 
z0 = dw2(1:D2:end); 

% **** Sistema 1 **** %
I = 4;
D = 6;
% Generar los filtro pasabajos
M = 50; 
m = 0:M-1;
hlp1 = 1/I * sinc(1/I*(m-M/2));
hlp2 = 1/D * sinc(1/D*(m-M/2));

% Interpolacion
up1 = zeros(I*length(r1)-1, 1);
up1(1:I:end) = r1;            % Sobremuestreo
up1 = conv(up1,hlp1,'same');  % Filtrado
% Diezmado
dw1 = conv(up1,hlp2,'same');  % Filtrado
z1 = dw1(1:D:end);            % Submuestreo 

% **** Sistema 2 **** %
I = 4;
D = 6;
% Generar los filtro pasabajos
M = 50; 
m = 0:M-1;
hlp = 1/6 * sinc(1/6*(m-M/2));

% Sobremuestreo
up1 = zeros(I*length(r1)-1, 1);
up1(1:I:end) = r1;
% Filtrado
dw1 = conv(up1,hlp,'same'); 
% Submuestreo
z2 = dw1(1:D:end);

% **** Calculo del espectro de magnitud **** %
Z0f=abs(fftshift(fft(z0,1024))); 
Z1f=abs(fftshift(fft(z1,1024))); 
Z2f=abs(fftshift(fft(z2,1024))); 

wz = 2*pi* ( 0: ( length(Z1f)- 1))/ length(Z1f);  % puntos discretos en frecuencia (de 0 a 2pi)
wz = unwrap( fftshift(wz) - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)

figure
subplot(1,3,1)
plot(wz,Z0f); title('Sistema original'); ylabel('|Z0(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(1,3,2)
plot(wz,Z1f,'g'); title('Sistema 1'); ylabel('|Z1(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;
subplot(1,3,3)
plot(wz,Z2f,'r'); title('Sistema 2'); ylabel('|Z2(e^{j\omega})|'); xlabel('frecuencia (\omega)'); axis tight;



