%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% App 03
%% Problema 1
clear all;
close all;
clc;
%% A)
load('ode.mat');
fs=fs;
N=10183;
n=0:N-1;
%sound(x);
x_m(abs(x)>0.7)=1;
x_m(abs(x)<=0.7)=0;

u_n=x_m; % Pulsos por minuto
v_n=u_n-mean(u_n);

fft_v=fft(v_n); % frecuencia
fft_vn=fft_v/max(abs(fft_v));
mag_v=abs(fft_vn);% magnitud
fase_v=angle(fft_vn); % fase
w_m=max(mag_v); %maximo valor
find(mag_v==w_m);

figure
subplot(211);plot(n,mag_v);title('X (ejw)');
subplot(212);plot(n,abs(fase_v/max(fase_v)));title('fase X(ejw)');

%% B)

M=50;
N=M/2;
nn=(-M:M);
nn1=nn+M;
m=512;
fn=(0:m-1)/(m-1);
imp_d=zeros(1,N+1);
frec_notas1=[123 130 146 164 174]./fs;
frec_notas2=[146 164 174 195 220]./fs;

b1=fir1(N,frec_notas1,'bandpass'); % Aplicamos el filtro tipo 1
A1=freqz(b1);
n_size=2*size(A1,1);%Normalizamos las frecuencias
w=2*pi*(0:(n_size-1))/n_size;
w=fftshift(w);%Desfasamos
w=unwrap(w-2*pi);
p1=[A1' A1'];

b2=fir1(N,frec_notas2,'bandpass'); % Aplicamos el filtro tipo 1
A2=freqz(b2);
n_size2=2*size(A2,1);%Normalizamos las frecuencias
w2=2*pi*(0:(n_size2-1))/n_size2;
w2=fftshift(w2);%Desfasamos
w2=unwrap(w2-2*pi);
p2=[A2' A2'];


%% C)
M=100;
alpha=0;
N=M/2;
k=0:N-1;
w=2*pi*(k+alpha)/M;
frec_re=[130 164]./1000;
m=[1 1];
b3=fir2(N,frec_re,m); % Aplicamos el filtro tipo 1
A3=freqz(b3);
n_size3=2*size(A3,1);%Normalizamos las frecuencias
w3=2*pi*(0:(n_size3-1))/n_size3;
w3=fftshift(w3);%Desfasamos
w3=unwrap(w3-2*pi);
p3=[A3' A3'];



%% D)

L=5; % orden 5
N=512;
n=0;N-1;

w1=frec_notas1;
w2=frec_notas2;


[fnumd, fdend] = butter(L,frec_notas1/(frec_notas2/2),'bandpass');
freqz(fnumd(1:end-1),fdend(1:end-1));

%% E)
N=550;
v_x=x((i-1)*N+1:i*N);




