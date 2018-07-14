% IEE239: script 11 - Mejora en el dominio espacial.
% Descripcion: el script muestra el procedimiento para realizar una
% transformacion gamma para imagenes de tipo uint8. 

close all; clear all;


% --- parametros de imagen inicial --- %
f01= imread( 'office_3.jpg');   % imagen de tipo 8-bit unsigned integer
f01_r= f01( :, :, 1);   %  capa roja

i_min= 0;
i_max= 2^( 8)- 1;
% --- END parametros de imagen inicial --- %



% --- mapeo de intensidades segun transformacion gamma --- %
gamma= 1.5;
f_v= i_min: 0.01: i_max;
c= i_max^( 1- gamma);
g_v= c* f_v.^( gamma);

fig02= figure;
figure( fig02); plot( f_v, g_v);
title( [ 'mapeo de intensidades seg??n transformaci??n gamma (\gamma = ' num2str( gamma) ')']);
ylabel( 'intensidad final'); xlabel( 'intensidad inicial');
grid on; grid minor;
% --- END mapeo de intensidades segun transformacion gamma --- %



% --- transformacion de intensidad segun transformacion gamma --- %
g01_r= uint8( c* double( f01_r).^( gamma));

fig03= figure;
figure( fig03);
subplot( 2, 1, 1); imagesc( f01_r);
title( 'imagen inicial'); xlabel( 'columnas'); ylabel( 'filas');
colormap gray; axis image;
subplot( 2, 1, 2); imagesc( g01_r);
title( 'imagen final'); xlabel( 'columnas'); ylabel( 'filas');
colormap gray; axis image;
% --- END transformacion de intensidad segun transformacion gamma --- %
%%
% IEE239: script 11 - Mejora en el dominio espacial.
% Descripcion: el script muestra la transformacion de intensidad por partes
% de una imagen con intensidades entre {0; 15}.

close all; clear all;


% --- parametros de imagen inicial --- %
f01= double( imread( 'office_3.jpg'));
f01_r= f01( :, :, 1);

i_min= 0;
i_max= 2^( 8)- 1;
f02_r= uint8( ( f01_r- i_min)/ ( i_max- i_min)* 15);    % cambio de rango a [ 0 15]
% --- END parametros de imagen inicial --- %



% --- mapeo de intensidades segun transformacion por partes --- %
f_v= 0: 0.01: 15;
h_v= 5/ 3* f_v;
i_v= 7/ 6* f_v+ 3/ 2;   
j_v= 1/ 2* f_v+ 15/ 2;

g_v= zeros( size( f_v));
g_v( f_v>= 0 & f_v< 3)= h_v( f_v>= 0 & f_v< 3);
g_v( f_v>= 3 & f_v< 9)= i_v( f_v>= 3 & f_v< 9);
g_v( f_v>= 9 & f_v<= 15)= j_v( f_v>= 9 & f_v<= 15);

fig02= figure;
figure( fig02); plot( f_v, g_v);
title( [ 'mapeo de intensidades segun transformacion lineal por partes']);
ylabel( 'intensidad final'); xlabel( 'intensidad inicial');
grid on; grid minor;
% --- END mapeo de intensidades segun transformacion por partes --- %



% --- transformacion de intensidad  --- %
h01_r= 5/ 3* f02_r;
i01_r= 7/ 6* f02_r+ 3/ 2;
j01_r= 1/ 2* f02_r+ 15/ 2;

g02_r= zeros( size( f02_r));
g02_r( f02_r>= 0 & f02_r< 3)= h01_r( f02_r>= 0 & f02_r< 3);
g02_r( f02_r>= 3 & f02_r< 9)= i01_r( f02_r>= 3 & f02_r< 9);
g02_r( f02_r>= 9 & f02_r<= 15)= j01_r( f02_r>= 9 & f02_r<= 15);

