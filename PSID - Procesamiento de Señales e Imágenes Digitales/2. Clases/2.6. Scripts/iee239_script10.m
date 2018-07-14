% IEE239: script10 - Filtros Wiener
% Solucion al ejercicio propuesto.

close all; clear all;

% --- parametros de filtro wiener --- %
p= 50;  % orden del filtro
m= 50; % desplazamiento
% --- END parametros de filtro wiener --- %

% --- secuencias de entrada --- %
N= 1024;
n_v= 0: N- 1;    % espacio de muestras
omega= pi/256;
u_v= 25* sin( omega* n_v); % senal deseada
n_var= 1;   % varianza de ruido blanco (media 0)
eta_v= sqrt( n_var)* randn( 1, N); % ruido blanco
y_v= u_v+ eta_v;    % senal deseada
% --- END secuencias de entrada --- %

% --- entrada del sistema FIR --- %
d= y_v;  % secuencia deseada
x_v= [ zeros( 1, m) y_v( 1: end- m)];  % secuencia en atraso con respecto a d
% --- END entrada del sistema FIR --- %

% --- coeficientes del filtro wiener --- %
[r, lags_r]= xcorr( d, x_v);   % correlacion cruzada dx
[rr, lags_rr]= xcorr( x_v);    % autocorrelacion x
r_idx= find( lags_r== 0);   % ubicacion de indice n= 0
rr_idx= find( lags_rr== 0); % ubicacion de indice n= 0

gamma_v= r( 1, r_idx: r_idx+ p- 1);  % vector \gamma= [r_{dx}(0) ... r_{dx}(P-1)]
rr_part= rr( 1, rr_idx: rr_idx+ p- 1);  %  vector [r_{xx}(0) ... r_{xx}(P-1)]
upsilon_mat= toeplitz( rr_part); % matriz de autocorrelacion \upsilon
w= upsilon_mat\ transpose( gamma_v);  % coeficientes del filtro wiener (solucion al sistema lineal de Wiener-Hopf)
d_hat= conv( x_v, w); % secuencia de salida del sistema FIR
% --- END coeficientes del filtro wiener --- %

% --- descripcion grafica --- %
f01= figure;
plot( d, '-ro'); hold on;
plot( x_v, '-ko'); hold on;
plot( d_hat, '-bo');
legend('sec. deseada d[n]','sec con retraso x[n]', 'sec. estimada \hat{d}[n]');
title('Filtro Wiener predictivo')
% --- END descripcion grafica --- %