% IEE239: script 06 - Serie y Transformada de Fourier en tiempo contínuo
%
% El script genera la descripcion grafica de la serie de fourier de tiempo
% continuo de una senal cuadrada periodica. Luego, se muestra la
% descripcion grafica de la transformada de Fourier para la version no
% periodica de la senal cuadrada. Se muestra como el espectro de una señal
% continua periodica corresponde a muestras del espectro de la senal
% continua no periodica. Se muestra ademas que ambos espectros no
% son periodicos

close all; clear all;

% --- serie de fourier en tiempo continuo --- %
T2= 20; % periodo
T1= 5; % intervalo en valor 1
k_v= -25: 25;   % valores de k evaluados

c_v= 1./ (pi* k_v).* sin( 2* pi* k_v/ T2* T1);  % serie de Fourier
c_v( k_v== 0)= 2* T1/ T2;   % valor en k= 0 (l'hospital)

fig01= figure;
subplot( 2, 1, 1); stem( k_v, c_v);
ylabel( 'c_{k}'); xlabel( 'k');
title( 'serie de Fourier de senal cuadrada periodica'); grid on;
% --- END serie de fourier en tiempo continuo --- %


% --- transformada de fourier en tiempo continuo --- %
T1= 5; % intervalo en valor 1
Omega_v= 2* pi/ T2* ( -25: 0.01: 25); % valores de Omega evaluados (aproximación de dominio contínuo)

X_v= 2./ Omega_v.* sin( Omega_v* T1);   % transformada de Fourier
X_v( Omega_v== 0)= 2* T1;   % valor en k= 0 (l'hospital)

fig02= figure;
subplot( 2, 1, 1); plot( Omega_v, X_v, 'r');
ylabel( 'X(j\Omega)'); xlabel( '\Omega');
title( 'Transformada de Fourier de senal cuadrada no periodica'); grid on
% --- END transformada de fourier en tiempo continuo --- %


% --- contraste CTFS y CTFT --- %
fig03= figure;
subplot( 2, 1, 1); stem( 2* pi* k_v/ T2, T2* c_v); hold on;
plot( Omega_v, X_v, 'r');
xlabel( '\Omega'); title( 'Relacion c_{k} vs. X(j\Omega)');
legend( 'c_{k}', 'X(j\Omega)'); grid on;
% --- END contraste CTFS y CTFT --- %

saveas( fig03, 'compcont.eps', 'epsc');

%%

% IEE239: script 06 - Serie y Transformada de Fourier en tiempo discreto
%
% El script genera la descripcion grafica de la serie de fourier de tiempo
% discreto de una senal cuadrada periodica. Luego, se muestra la
% descripcion grafica de la transformada de Fourier para la version no
% periodica de la senal cuadrada. Se muestra como el espectro de una señal
% continua periodica corresponde a muestras delqu espectro de la senal
% continua no periodica. Se muestra ademas que ambos espectros son
% periodicos

close all; clear all;

% --- serie de fourier en tiempo discreto --- %
N= 20;  % periodo
N1= 5; % intervalo en valor 1

k_v= -25: 25;   % valores de k evaluados  
c_v= 1/ N* sin( pi* k_v/ N* ( 2* N1+ 1))./ sin( pi/ N* k_v);  % serie de Fourier
c_v( mod(k_v, N)== 0)= 1/ N* (2* N1+ 1);   % valor en multiplos de N= 0 (l'hospital)

fig01= figure;
subplot( 2, 1, 1); stem( k_v, c_v);
ylabel( 'c_{k}'); xlabel( 'k');
title( 'serie de Fourier de senal cuadrada periodica'); grid on;
% --- END serie de fourier en tiempo discreto --- %


% --- transformada de fourier en tiempo discreto --- %
N1= 5; % intervalo en valor 1

w_v= 2* pi/ N* ( -25: 0.01: 25);   % valores de w evaluados (aproximación de dominio contínuo)
X_v= sin( w_v/ 2* ( 2* N1+ 1))./ sin( w_v/ 2);  % transformada de Fourier
X_v( mod(w_v, 2* pi)== 0)= ( 2* N1+ 1);   % valor en multiplos en 2\pi= 0 (l'hospital)

fig02= figure;
subplot( 2, 1, 1); plot( w_v, X_v, 'r');
ylabel( 'F(e^{j\omega})'); xlabel( '\omega');
title( 'Transformada de Fourier de senal cuadrada no periodica'); grid on
% --- END transformada de fourier en tiempo discreto --- %


% --- contraste DTFS y DTFT --- %
fig03= figure;
subplot( 2, 1, 1); stem( 2* pi* k_v/ N, N* c_v); hold on;
plot( w_v, X_v, 'r');
xlabel( '\omega'); title( 'Relacion c_{k} vs. F(e^{j\omega})');
legend( 'c_{k}', 'X(e^{j\omega})'); grid on;
% --- END contraste DTFS y DTFT --- %

saveas( fig03, 'compdisc.eps', 'epsc');

%%

% IEE239: script 06 - Transformada Discreta de Fourier
%
% El script genera la descripcion grafica de transformada discreta de
% Fourier de una senal cuadrada no periodica. Luego, se muestra la
% descripcion grafica de la transformada de Fourier en tiempo discreto para
% la misma senal. Finalmente, se demuestra que la transformada discreta de
% Fourier corresponde a muestras de la transformada de Fourier de tiempo
% discreto

close all; clear all;

L= 5;   % intervalo con valor 1
N= 10;  % muestras en el círculo unitario: w_{k}= \frac{2* pi* k}{N}

% --- transformada de Fourier en tiempo discreto--- %
w_v= 2* pi/ N* ( -25: 0.1: 25);   % valores de w evaluados (aproximación de dominio contínuo)
DTFT_v= exp( -1i* 2* w_v).* sin( 5* w_v/ 2)./ sin( w_v/ 2); % transformada de Fourier en tiempo discreto
DTFT_v( mod( w_v, 2* pi)== 0)= 5;

fig01= figure;
subplot( 2, 1, 1); plot( w_v, abs( DTFT_v), 'r');
ylabel( 'X(e^{j\omega})'); xlabel( '\omega');
title( 'Transformada de Fourier en tiempo discreto de senal cuadrada'); grid on;
% --- END transformada de Fourier en tiempo discreto--- %


% --- transformada discreta de Fourier --- %
k_v= -25: 25;   % valores de k evaluados
DFT_v= exp( -1i* 4* pi* k_v/ N).* sin( 5* pi* k_v/ N)./ sin( pi* k_v/ N);   % transformada discreta de Fourier
DFT_v( mod( k_v, N)== 0)= 5;

fig02= figure;
subplot( 2, 1, 1); stem( k_v, abs( DFT_v));
ylabel( 'X(k)'); xlabel( 'k');
title( 'Transformada discreta de Fourier de senal cuadrada'); grid on
% --- END transformada discreta de Fourier --- %

% --- contraste entre DTFT y DFT --- %
fig03= figure;
subplot( 2, 1, 1); stem( 2* pi* k_v/ N, abs( DFT_v)); hold on;
plot( w_v, abs( DTFT_v), 'r');
xlabel( '\omega'); title( [ 'Relacion |X(k)| vs. |X(e^{j\omega})| para N= ' num2str( N)]);
legend( '|X(k)|', '|X(e^{j\omega})|'); grid on;
% --- END contraste entre DTFT y DFT --- %
