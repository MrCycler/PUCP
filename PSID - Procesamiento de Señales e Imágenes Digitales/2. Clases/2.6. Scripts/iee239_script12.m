% IEE239: script 12 - Mejora en el dominio de frecuencia.
% Descripcion: el script determina el espectro de magnitud y fase de una
% imagen discreta. Luego, compara el espectro de magnitud entre una imagen
% y su version rotada. Se usa la funci??n 'imrotate' para realizar el cambio
% de orientacion y se especifica el tipo de interpolacion bilineal para su
% remuestreo. Se presenta adem??s el centrado en frecuencia a partir de la
% funcion 'fftshift' y a partir de un producto por exponenciales complejas
% en el espacio de muestras.


close all; clear all;

% --- imagen de interes --- %
f01= double( imread( 'cameraman.tif')); % imagen original
f01_size= size( f01);
f02= imrotate( f01, 45, 'bilinear');    % imagen rotada 45 grados (antihorario)
% --- END imagen de interes --- %



% --- analisis en frecuencia --- %
F01= ( fft2( f01)); % DFT 2D con centrado usando FFTSHIFT
F02= fftshift( fft2( f01));
% --- END analisis en frecuencia --- %



% --- centrado de frecuencia usando propiedades de la DFT --- %
x_v= 1: size( f01, 1);  % espacio de muestras
y_v= 1: size( f01, 2);
[ y_mesh, x_mesh]= meshgrid( y_v, x_v); % pares ordenados en espacio de muestras

f03= f01.* ( -1).^( y_mesh+ x_mesh);    % desplazamiento en frecuencia
F03=  fft2( f03);   % DFT 2D con centrado usando producto en espacio de muestras
% --- END centrado de frecuencia usando propiedades de la DFT --- %



% --- coordenadas en frecuencia --- %
u_v= 2*pi* ( 0: ( f01_size( 1)- 1))/ f01_size( 1);
u_v= fftshift( u_v);
u_v= unwrap( u_v - 2*pi);
v_v= 2*pi* ( 0: ( f01_size( 2)- 1))/ f01_size( 2);
v_v= fftshift( v_v);
v_v= unwrap( v_v - 2*pi);
% --- END coordenadas en frecuencia --- %



% --- descripcion grafica --- 5
fig01= figure;
figure( fig01);
subplot( 3, 2, 1); imagesc( f01); colormap gray; axis image;
title( 'imagen original');
subplot( 3, 2, 3); imagesc( u_v, v_v, log10( abs( F01))); axis image;
title( 'espectro de magnitud de imagen original (escala logaritmica)');
subplot( 3, 2, 5); imagesc( u_v, v_v, angle( F01)); axis image;
title( 'espectro de fase de imagen original');
subplot( 3, 2, 2); imagesc( f02); colormap gray; axis image;
title( 'imagen rotada');
subplot( 3, 2, 4); imagesc( u_v, v_v, log10( abs( F02))); axis image;
title( 'espectro de magnitud de imagen rotada (escala logaritmica)');
subplot( 3, 2, 6); imagesc( u_v, v_v, angle( F02)); axis image;
title( 'espectro de fase de imagen rotada');
% --- END descripcion grafica --- %

%%
% IEE239: script 12 - Mejora en el dominio de frecuencia.
% Descripcion: el script obtiene la representacion en frecuencia de un
% filtro pasabajos 2D discreto con frecuencia de corte $\omega_{c}=
% \frac{\pi}{2}$ a partir de su representacion en espacio de muestras. Se
% describe graficamente las senales en muestras y frecuencia a partir de la
% transformada discreta de Fourier 2D.


close all; clear all;


% --- espacio de muestras --- %
x_v = -64: 64;
y_v = -64: 64;
[ y_mesh, x_mesh]= meshgrid( y_v, x_v);
% --- END espacio de muestras --- %



% --- filtro pasabajos en espacio de muestras --- %
f01= 0.5* sinc( 0.125* x_mesh)* 0.5.* sinc( 0.125* y_mesh);
f01_size= size( f01);
% --- END filtro pasabajos en espacio de muestras --- %



% --- respuesta en frecuencia del filtro pasabajos --- %
F01= fftshift( fft2( f01));
u_v= 2*pi* ( 0: ( f01_size( 1)- 1))/ f01_size( 1);
u_v= fftshift( u_v);
u_v= unwrap( u_v - 2*pi);
v_v= 2*pi* ( 0: ( f01_size( 2)- 1))/ f01_size( 2);
v_v= fftshift( v_v);
v_v= unwrap( v_v - 2*pi);
[ v_mesh, u_mesh]= meshgrid( v_v, u_v);
% --- END respuesta en frecuencia del filtro pasabajos --- %



% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
subplot( 2, 1, 1); imagesc( x_v, y_v, f01);
title( 'filtro pasabajos en espacio de muestras');
subplot( 2, 1, 2); surf( x_mesh, y_mesh, f01);
title( 'filtro pasabajos en espacio de muestras');

fig02= figure;
figure( fig02);
subplot( 2, 1, 1); imagesc( v_v, u_v, abs( F01));
title( 'filtro pasabajos en frecuencia');
subplot( 2, 1, 2); surf( v_mesh, u_mesh, abs( F01))
title( 'filtro pasabajos en frecuencia');
% --- END descripcion grafica --- %