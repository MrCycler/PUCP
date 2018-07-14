% IEE239: script 13 - Mejora en el dominio de frecuencia II.
% Descripcion: el script implementa tres tipos de filtros pasabajos:
% gaussiano, ideal y butterworth. Se obtienen sus expresiones en frecuencia
% y a partir de ellas se obtiene su expresion en espacio de muestras usando
% la idft. Adicionalmente, se filtra una imagen de entrada con cada uno de
% ellos y se describe graficamente los resultados.

close all; clear all;


% --- imagen de entrada --- %
i01= double( imread( 'saturn.png'));
i01= i01( :, :, 1); % solo capa roja
i01_size= size( i01);   % dimensiones de i01
% --- END imagen de entrada --- %




% --- dominio en frecuencia --- %
M= i01_size( 1);
N= i01_size( 2);

u_v= 2* pi* ( 0: M- 1)/ M;
u_v= fftshift( u_v);
u_v= unwrap( u_v - 2*pi);
v_v= 2* pi* ( 0: N- 1)/ N;
v_v= fftshift( v_v);
v_v= unwrap( v_v - 2*pi);

[ v_mesh, u_mesh]= meshgrid( v_v, u_v); % coordenadas bidimensionales en frecuencia
% --- END dominio en frecuencia --- %




% --- dominio en muestras --- %
x_v= -1* floor( M/ 2): floor( M/ 2);
y_v= -1* floor( N/ 2): floor( N/ 2);

[ y_mesh, x_mesh]= meshgrid( y_v, x_v); % coordenadas bidimensionales en espacio de muestras
% --- END dominio en muestras --- %




% --- filtro pasabajos dist. gaussiana --- %
sigma= pi/ 16;  % desviacion estandar

H01_mat= 1/( 2* pi* sigma^( 2))* exp( -0.5*( u_mesh.^( 2)+ v_mesh.^( 2))/ sigma^( 2));
h01_mat= fftshift( ifft2( ifftshift( H01_mat)));    % fftshift adicional: centrar origen en espacio de muestras
% --- END filtro pasabajos dist. gaussiana --- %




% --- filtro pasabajos ideal --- %
D= pi/ 16;  % frecuencia de corte

H02_mat= zeros( M, N);
H02_mat( sqrt( u_mesh.^( 2)+ v_mesh.^( 2))< D)= 1;
h02_mat= fftshift( ifft2( ifftshift( H02_mat)));
% --- END filtro pasabajos ideal --- %




% --- filtro pasabajos butterworth --- %
D= pi/ 16;  % frecuencia de corte
n= 8;  % orden

H03_mat= 1./ ( 1+ ( sqrt( u_mesh.^( 2)+ v_mesh.^( 2))/ D).^ ( 2* n));
h03_mat= fftshift( ifft2( ifftshift( H03_mat)));
% --- END filtro pasabajos butterworth --- %




% --- producto en frecuencia --- %
I01= fftshift( fft2( i01)); % dft de imagen de entrada
G01= I01.* H01_mat;     % producto en frecuencia (modificar para evitar 'wrap-around error')
G02= I01.* H02_mat;
G03= I01.* H03_mat;

g01= ifft2( ifftshift( G01));   % transformada inversa
g02= ifft2( ifftshift( G02));
g03= ifft2( ifftshift( G03));
% --- END producto en frecuencia --- %




% --- descripcion grafica --- %
fig01= figure;
subplot( 1, 2, 1); imagesc( y_v, x_v, real( h01_mat));
title( 'filtro pasabajos gaussiano en muestras'); axis image; colorbar;
subplot( 1, 2, 2); imagesc( u_v, v_v, abs( H01_mat));
xlabel( 'rad'); title( 'filtro pasabajos gaussiano en frecuencia'); axis image; colorbar;

fig02= figure;
subplot( 1, 2, 1); imagesc( y_v, x_v, real( h02_mat));
title( 'filtro pasabajos ideal en muestras'); axis image; colorbar;
subplot( 1, 2, 2); imagesc( u_v, v_v, abs( H02_mat));
xlabel( 'rad'); title( 'filtro pasabajos ideal en frecuencia'); axis image; colorbar;

fig03= figure;
subplot( 1, 2, 1); imagesc( y_v, x_v, real( h03_mat));
title( 'filtro butterworth pasabajos en muestras'); axis image; colorbar;
subplot( 1, 2, 2); imagesc( u_v, v_v, abs( H03_mat));
xlabel( 'rad'); title( 'filtro butterworth pasabajos en frecuencia'); axis image; colorbar;