fig03= figure;
figure( fig03);
subplot( 2, 1, 1); imagesc( f02_r);
title( 'imagen inicial'); xlabel( 'columnas'); ylabel( 'filas');
colormap gray; axis image;
subplot( 2, 1, 2); imagesc( g02_r);
title( 'imagen final'); xlabel( 'columnas'); ylabel( 'filas');
colormap gray; axis image;
% --- transformacion de intensidad --- %
%%
% IEE239: script 11 - Mejora en el dominio espacial.
% Descripcion: el script muestra el calculo del histograma de una imagen
% uint8. Luego, se obtiene una transformacion de intensidad no lineal
% basada en la ecualizacion del histograma y se describe graficamente la
% imagen resultante y su respectivo histograma.

close all; clear all;


% --- parametros de imagen inicial --- %
f01= imread( 'office_3.jpg');
f01_r= f01( :, :, 1);

i_min= 0;
i_max= 2^( 8)- 1;
% --- END parametros de imagen inicial --- %



% --- calculo de histograma de imagen inicial --- %
f_v= i_min: i_max;
f01_hist_v= zeros( length( f_v), 1);

for i= 1: length( f_v)
            f01_hist_v( i)= sum( f01_r( :)== f_v( i));
end

fig01= figure;
figure( fig01);
subplot( 2, 1, 1); imagesc( f01_r); title( 'imagen inicial'); colormap gray;
subplot( 2, 1, 2); stem( f_v, f01_hist_v); title( 'histograma de imagen inicial');
% --- END calculo de histograma de imagen inicial --- %



[ g01_r, eqmap_v]= histeq( f01_r);    % g01_r: imagen final con histograma equalizado
eqmap_v= uint8( eqmap_v* i_max);    % eqmap: transformacion (no lineal) basada en equalizacion de histograma



% --- calculo de histograma de imagen final --- %
g01_hist_v= zeros( length( f_v), 1);

for i= 1: length( f_v)
            g01_hist_v( i)= sum( g01_r( :)== f_v( i));
end
% --- END calculo de histograma de imagen final --- %



% --- descripcion grafica --- %
fig02= figure;
figure( fig02);
plot( eqmap_v); title( 'transformacion no lineal basada en eq. de histograma');
ylabel( 'intensidad final'); xlabel( 'intensidad inicial');


fig03= figure;
figure( fig03);
subplot( 2, 1, 1); imagesc( g01_r); title( 'imagen final'); colormap gray;
subplot( 2, 1, 2); stem( f_v, g01_hist_v); title( 'histograma de imagen final');
% --- END descripcion grafica --- %
%%
% IEE239: script 11 - Mejora en el dominio espacial.
% Descripcion: el script muestra el uso de sistemas lineales y no lineales
% para tratar dos casos clasicos de eliminacion de ruido: ruido aditivo y
% ruido impulsivo. Se usa un filtro promedio para eliminar el efecto de
% ruido aditivo con dostribucion gaussiana y un filtro mediano para
% eliminar el efecto deruido impulsivo.

clear all; close all;


% --- imagen de interes --- %
f01= double( imread( 'office_3.jpg'));
f01_r= f01( :, :, 1);
% --- END imagen de interes --- %



% --- normalizacion de imagen y creacion de imagenes ruidosas --- %
f01_norm= double( ( f01_r- min( f01_r( :)))/ ( max( f01_r( :))- min( f01_r( :))));  % imagen normalizada ($f \in \{0; 1\}$)

gauss_mean= 0;  % media de ruido aditivo con distribucion gaussiana
gauss_var= 0.1;    % varianza de ruido aditivo con distribucion gaussiana
splevel= 0.4;
f01_gaussian= imnoise( f01_norm, 'gaussian', gauss_mean, gauss_var);    % imagen con ruido aditivo gaussiano
f01_saltnpepper= imnoise( f01_norm, 'salt & pepper', splevel); % imagen con ruido impulsivo sal y pimienta
% --- END normalizacion de imagen y creacion de imagenes ruidosas --- %




