% IEE239: script 12b - Mejora en el dominio de frecuencia.
% Descripcion: el script determina la funcion de transferencia de dos
% mascaras conocidas: filtro gaussiano y mascara de Laplaciano. Luego, se
% analiza el espectro de magnitud de cada uno para identificar el tipo de
% funcion de transferencia que representan. Se usan la rutina meshgrid()
% para generar las variables de dominio, se elige un valor arbitrario de
% muestras en frecuencia frecuencia (M, N) y finalmente se obtiene el
% espectro de frecuencia centrado y su respectivo dominio en frecuencia
% dentro del rango fundamental usando las rutinas fft2(), fftshift() y
% unwrap().

close all; clear all;

% --- dominio en frecuencia --- %
M= 128;
N= 128;
u= 0: M- 1; 
v= 0: N-1;
[ v_mesh, u_mesh]= meshgrid( v, u); % pares ordenados del dominio en frecuencia: (u,v)
% --- END dominio en frecuencia --- %

% --- Funciones de transferencia --- %
F_v= 1/16* ( 4+ 4* cos( 2* pi* u_mesh/ M)+ 4* cos( 2* pi* v_mesh/ N)+ 2* cos( 2* pi*( u_mesh/ M+ v_mesh/ N))+ 2* cos( 2* pi*( u_mesh/ M- v_mesh/ N)));  % Gaussiano
G_v= -4+ 2* cos( 2* pi* u_mesh/ M)+ 2* cos( 2* pi* v_mesh/ N);  % Laplaciano
% --- END Funciones de transferencia --- %

% --- descripcion grafica --- %
fig01= figure;
surf( v_mesh, u_mesh, fftshift( abs( F_v)));    % surface
title( 'Espectro de magnitud de la funcion de transferencia del kernel Gaussiano');

fig02= figure;
surf( v_mesh, u_mesh, fftshift( abs( G_v)));
title( 'Espectro de magnitud de la funcion de transferencia del kernel Laplaciano');
% --- END descripcion grafica --- %