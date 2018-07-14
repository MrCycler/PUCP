% IEE239: script 02 - Senales y sistemas discretos
% Descripcion: el script muestra el computo de la respuesta a diversos
% sistemas discretos ante una senal de entrada basica. Adicionalmente, se
% calcula la respuesta a un sistema LTI a partir del calculo directo y por
% convolucion.


%% respuesta a diversos sistemas por parte de una senal de entrada
close all; clear all;

% --- senal de entrada --- %
n_v= -20: 20;
x_v= abs( n_v);
x_v( n_v< -3)= 0;
x_v( n_v> 3)= 0;
% --- END senal de entrada --- %


% --- señales de salida --- %
y01_v= x_v; % sistema: identidad
y02_v= [ 0 x_v( 1: end- 1)];    % sistema: retardo de 1 muestra
y03_v= [ x_v( 2: end) 0];   % sistema: adelanto 1 muestra
y04_v= 1/3* ( y01_v+ y02_v+ y03_v); % sistema: filtro promedio
y05_v= median( [ y01_v; y02_v; y03_v], 1);  % sistema: filtro mediano

n_size= size( n_v, 2);  % tamaño del vector n_v
y06_v= zeros( 1, n_size); % inicialización del vector y06_v (memory allocation)

for i= 1: n_size
            y06_v( i)= sum( x_v( 1: i));  % sistema: acumulador
end
% --- END señales de salida --- %


% --- mostrar resultados --- %
fig_x= figure;
stem( n_v, x_v); title( 'señal de entrada'); ylabel( 'x[n]'); xlabel( 'n');
fig_y= figure;
subplot( 3, 2, 1); stem( n_v, y01_v); title( 'identidad'); ylabel( 'y01[n]'); xlabel( 'n');
subplot( 3, 2, 2); stem( n_v, y02_v); title( 'retardo de 1 muestra'); ylabel( 'y02[n]'); xlabel( 'n');
subplot( 3, 2, 3); stem( n_v, y03_v); title( 'adelanto de 1 muestra'); ylabel( 'y03[n]'); xlabel( 'n');
subplot( 3, 2, 4); stem( n_v, y04_v); title( 'filtro promedio'); ylabel( 'y04[n]'); xlabel( 'n');
subplot( 3, 2, 5); stem( n_v, y05_v); title( 'filtro mediano'); ylabel( 'y05[n]'); xlabel( 'n');
subplot( 3, 2, 6); stem( n_v, y06_v); title( 'acumulador'); ylabel( 'y06[n]'); xlabel( 'n');
% --- END mostrar resultados --- %


%% respuesta a un sistema LTI a partir de calculo directo y convolucion: T{x[n]}= 3x[n] - 2x[n-1] + x[n-2]
close all; clear all;

% --- senal de entrada --- %
n_v= 0: 4;
x_v= [ 1 2 1.5 1 0.5];  % senal de entrada: x[n]= { ->1<-, 2, 1.5, 1, 0.5}
% --- END senal de entrada --- %


y01_v= 3* x_v- 2*[ 0 x_v( 1: end- 1)]+ [ 0 0 x_v( 1: end- 2)];    % calculo directo de la respuesta al sistema


% --- calculo por convolucion --- %
h_v= [ 3 -2 1 0 0]; % respuesta al impulso
y02_v= conv( x_v, h_v, 'full');
n_size= size( n_v, 2);
y02_v= y02_v( 1: n_size);   % truncar resultado para obtener un vector del mismo tamano comparable con el resultado calculado directamente (propositos demostrativos)
% --- END calculo por convolucion --- %


% --- mostrar resultados --- %
fig_x= figure;
stem( n_v, x_v); title( 'señal de entrada'); ylabel( 'x[n]'); xlabel( 'n');
fig_y= figure;
subplot( 3, 1, 1); stem( n_v, y01_v); title( 'respuesta calculada directamente'); ylabel( 'y01[n]'); xlabel( 'n');
subplot( 3, 1, 2); stem( n_v, h_v, 'r'); title( 'respuesta al impulso'); ylabel( 'h[n]'); xlabel( 'n');
subplot( 3, 1, 3); stem( n_v, y02_v); title( 'respuesta calculada por convolucion'); ylabel( 'y02[n]'); xlabel( 'n');
% --- END mostrar resultados --- %