%% iee239: script 15 - Umbralizacion global a partir del metodo de Otsu
% El script muestra un pequeno ejemplo de umbralizacion a partir del metodo
% de Otsu. Se utiliza la funcion 'graythresh' para obtener el umbral que
% maximiza la varianza entre clases y calcula la metrica de separabilidad
% \eta a partir de la relacion varianza interclases vs. varianza global.

close all; clear all;


% --- imagen de entrada e histograma --- %
f01= uint8( [ 0 0 1 4 4 5; 0 1 3 4 3 4; 1 3 4 2 1 3; 4 4 3 1 0 0; 5 4 2 1 0 0; 5 5 4 3 1 0]);   % imagen de entrada (L= 8)
int_v= 0: 7;
f01_size= size( f01);
f01_hist= hist( f01( :), int_v)/( f01_size( 1)* f01_size( 2)); % histograma de la imagen
% --- END imagen de entrada e histograma --- %




% --- calculo de umbral --- %
[ t_otsu, eta]= graythresh( f01);   % umbral a partir del metodo de Otsu | calculo de \eta
t_otsu= t_otsu* ( 2^( 8)- 1);
g01= f01> t_otsu;
% --- END calculo de umbral --- %




% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
subplot( 1, 2, 1); imagesc( f01); title( 'imagen original'); axis image;
subplot( 1, 2, 2); imagesc( g01); title( 'imagen umbralizada'); axis image;
colormap gray;
fig02= figure;
figure( fig02);
stem( int_v, f01_hist); xlabel( 'k'); ylabel( 'p(k)'); title( 'histograma normalizado'); hold on;
stem( t_otsu, f01_hist( int_v== t_otsu), 'markerfacecolor', 'red', 'color', 'red' );
% --- END descripcion grafica --- %

%% iee239: script 15 - Metodo de umbralizacion Split and Merge
% el script utiliza la funcion splitmerge [1] para segmentar una imagen en
% escala de grises. El predicado utilizado se basa en el c???lculo de la
% media y la desviaci???n estandar de cada cuadrante.
%
% [1]: Rafael C. Gonzalez, Richard E. Woods, and Steven L. Eddins. 2003.
% Digital Image Processing Using MATLAB. Prentice-Hall, Inc.

close all; clear all;


f01= double( imread( './cygnus.tif'));    % imagen de entrada
g01= splitmerge( f01, 16, @predicate);  % imagen resultante




% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
subplot( 1, 2, 1); imagesc( f01); title( 'imagen de entrada'); axis image;
subplot( 1, 2, 2); imagesc( g01); title( 'imagen umbralizada'); axis image;
colormap gray;
% --- END descripcion grafica --- %

%% iee239: script 15 - umbralizacion de imagenes RGB
% El script muestra el metodo de umbralizacion de imagenes a color basado
% en distancia euclidiana. Se define como argumentos de entrada el color en
% espacio RGB de interes y la diferencia minima de distancia.

close all; clear all;


% --- argumentos de entrada --- %
f01= double( imread( 'coloredChips.png'));
f01_r= f01( :, :, 1);   % capa roja
f01_g= f01( :, :, 2);   % capa verde
f01_b= f01( :, :, 3);   % capa azul

v= [ 11 161 97]; % valor RGB de interes
thresh= 110;    % distancia minima
% --- END argumentos de entrada --- %




% --- umbralizacion --- %
eucl_mat= sqrt( ( f01_r- v( 1)).^ 2+ ( f01_g- v( 2)).^ 2+ ( f01_b- v( 3)).^ 2);
mask_mat= eucl_mat< thresh; 
% --- END umbralizacion --- %



% --- imagen resultante --- %
g01= f01;
g01( :, :, 1)= g01( :, :, 1).* mask_mat;
g01( :, :, 2)= g01( :, :, 2).* mask_mat;
g01( :, :, 3)= g01( :, :, 3).* mask_mat;
% --- END imagen resultante --- %



% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
subplot( 1, 2, 1); imagesc( uint8( f01)); title( 'imagen de entrada'); axis image;
subplot( 1, 2, 2); imagesc( uint8( g01)); title( 'imagen umbralizada'); axis image;
% --- END descripcion grafica --- %