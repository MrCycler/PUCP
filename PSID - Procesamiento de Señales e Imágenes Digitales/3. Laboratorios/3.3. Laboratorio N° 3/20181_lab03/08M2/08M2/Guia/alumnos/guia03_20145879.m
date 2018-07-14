%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% Guia 03

clear all;
close all;
clc;


%%  Problema 01

load('p1.mat');

%% 1.A
N=100;
n=0:500-1;
frec_corte=0.4*pi;
num=[frec_corte];
den=[1 frec_corte frec_corte^2];

w=2*pi*40/1000;
T=(2/frec_corte)*tan(w/2); % Filtro digital requerido
[numB,denB]=bilinear(num,den,1/T);% Se aplica transformacion bilineal
freqz(numB,denB);
hL=impz(numB,denB,N); % Se toman primeras 20 muestras

% Convolucionamos para x1
conv1=conv(x1,hL);
conv2=conv(x2,hL);
conv3=conv(x3,hL);
figure();
subplot(3,3,1) %Convolucion 1
plot(n,conv1);ylim([-1.5 1.5]);title('Pasabajo');
subplot(3,3,4) %Convolucion 2
plot(n,conv2);ylim([-1.5 1.5]);title('Pasabajo');
subplot(3,3,7) %Convolucion 3
plot(n,conv3);ylim([-1.5 1.5]);title('Pasabajo');


%% 1.B

N=50; % orden 50
M=50/2;
nn=(-M:M);
nn1=nn+M;
m=512;
fn=(0:m-1)/(m-1);

n=0:1424-1;
imp_d=zeros(1,N+1);
%imp_d(M+1)=exp(-j.*w.*M./2);


fc=[2*100/1000 2*180/1000]; % frec de corte
b1=fir1(N,fc,'bandpass',kaiser(N+1,0.5)); % Aplicamos el filtro tipo 1
A1=freqz(b1);
%Normalizamos las frecuencias
n_size=2*size(A1,1);

w=2*pi*(0:(n_size-1))/n_size;
%Desfasamos
w=fftshift(w);
w=unwrap(w-2*pi);
p1=[A1' A1'];





%p1=p1.*exp(-j.*w.*M/2);

conv1k=conv(x1,p1);
conv2k=conv(x2,p1);
conv3k=conv(x3,p1);
%Graficamos el espectro de magnitud y fase

subplot(3,3,2)%Respuesta 1
plot(n,conv1k);ylim([-1.5 1.5]);title('PasaBanda Kaiser');
subplot(3,3,5)%Respuesta 1
plot(n,conv2k);ylim([-1.5 1.5]);title('PasaBanda Kaiser');
subplot(3,3,8)%Respuesta 1
plot(n,conv3k);ylim([-1.5 1.5]);title('PasaBanda Kaiser');

%% 1.C

frec_corte=2*400/1000;
n=50;
Rp=3;
Rs=50;
Wp=frec_corte;
[nd,dd]=ellip(n,Rp,Rs,Wp);
[hH,w]=freqz(nd,dd);
hH=abs(hH);
conv1C=conv(x1,hH);
conv2C=conv(x2,hH);
conv3C=conv(x3,hH);

subplot(333);plot(0:912-1,conv1C);ylim([-1.5 1.5]);title('Pasa altos eliptico');
subplot(336);plot(0:912-1,conv2C);ylim([-1.5 1.5]);title('Pasa altos eliptico');
subplot(339);plot(0:912-1,conv3C);ylim([-1.5 1.5]);title('Pasa altos eliptico');

%% 1.D

% respuesta de x1
% Pasabajo: Alta
% Pasabanda: Alta
% Pasaaltos: Baja

% respuesta de x2
% Pasabajo: Ninguna
% Pasabanda: Baja
% Pasaaltos: Alta

% respuesta de x3
% Pasabajo: Baja
% Pasabanda: Alta
% Pasaaltos: Baja

% por lo que x1= s3
% por lo que x2= s2
% por lo que x3= s1

%% Problema 2

%'unknown_syst.p'

%% Problema 3
clear all;
close all;
clc
%% 3.A
load('audio_p3.mat');
N=5655;
n=0:N-1;
x_org=x;
wn=0.1.*randn(1,N);
xi=transpose(x)+wn;
x=xi./max(abs(wn));
x=x';
figure()
subplot(211);plot(n,x);title('Cambiado');
subplot(212);plot(n,x_org);title('Original');
sound(x,Fs);
sound(x_org,Fs);
%% 3.B
xn=x_org/max(abs(x_org));
nn=wn/max(abs(wn));
wnn=xi/max(abs(xi));

figure()
subplot(311);plot(n,abs(xn));title('X[n]');
subplot(312);plot(n,abs(nn));title('N[n]');
subplot(313);plot(n,abs(wnn));title('Wn[n]');


%% 3.C

L=256;
r=xcorr(wn); % autocorrelacion de x
rx=toeplitz(r(L:N+L-1)); % matriz de autocorrelacion
rdx1=xcorr(wn,transpose(x_org),'coeff'); %vector de autocorrelacion cruzada
rdx=rdx1(N: N+L-1);
w=rx\rdx;

x_filtrado=conv(x_org,w);

sound(x,Fs);
sound(x_org,Fs);
%% 3.E













