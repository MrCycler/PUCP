% IEE239: script 01 - Senales y sistemas discretos
% Descripcion: el script muestra la tasa de variacion de senales discretas
% (x01 - x05) en funcion a sus frecuencias angulares. El rango incluye
% frecuencias angulares entre 0 y 2pi, por lo que se aprecia el efecto
% Aliasing en algunas de las senales. Adicionalmente, se muestra que una
% senal discreta (x_noperiodica) con frecuencia irracional es no periodica.

close all;   % cerrar ventanas
clear all;   % eliminar variables
clc

% --- parametros de las senales discretas --- %
a= 5;   % amplitud
f_v= 0: 1/4: 1; % vector de frecuencias (Hz)
w_v= 2* pi* f_v;    % vector de frecuencias angulares (rad)
theta= 0;    % fase
n_v= -25: 25;   % vector de puntos discretos en el tiempo (n)
t_v= -25: 0.01: 25;     % vector de puntos discretos en el tiempo considerablemente denso (aproximacion a dominio continuo t)
% --- END parametros de las senales discretas --- %


% --- parametros de la senal discreta no periodica --- %
f_irracional= pi/ 10;   % frecuencia (valor irracional)
w_irracional= 2* pi* f_irracional;  % frecuencia angular
% --- END parametros de la senal discreta no periodica --- %


% --- generar senales continuas y discretas --- %
x01= a* cos( w_v( 1).* n_v+ theta);
x01_cont= a* cos( w_v( 1).* t_v+ theta);

x02= a* cos( w_v( 2).* n_v+ theta);
x02_cont= a* cos( w_v( 2).* t_v+ theta);

x03= a* cos( w_v( 3).* n_v+ theta);
x03_cont= a* cos( w_v( 3).* t_v+ theta);

x04= a* cos( w_v( 4).* n_v+ theta);
x04_cont= a* cos( w_v( 4).* t_v+ theta);

x05= a* cos( w_v( 5).* n_v+ theta);
x05_cont= a* cos( w_v( 5).* t_v+ theta);

x_noperiodica= a* cos( ( w_irracional).* n_v);
x_noperiodica_cont= a* cos( ( w_irracional).* t_v);
% --- END generar senales continuas y discretas --- %


% --- descripcion grafica --- %
f01= figure;    % nueva ventana
subplot( 2, 1, 1);  % grafica dividida en 2 filas y 1 columna. graficar en la primera division
stem( n_v, x01, 'ro');
hold on;
plot( t_v, x01_cont);
grid on;    % incluir grilla
title( 'x01[n], w= 2\pi (0) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight; % ajustar ejes de la grafica a la informacion contenida

subplot( 2, 1, 2);  % grafica dividida en 2 filas y 1 columna. graficar en la segunda division
stem( n_v, x02, 'ro');
hold on;
plot( t_v, x02_cont);
grid on;
title( 'x02[n], w= 2\pi (1/4) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight;

f02= figure;
subplot( 2, 1, 1);
stem( n_v, x03, 'ro');
hold on;
plot( t_v, x03_cont);
grid on;
title( 'x03[n], w= 2\pi (1/2) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight;

subplot( 2, 1, 2);
stem( n_v, x04, 'ro');
hold on;
plot( t_v, x04_cont);
grid on;
title( 'x04[n], w= 2\pi (3/4) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight;


f03= figure;
subplot( 2, 1, 1);
stem( n_v, x05, 'ro');
hold on;
plot( t_v, x05_cont);
grid on;
title( 'x05[n], w= 2\pi (1) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight;

subplot( 2, 1, 2);
stem( n_v, x_noperiodica, 'ro');
hold on;
plot( t_v, x_noperiodica_cont);
grid on;
title( 'x[n] (no periodica), w= 2\pi (\pi/10) rad');
ylabel( 'amplitud');
xlabel( 'muestras');
axis tight;
% --- END descripcion grafica --- %