fig04= figure;
subplot( 1, 3, 1); imagesc( real( g01));
title( 'filtrado con LPF gaussiano'); axis image; colormap gray;
subplot( 1, 3, 2); imagesc( real( g02));
title( 'filtrado con LPF ideal'); axis image; colormap gray;
subplot( 1, 3, 3); imagesc( real( g03));
title( 'filtrado con LPF butterworth'); axis image; colormap gray;
% --- END descripcion grafica --- %


%%
% IEE239: script 13 - Mejora en el dominio de frecuencia II.
% Descripcion: el script calcula la funcion de transferencia del laplaciano
% y la mascara de laplaciano en espacio. Luego, se filtra una imagen de
% entrada para resaltar sus bordes (image sharpening) y se demuestra que
% ambas operaciones son equivalentes.

close all; clear all;


% --- imagen de entrada --- %
i01= double( imread( './blurry_moon.tif')); % imagen de entrada
i01= i01( :, :, 1); % capa roja
i01_size= size( i01);
i01= ( i01- min( i01( :)))./ ( max( i01( :))- min( i01( :)));   % intensidad normalizada
% --- END imagen de entrada --- %




% --- dominio en frecuencia --- %
M= i01_size( 1);    % dimensiones de la imagen
N= i01_size( 2);

u_v= 2* pi* ( 0: M- 1)/ M;  % muestras en el dominio de frecuencia para filas
u_v= fftshift( u_v);
u_v= unwrap( u_v - 2*pi);
v_v= 2* pi* ( 0: N- 1)/ N;  % muestras en el dominio de frecuencia para columnas
v_v= fftshift( v_v);
v_v= unwrap( v_v - 2*pi);
[ v_mesh, u_mesh]= meshgrid( v_v, u_v); % dominio en frecuencia
% --- END dominio en frecuencia --- %




% --- laplaciano a partir de producto en frecuencia --- %
c= -1;

I01= fftshift( fft2( i01)); % DFT de imagen de entrada
H01= -1* ( u_mesh.^( 2)+ v_mesh.^( 2)); % laplaciano en frecuencia
G01= H01.* I01; % laplaciano de la imagen (en frecuencia) (modificar para evitar 'wrap-around error')

g01= real( ifft2( ifftshift( G01)));    % resultado en espacio de muestras (transformada inversa)
g01= (g01- min( g01( :)))/ ( max( g01( :))- min( g01( :))); % laplaciano de la imagen normlizada
y01= i01+ c* g01;   % image sharpening usando laplaciano
% --- END laplaciano a partir de producto en frecuencia --- %




% --- laplaciano a partir de convolucion en muestras --- %
h02= [ 0 1 0; 1 -4 1; 0 1 0];   % mascara de laplaciano
g02= conv2( i01, h02, 'same');
g02= ( g02- min( g02( :)))/ ( max( g02( :))- min( g02( :)));
y02= i01+ c* g02;
% --- END laplaciano a partir de convolucion en muestras --- %




% --- descripcion grafica --- %
fig01= figure;
imagesc( u_v, v_v, abs( H01)); title( 'Funcion de transferencia de laplaciano');

fig02= figure;
subplot( 1, 3, 1); imagesc( i01);
title( 'imagen de entrada');
subplot( 1, 3, 2); imagesc( g01);
title( 'laplaciano (producto)');
subplot( 1, 3, 3); imagesc( y01);
title( 'image sharpening (producto)'); colormap gray;

fig03= figure;
subplot( 1, 3, 1); imagesc( i01);
title( 'imagen de entrada');
subplot( 1, 3, 2); imagesc( g02);
title( 'laplaciano (convolucion)');
subplot( 1, 3, 3); imagesc( y02);
title( 'image sharpening (convolucion)'); colormap gray;
% --- END descripcion grafica --- %


%%
% IEE239: script 13 - Mejora en el dominio de frecuencia II.
% Descripcion: el script implementa el metodo de highboost filtering a
% partir de operaciones en frecuencia. Se incluye una ganancia tanto para
% bajas como altas frecuencias.

close all; clear all;


% --- imagen de entrada --- %
i01= double( imread( './blurry_moon.tif'));
i01= i01( :, :, 1);
i01_size= size( i01);
% --- END imagen de entrada --- %