% --- seleccion de kernels y filtrado --- %
h01_order= 7;   % orden del filtro promedio
h01= 1/ h01_order* ones( h01_order);    % filtro promedio
y01= conv2( f01_gaussian, h01, 'same'); % eliminacion de ruido aditivo gaussiano con media 0

medfilt_order= 5;   % orden del filtro mediano
y02= medfilt2( f01_saltnpepper, [ medfilt_order medfilt_order]);    % eliminacion del ruido impulsivo sal y pimienta
% --- END seleccion de kernels y filtrado --- %



% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
imagesc( f01_r);
title( 'imagen de interes'); axis image; colormap gray;
fig02= figure;
figure( fig02);
subplot( 2, 2, 1); imagesc( f01_gaussian);
title( 'imagen con ruido aditivo'); axis image;
subplot( 2, 2, 2); imagesc( f01_saltnpepper);
title( 'imagen con ruido impulsivo'); axis image;
subplot( 2, 2, 3); imagesc( y01);
title( 'imagen con ruido aditivo tratada con filtro promedio'); axis image;
subplot( 2, 2, 4); imagesc( y02);
title( 'imagen con ruido aditivo tratada con filtro mediano'); axis image;
colormap gray;
% --- END descripcion grafica --- %


%%
% IEE239: script 11 - Mejora en el dominio espacial.
% Descripcion: el script muestra el calculo de la magnitud y fase de la
% gradiente de los elementos de una imagen. Se usa la funcion conv() para
% hallar el resultado de filtrar una imagen por determinadas mascaras
% (kernels) de derivacion. Los kernels incluyen los operadores Sobel y
% Prewitt.


close all; clear all;



% --- imagen de entrada --- %
i01= double( imread( 'office_6.jpg'));   % imagen de tipo double
i01= i01( :, :, 1);   %  capa roja
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
i01x= i01x( 2: end, :); % resultado de convolucion valido (alternativa: revisar banderas 'same' y 'valid')
i01y= conv2( i01, dy, 'full');
i01y= i01y( :, 2: end); % resultado de convolucion valido (alternativa: revisar banderas 'same' y 'valid')

grad_amp= sqrt( i01x.^ 2+ i01y.^ 2);
grad_phase= atan2( i01y, i01x);
% --- END amplitud y fase de gradiente --- %




% --- mascaras de gradiente --- %
g01= conv2( i01, [ 1 1 1; 0 0 0; -1 -1 -1], 'same');	% mascara Prewitt
g02= conv2( i01, [ 1 0 -1; 1 0 -1; 1 0 -1], 'same');

h01= conv2( i01, [ 1 2 1; 0 0 0; -1 -2 -1], 'same');    % mascara Sobel
h02= conv2( i01, [ 1 0 -1; 2 0 -2; 1 0 -1], 'same');
% --- END mascaras de gradiente --- %




% --- descripcion grafica --- %
fig01= figure;
subplot( 1, 2, 1); imagesc( log10(grad_amp));   % amplitud con transformaci??n logaritmica (resaltar bajas intensidades)
title( 'magnitud de gradiente'); axis image;
subplot( 1, 2, 2); imagesc( grad_phase);
title( 'fase de gradiente'); axis image; colormap gray;

fig02= figure;
subplot( 1, 2, 1); imagesc( g01);
title( 'mascara Prewitt en direccion x'); axis image;
subplot( 1, 2, 2); imagesc( g02); 
title( 'mascara Prewitt en direccion y'); axis image; colormap gray;

fig03= figure;
subplot( 1, 2, 1); imagesc( h01);
title( 'mascara Sobel en direccion x'); axis image;
subplot( 1, 2, 2); imagesc( h02); 
title( 'mascara Sobel en direccion y'); axis image; colormap gray;
% --- END descripcion grafica --- %