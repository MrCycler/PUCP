%% Ejercicio 2
clc
clear all
close all

%% Procedimiento

% Definiendo pará¡metros del filtro
N=30; M=N/2;                % Orden del filtro y su mitad
nn=(-M:M);nn1=nn+M;        % Duracion de la respuesta al impulso 
fn=(0:511)/511;
impulse_delayed= zeros(1,N+1); impulse_delayed(M+1)= 1; % Impulse
fc_HP= 0.8; 
gHP= impulse_delayed-fc_HP*sinc(fc_HP*nn);
gHP1=fir1(N,fc_HP,'high',hamming(N+1)); %Respuesta al impulso del filtro
gHP2=fir1(N,fc_HP,'high',blackman(N+1)); %Respuesta al impulso del filtro

GHP= abs(freqz(gHP,1));
GHP1= abs(freqz(gHP1,1));
GHP2= abs(freqz(gHP2,1));

subplot(211), stem(nn1,gHP), hold on, stem(nn1,gHP1,'r.'), hold on, stem(nn1,gHP2,'k*')
subplot(212), plot(fn,20*log10(GHP), fn,20*log10(GHP1),'r:',fn, 20*log10(GHP2),'k:')
%%
% Ejercicio 3

clc
clear all
close all

%% Parámetros inicales y selección arbitraria de T 

wp = 0.25*pi;
ws = 0.65*pi;
Rp = 2;
Rs = 25;

T = 0.8;
Fs = 1/T;

Wp = (2/T) * tan(wp/2);
Ws = (2/T) * tan(ws/2);

%% Diseño del filtro analógico (se puede comprobar analíticamente que N=3 y Ha(s)=1/[s^3 + 3.13s^2 + 4.89s + 3.82]) (revisar diapositivas 35 y 36, clase 7)

[N,Wn] = buttord(Wp,Ws,Rp,Rs,'s'); % Estimo el orden del filtro

[na,da] = butter(N,Wn,'s'); % Diseño el filtro


%% Diseño de filtro discreto mediante ambos metodos
[nd,dd]=bilinear(na,da,Fs);

[ndi, ddi] = impinvar(na,da,Fs);
%% Ploteo de los filtros obtenidos

[H, w] = freqz(nd,dd);

w = w/w(end);

[Hi, wi] = freqz(ndi,ddi);

wi = wi/wi(end);
%% Graficas de magnitud y fase del filtro diseñado

subplot(2,1,1), plot(w, 20*log10(abs(H))) 
xlabel('Frecuencia normalizada bi(p rad/muestras)'), ylabel('Magnitud (dB)'), grid

subplot(2,1,2), plot(w, unwrap(angle(H))); 
xlabel('Frecuencia normalizada bi(p rad/muestras)'), ylabel('Fase(grados)'), grid

figure;
subplot(2,1,1), plot(wi, 20*log10(abs(Hi))) 
xlabel('Frecuencia normalizada inv(p rad/muestras)'), ylabel('Magnitud (dB)'), grid

subplot(2,1,2), plot(wi, unwrap(angle(Hi))); 
xlabel('Frecuencia normalizada inv(p rad/muestras)'), ylabel('Fase(grados)'), grid
