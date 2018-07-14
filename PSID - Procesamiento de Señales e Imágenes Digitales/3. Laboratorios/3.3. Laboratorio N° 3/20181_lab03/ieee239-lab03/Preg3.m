close all; clear all;
% Pregunta 3
%% a) 
N1 = 5;
N = 20;
n = -N/2:N/2-1;                   % vector de muestras discretas
w = 2* pi*(-30: 0.01: 30)/N;   

% Secuencia
x = [ones(1,N1+1) zeros(1,N/2-N1)];
x_n = [x(end:-1:1+1) x(2:end)];
% Del cálculo analítico:
X = exp(1i*2*w).*sin((2*N1+1)*w/2)./sin(w/2);
X(mod(w,2*pi)==0)= 11;

figure(01);
subplot(311); 
stem(n,x_n);xlabel('n');
ylabel('x[n]'); title('Secuencia rectangular');
subplot(312),
plot(w, abs(X),'r');
ylabel('|X(e^{j\omega})|'); xlabel('\omega');
title('DFT '); grid on;
subplot(313),
plot(w,(angle(X)),'k');
ylabel('<X(e^{j\omega})');xlabel('\omega');
title('Fase'); grid on;

%% b)
% clear all; close all; clc;
Wp = 0.35;
Ws = 0.50;

Rp = 2;           %rizado en banda de paso
Rs = 50;            %rizado en banda de rechazo
%Orden del filtro Butterworth 
[n_butt,Wn_b] = buttord(Wp,Ws,Rp,Rs); 

%% c)
[b1, a1] = butter(n_butt, Wn_b,'s');

N = 20;
w = 2* pi*(-30: 0.01: 30)/N; 
[h1,w1] = freqs(b1,a1,w);

figure(1),
subplot(211),
plot(w1,(abs(h1))),grid on,
ylabel('|H(j\Omega)|^{2}'); xlabel('\Omega');
title('Magnitud'); 

subplot(212),
plot(w1,unwrap(angle(h1))),grid on,
ylabel('<H(j\Omega)'); xlabel('\Omega');
title('Fase'); 

%% e)
N = 53;
h1 = fir1(N, [0.425]);    % filtro FIR
w1 = hamming(length(h1));     % por método de enventanado Hamming

figure; 
freqz(h1'.*w1, 1); title('Filtro a partir de enventanado Hamming');

%% f)
s1 = x_n;
wd = linspace(-1, 1, length(s1));
tic
y_butt = filter(b1,a1,s1);      %salida de IIR
toc
tic
y_win = conv(s1,h1'.*w1);       %salida de FIR
toc

%Calculo del espectri de magnitudes
mag_ybut = fftshift(abs(fft(y_butt)));
mag_ywin = fftshift(abs(fft(y_win(1:length(s1))))); %trunca señal

w_but = 2*pi*(0:(length(mag_ybut)-1))/length(mag_ybut);  % frecuencia discreta (de 0 a 2pi)
w_but = unwrap( fftshift(w_but)-2*pi);   % frecuencia discreta(de -pi a pi)

w_win = 2*pi*(0:(length(mag_ywin)-1))/length(mag_ywin);  % frecuencia discreta (de 0 a 2pi)
w_win = unwrap( fftshift(w_win)-2*pi);   % frecuencia discreta(de -pi a pi)

figure,
subplot(121),
plot(w_win,mag_ywin,'r');
xlabel('Frecuencia (\omega)'), ylabel('amplitud'),title('Espectro de magnitd de y1'),grid on,
subplot(122),
plot(w_but,mag_ybut);
xlabel('Frecuencia (\omega)'), ylabel('amplitud'),title('Espectro de magnitud de y2'),grid on,

figure,
subplot(121),
plot(w_win,angle(fft(y_win(1:length(s1)))),'r');
xlabel('Frecuencia (\omega)'), ylabel('fase'),title('Fase de y1'),grid on,
subplot(122),
plot(w_but,angle(fft(y_butt)));
xlabel('Frecuencia (\omega)'), ylabel('fase'),title('Fase de y2'),grid on,