% --- dominio en frecuencia --- %
M= i01_size( 1);
N= i01_size( 2);
u_v= 2* pi* ( 0: M- 1)/ M;
u_v= fftshift( u_v);
u_v= unwrap( u_v - 2*pi);
v_v= 2* pi* ( 0: N- 1)/ N;
v_v= fftshift( v_v);
v_v= unwrap( v_v - 2*pi);
[ v_mesh, u_mesh]= meshgrid( v_v, u_v);
% --- END dominio en frecuencia --- %




% --- filtro pasabajos butterworth --- %
D= pi/ 1.5;
n= 3;
H01_mat= 1./ ( 1+ ( sqrt( u_mesh.^( 2)+ v_mesh.^( 2))/ D).^ ( 2* n));
% --- END filtro pasabajos butterworth --- %




% --- image enhancement --- %
k1= 1;  % ganancia para bajas frecuencias
k2= 5;  % ganancia para altas frecuencias

I01= fftshift( fft2( i01)); % DFT de imagen de entrada
H02_mat= ( k1+ k2* ( 1- H01_mat));  % highboost filtering en frecuencia
h02_mat= fftshift( ifft2( ifftshift( H02_mat)));    % mascara de highboost filtering
G01= I01.* H02_mat; % producto en frecuencia (modificar para evitar 'wrap-around error')
g01= real( ifft2( ifftshift( G01)));    % transformada inversa
% --- END image enhancement --- %




% --- descripcion grafica --- %
fig01= figure;
subplot( 1, 2, 1); imagesc( i01);
title( 'imagen de entrada');
subplot( 1, 2, 2); imagesc( g01);
title( 'imagen resultado'); colormap gray;

fig02= figure;
surf( u_mesh, v_mesh, abs( H02_mat));
title( 'funcion de transferencia');
% --- END descripcion grafica --- %


%%
% IEE239: script 13 - Segmentacion de imagenes.
% Descripcion: el script halla los bordes de una imagen de entrada usando
% diferentes mascaras de diferencias finitas. Adicionalmente, se utiliza el
% metodo de umbralizacion de gradiente para rechazar bordes debiles.

close all; clear all;


% --- imagen de entrada --- %
i01= double( imread( './building.tif'));
i01_size= size( i01);
% --- END imagen de entrada --- %




% --- coordenadas en muestras --- %
x_v= 1: i01_size( 1);
y_v= 1: i01_size( 2);
[ y_mesh, x_mesh]= meshgrid( y_v, x_v);
% --- END coordenadas en muestras --- %




% --- amplitud y fase de gradiente --- %
dx= [ 1; -1];
dy= [ 1 -1];

i01x= conv2( i01, dx, 'full');
i01x= i01x( 2: end, :); % resultado de convolucion valido
i01y= conv2( i01, dy, 'full');
i01y= i01y( :, 2: end); % resultado de convolucion valido

grad_amp= sqrt( i01x.^ 2+ i01y.^ 2);
grad_phase= atan2( i01y, i01x);

grad_amp_thres= grad_amp> 0.15* max( grad_amp( :));
% --- END amplitud y fase de gradiente --- %




% --- gradientes diagonales --- %
g01= conv2( i01, [ 1 0; 0 -1], 'same');	% mascara Roberts
g02= conv2( i01, [ 0 1; -1 0], 'same');

h01= conv2( i01, [ 0 -1 -1; 1 0 -1; 1 1 0], 'same');    % mascara Prewitt
h02= conv2( i01, [ 1 1 0; 1 0 -1; 0 -1 -1], 'same');
% --- END gradientes diagonales --- %




% --- descripcion grafica --- %
fig01= figure;
imagesc( grad_amp_thres);
title( 'umbralizacion de magnitud de gradiente');
axis image; colorbar;

fig02= figure;
subplot( 2, 1, 1); imagesc( abs( g01));
title( 'gradiente diagonal roberts 45 grados'); axis image; colorbar;
subplot( 2, 1, 2); imagesc( abs( g02)); 
title( 'gradiente diagonal roberts -45 grados'); axis image; colorbar;

fig03= figure;
subplot( 2, 1, 1); imagesc( abs( h01));
title( 'gradiente diagonal prewitt -45 grados'); axis image; colorbar;
subplot( 2, 1, 2); imagesc( abs( h02)); 
title( 'gradiente diagonal prewitt 45 grados'); axis image; colorbar;
% --- END descripcion grafica --- %