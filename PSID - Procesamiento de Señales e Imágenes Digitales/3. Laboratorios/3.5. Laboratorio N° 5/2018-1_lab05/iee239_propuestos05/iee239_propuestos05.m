close all; clear all;

%% Pregunta 1

% a.
% --- leer imagen de entrada y separar por capas --- %
i01_mat= double( imread( './mush.jpg')); % imagen original
i01_size= size( i01_mat);   % dimensiones de la imagen
i01_r_mat= i01_mat( :, :, 1);   % capa roja
i01_g_mat= i01_mat( :, :, 2);   % capa verde
i01_b_mat= i01_mat( :, :, 3);   % capa azul

% -- crear histogramas para las 3 capas --- %
idx_v= 0: 255;  % bins a evaluar
h01_r_v= hist( i01_r_mat( :), idx_v);   % histograma en capa roja
h01_g_v= hist( i01_g_mat( :), idx_v);   % histograma en capa verde
h01_b_v= hist( i01_b_mat( :), idx_v);   % histograma en capa azul

fig01= figure;  %  descripcion grafica
subplot( 3, 1, 1); bar( idx_v, h01_r_v, 'r');   % histograma en capa roja
title( 'Histograma de capa roja');
subplot( 3, 1, 2); bar( idx_v, h01_g_v, 'g');   % histograma en capa verde
title( 'Histograma de capa verde');
subplot( 3, 1, 3); bar( idx_v, h01_b_v, 'b');   % histograma en capa azul
title( 'Histograma de capa azul');

% b.
% --- seleccion manual de valor umbral --- %
T= 50; % ad-hoc
th_mat= i01_g_mat>= T;  % umbralizacion de intensidad

fig02= figure; % descripcion grafica
imagesc( th_mat); colormap gray; axis image;
title( 'Capa verde umbralizada de forma manual');

% c.
% --- umbralizacion bimodal automatica--- %
t_0= round( 255* rand( 1)); % umbral inicial aleatorio
tol= 1; % factor de tolerancia
iter_max= 128;  % numero maximo de iteraciones
[i01_th, t01]= func_bihist(i01_g_mat, t_0, tol, iter_max);  % metodo de umbralizacion automatica de histogramas bimodales

% --- descripcion grafica -- %
fig04= figure;
subplot( 1, 2, 1); imagesc( i01_th);
title( 'Capa verde umbralizada de forma automatica');
axis image; colormap gray;

% d.
% --- agregar cambio de iluminacion lineal --- %
slope= 128; % pendiente para cambio de intensidad
[ mesh_y, mesh_x]= meshgrid( 0: i01_size( 2)-1, 0: i01_size( 1)- 1);    % pares ordenados para la imagen (x,y)
grad_mat= round( slope* mesh_y/ ( i01_size( 2)- 1));    % cambio lineal de intensidad
i02_g_mat= i01_g_mat+ grad_mat;   % observacion

i02_g_mat( i02_g_mat< 0)= 0;        % asumir resolucion de 8 bits
i02_g_mat( i02_g_mat> 255)= 255;
h02_v= hist( i02_g_mat( :), idx_v);   % histograma de observacion

% --- descripcion grafica --- %
fig03= figure;
subplot( 2, 2, 1); imagesc( i01_g_mat); title( 'capa verde'); axis image; % capa verde (axis image: preservar proporcion)
subplot( 2, 2, 2); imagesc( grad_mat); title( 'gradiente'); axis image; % cambio lineal de intensidad
subplot( 2, 2, 3); imagesc( i02_g_mat); title( 'observacion');  axis image; colormap gray;  % observacion, paleta de colores gris
subplot( 2, 2, 4); bar( idx_v, h02_v, 'g'); title( 'histograma de observacion'); ylim([ min( h01_g_v) 4000]);  % histograma de observacion (ylim: restringir rango en grafica)

% --- umbralizacion bimodal automatica--- %
t_0= round( 255* rand( 1)); % umbral inicial aleatorio
tol= 1; % factor de tolerancia
iter_max= 128;  % numero maximo de iteraciones
[i01_th, t01]= func_bihist(i01_g_mat, t_0, tol, iter_max);  % metodo de umbralizacion automatica de histogramas bimodales
[i02_th, t02]= func_bihist(i02_g_mat, t_0, tol, iter_max);

% --- descripcion grafica --- %
fig04= figure;
subplot( 1, 2, 1); imagesc( i01_th);
axis image;
subplot( 1, 2, 2); imagesc( i02_th);
axis image; colormap gray;

% e.
% --- separar en secciones --- %
s01_mat= i02_g_mat( 1: i01_size( 1)/ 2, 1: i01_size( 2)/ 2);    % primer cuadrante
s02_mat= i02_g_mat( 1: i01_size( 1)/ 2, i01_size( 2)/ 2+ 1: end);   % segundo cuadrante
s03_mat= i02_g_mat( i01_size( 1)/ 2+ 1: end, 1: i01_size( 2)/ 2);   % tercer cuadrante
s04_mat= i02_g_mat( i01_size( 1)/ 2+ 1: end, i01_size( 2)/ 2+ 1: end);  % cuarto cuadrante

% --- histogramas de cada seccion --- %
h_s01_v= hist( s01_mat( :), idx_v); % histograma del primer cuadrante de la observacion
h_s02_v= hist( s02_mat( :), idx_v); % histograma del segundo cuadrante de la observacion
h_s03_v= hist( s03_mat( :), idx_v); % histograma del tercer cuadrante de la observacion
h_s04_v= hist( s04_mat( :), idx_v); % histograma del cuarto cuadrante de la observacion

fig05= figure;  % descripcion grafica
subplot( 2, 2, 1); bar( idx_v, h_s01_v); ylim([ min( h01_g_v) max( h01_g_v)]); ylim([ 0 1000]);  % histograma del primer cuadrante
title( 'histograma del primer cuadrante');
subplot( 2, 2, 2); bar( idx_v, h_s02_v, 'c'); ylim([ min( h01_g_v) max( h01_g_v)]); ylim([ 0 1000]);  % histograma del segundo cuadrante
title( 'histograma del segundo cuadrante');
subplot( 2, 2, 3); bar( idx_v, h_s03_v, 'y'); ylim([ min( h01_g_v) max( h01_g_v)]); ylim([ 0 1000]);  % histograma del tercer cuadrante
title( 'histograma del tercer cuadrante');
subplot( 2, 2, 4); bar( idx_v, h_s04_v, 'm'); ylim([ min( h01_g_v) max( h01_g_v)]); ylim([ 0 1000]);  % histograma del cuarto cuadrante
title( 'histograma del cuarto cuadrante');

% f.
% --- umbralizacion bimodal de secciones --- %
[s01_th, ts01]= func_bihist(s01_mat, t_0, tol, iter_max);
[s02_th, ts02]= func_bihist(s02_mat, t_0, tol, iter_max);
[s03_th, ts03]= func_bihist(s03_mat, t_0, tol, iter_max);
[s04_th, ts04]= func_bihist(s04_mat, t_0, tol, iter_max);
sth_mat= [ s01_th s02_th; s03_th s04_th];   % crear imagen umbralizada resultante

% --- descripcion grafica --- %
fig06= figure;
subplot( 2, 2, 1); imagesc( s01_th); axis image;
title( 'primera subregion');
subplot( 2, 2, 2); imagesc( s02_th); axis image;
title( 'segunda subregion');
subplot( 2, 2, 3); imagesc( s03_th); axis image;
title( 'tercera subregion');
subplot( 2, 2, 4); imagesc( s04_th); axis image;
title( 'cuarta subregion');
colormap gray;

fig07= figure;
subplot( 1, 2, 1); imagesc( i02_th); axis image;
title( 'Umbralizacion de la imagen completa');
subplot( 1, 2, 2); imagesc( sth_mat); colormap gray; axis image;
title( 'Umbralizacion de la imagen separada en regiones');

% g. 
% --- obtencion de la DFT 2D --- %
M= 2018;    % numero de muestras en frecuencia para dimension x (filas)
N= 1024;    % numero de muestras en frecuencia para dimension y (columnas)
I01_g_mat= fftshift( fft2( i01_g_mat, M, N));   % DFT 2D con origen en el centro de la imagen
I01_g_abs= abs( I01_g_mat); % espectro de magnitud con origen en el centro de la imagen
I01_g_angle= angle( I01_g_mat); % espectro de fase con origen en el centro de la imagen
w01_v= unwrap( fftshift( 2* pi/ M* ( 0: M- 1)- 2* pi)); % rango fundamental para u
w02_v= unwrap( fftshift( 2* pi/ N* ( 0: N- 1)- 2* pi)); % rnago fundamental para v

% --- descripcion grafica --- %
fig08= figure;
subplot(1, 2, 1); imagesc( w01_v, w02_v, log10( abs( I01_g_abs))); axis image;  % espectro de magnitud con transformacion logaritmica (asumiendo c=1)
title( 'espectro de magnitud'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');
subplot(1, 2, 2); imagesc( w01_v, w02_v, I01_g_angle); axis image; colormap gray;   % espectro de fase
title( 'espectro de fase'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');

% --- transformada de fourier 2D como transformada separable --- %
I01_g_mat02= zeros( M, N);  % reserva de memoria: tama?o de la imagen si se considera un numero de M, N muestra en frecuencia (equivalente a realizar zero-padding)
I01_g_mat02( 1: i01_size( 1), 1: i01_size( 2))= i01_g_mat;  % imagen con zero-padding para M, N muestras en frecuencia

A_mat= dftmtx( M)* I01_g_mat02; % calcular la DFT 1D en filas
B_mat= ifftshift( A_mat* transpose( dftmtx( N)));   % calcular la DFT 1D en columnas sobre la anterior y centrar espectro
B_abs= abs( B_mat); % espectro de magnitud
errval= norm( I01_g_mat( :)- B_mat( :));    % norma euclidiana entre DFT 2D y la implementacion basada en dos DFT 1D

fig13= figure; 
subplot( 1, 2, 1); imagesc( w01_v, w02_v, log10( I01_g_abs)); axis image;
title( 'espectro de magnitud en escala lograitmica a partir de DFT 2D');
xlabel( '\omega_{x}'); ylabel( '\omega_{y}');
subplot( 1, 2, 2); imagesc( w01_v, w02_v, log10( B_abs)); axis image; colormap gray;
title( 'espectro de magnitud en escala lograitmica a partir de dos DFT 1D');
xlabel( '\omega_{x}'); ylabel( '\omega_{y}');

% h.
% --- senal sinusoidal como distorsion --- %
cos_mat= 64* cos( pi/3* mesh_x+ pi/5* mesh_y);
i03_g_mat= i01_g_mat+ cos_mat;
I03_g_mat= fftshift( fft2( i03_g_mat, M, N));   % DFT 2D con origen en el centro de la imagen
I03_g_abs= abs( I03_g_mat); % espectro de magnitud con origen en el centro de la imagen
I03_g_angle= angle( I03_g_mat); % espectro de fase con origen en el centro de la imagen
w01_v= unwrap( fftshift( 2* pi/ M* ( 0: M- 1)- 2* pi)); % rango fundamental para u
w02_v= unwrap( fftshift( 2* pi/ N* ( 0: N- 1)- 2* pi)); % rnago fundamental para v

% --- descripcion grafica --- %
fig09= figure;
subplot( 1, 2, 1), imagesc( i01_g_mat); axis image;
title( 'capa verde original');
subplot( 1, 2, 2), imagesc( i03_g_mat); axis image; colormap gray;
title( 'capa verde afectada por sinusoidal');

fig10= figure;
subplot(1, 2, 1); imagesc( w01_v, w02_v, log10( abs( I03_g_abs))); axis image;  % espectro de magnitud con transformacion logaritmica (asumiendo c=1)
title( 'espectro de magnitud'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');
subplot(1, 2, 2); imagesc( w01_v, w02_v, I03_g_angle); axis image; colormap gray;   % espectro de fase
title( 'espectro de fase'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');

% i.
% --- distribucion gaussiana en espacio de muestras --- %
%  enventanado: desplazar al centro de la imagen
sigma= 16;
r_v= round( -5* sigma: 5* sigma);
c_v= round( -5* sigma: 5* sigma);
[ mesh_c, mesh_r]= meshgrid( c_v, r_v);    % pares ordenados para la imagen (x,y)

lpf_mat= 1/( 2* pi* sigma^( 2))* exp( -( mesh_r.^( 2)+ mesh_c.^( 2))/( 2* sigma^( 2)));
bpf_mat= 2* lpf_mat.* cos( pi/3* mesh_r+ pi/5* mesh_c);    % desplazamiento en frecuencia
spf_mat= -bpf_mat;
spf_mat( r_v== 0, c_v== 0)= 1- bpf_mat( r_v== 0, c_v== 0);

% --- transformada de Fourier de filtro pasa-altos --- %
M= 2018;    % numero de muestras en frecuencia para dimension x (filas)
N= 1024;    % numero de muestras en frecuencia para dimension y (columnas)
SPF_mat= fftshift( fft2( spf_mat, M, N));   % DFT 2D con origen en el centro de la imagen
SPF_abs= abs( SPF_mat); % espectro de magnitud con origen en el centro de la imagen
SPF_angle= angle( SPF_mat); % espectro de fase con origen en el centro de la imagen
w01_v= unwrap( fftshift( 2* pi/ M* ( 0: M- 1)- 2* pi)); % rango fundamental para u
w02_v= unwrap( fftshift( 2* pi/ N* ( 0: N- 1)- 2* pi)); % rnago fundamental para v

% --- descripcion grafica --- %
fig11= figure;
subplot(1, 2, 1); imagesc( w01_v, w02_v, abs( SPF_abs)); axis image;  % espectro de magnitud
title( 'espectro de magnitud'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');
subplot(1, 2, 2); imagesc( w01_v, w02_v, SPF_angle); axis image; colormap gray;   % espectro de fase
title( 'espectro de fase'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');

% --- filtrado a partir de producto en frecuencia --- %
I04_mat= I03_g_mat.* SPF_mat;
i04_mat= ifft2( ifftshift( I04_mat), M, N);
i04_mat= i04_mat( round( 5* sigma)+ 1: round( 5* sigma)+ i01_size( 1), round( 5* sigma)+ 1: round( 5* sigma)+ i01_size( 2));    % recortar para mantener el dominio original. Desplazamiento del origen debido a que el origen del kernel est? en el centro de la imagen

fig12= figure;
imagesc( i04_mat); title( 'imagen filtrada'); axis image; colormap gray;

% --- convolucion vs. producto: costo computacional --- %
sigma_v= 5: 2: 25; % valored de desv estandar a analizar
size_v= 10* sigma_v;    % tamano de kernels para cada \sigma
t01_end= zeros( size( sigma_v));	% inicio de cuenta
t02_end= zeros( size( sigma_v));    % fin de cuenta

for i= 1: length( sigma_v)
            f_mat= fspecial( 'log', size_v( i), sigma_v( i));   % mascara de laplaciano de gaussiano
            f_size= size( f_mat);
            M02= i01_size( 1)+ f_size( 1)- 1;
            N02= i01_size( 2)+ f_size( 2)- 1;
            
            time01= tic;    % iniciar cuenta para convolucion
            g_mat= conv2( i01_g_mat, f_mat, 'full');    % laplaciano de gaussiano de imagen de interes
            g_mat= g_mat( round( 5* sigma_v( i))+ 1: round( 5* sigma_v( i))+ i01_size( 1), round( 5* sigma_v( i))+ 1: round( 5* sigma_v( i))+ i01_size( 2));
            t01_end( i)= toc( time01);  % finalizar cuenta
            
            t02= tic;       % iniciar cuenta para producto en frecuencia
            F_mat= fft2( f_mat, M02, N02);    % funcion de transferencia de laplaciano
            I01_g_mat= fft2( i01_g_mat, M02, N02);    % espectro de imagen de interes
            r_mat= ifft2( I01_g_mat.* F_mat);   % inversion de producto en frecuencia
            r_mat= r_mat( round( 5* sigma_v( i))+ 1: round( 5* sigma_v( i))+ i01_size( 1), round( 5* sigma_v( i))+ 1: round( 5* sigma_v( i))+ i01_size( 2));
            t02_end( i)= toc( t02);
end

fig14= figure; subplot( 2, 1, 1); bar( t01_end);
title( 'Tiempo de procesamiento en segundos para convolucion');
subplot( 2, 1, 2); bar( t02_end, 'r');
title( 'Tiempo de procesamiento en segundos para producto en frecuencia');

% k.
% --- determinar bordes por LoG --- %
h01_mat= fspecial( 'log', size_v( 1), sigma_v( 1)); % filtro laplaciano de gaussiano a usar
e01_mat= edge( i04_mat, 'zerocross', 0, h01_mat);   % implementacion MATLAB del metodo de Marr-Hildreth sin umbral
e02_mat= edge( i04_mat, 'zerocross', 0.07, h01_mat);   % implementacion MATLAB del metodo de Marr-Hildreth con umbral

% --- descripcion grafica --- %
fig15= figure;
subplot( 1, 2, 1); imagesc( e01_mat); axis image;
title( 'Bordes a partir de Marr-Hildreth sin umbral');
subplot( 1, 2, 2); imagesc( e02_mat); axis image; colormap gray;
title( 'Bordes a partir de Marr-Hildreth con umbral');


%% Pregunta 3

% *************************************** %
%  Imagen en el dominio de la frecuencua  %
% *************************************** %

Im =  double(imread('news.png'))/255;
[nRows, nCols] = (size(Im));

Im_f = fft2(Im, 2*nRows, 2*nCols);

figure
subplot(1,2,1), imshow(log10(abs( fftshift(Im_f)) ),[]), title('Magnitud centrada')
subplot(1,2,2), imshow(angle( fftshift(Im_f)) ,[]), title('Fase centrada')


% ****************************************** %
%  Filtro pasa-altos en dominio frecuencial  %
% ****************************************** %
% Datos de entrada
D0 = 31;
n = 15;
P = 2*nRows;
Q = 2*nCols;

% Computo de los indices (u,v) utilizando meshgrid
u_aux = 0:(P-1);
v_aux = 0:(Q-1);

idx = find(u_aux > P/2);
idy = find(v_aux > Q/2);

u_aux(idx) = u_aux(idx) - P;
v_aux(idy) = v_aux(idy) - Q;

[v, u] = meshgrid(v_aux, u_aux);

% Compute the distances D(u, v).
D = sqrt(u.^2 + v.^2);

% Calculo de filtro
Hf_hp = 1 - 1./(1 + (D./D0).^(2*n));

figure
subplot(1,2,1), imshow(log10(abs( fftshift(Hf_hp) )),[]), title('Magnitud centrada')
subplot(1,2,2), imshow(angle( fftshift(Hf_hp) ), []), title('Fase centrada')

% ****************************** %
%    Filtros Rechaza banda       %
% ****************************** %

Hf1 = circshift(Hf_hp , [-235 -241]);
Hf2 = circshift(Hf_hp , [-235 241]);
Hf3 = circshift(Hf_hp , [-146 -101]);
Hf4 = circshift(Hf_hp , [-146 101]);
Hf5 = circshift(Hf_hp , [146 -101]);
Hf6 = circshift(Hf_hp , [146 101]);
Hf7 = circshift(Hf_hp , [235 -241]);
Hf8 = circshift(Hf_hp , [235 241]);

% Filtro total calculado mediante el producto en frecuencia
Htf = (Hf1 .* Hf2 .* Hf3 .* Hf4 .* Hf5 .* Hf6 .* Hf7 .* Hf8);

figure
subplot(1,2,1), imshow(log10(abs(fftshift(Hf1))),[]), title('Magnitud del Filtro 1')
subplot(1,2,2), imshow(log10(abs(fftshift(Htf))),[]), title('Magnitud del Filtro total')

% Filtrado en frecuencia
Im_f_filtrada = Im_f.*Htf;
% Calculo de la transformada inversa
Im_filtrada = real(ifft2(Im_f_filtrada)); 
% Recorte de la imagen para suprimir el padeo
Im_filtrada = Im_filtrada(1:nRows, 1:nCols);

figure
subplot(2,2,1), imshow(log10(abs(fftshift(Im_f))),[]), title('Imagen Original')
subplot(2,2,2), imshow(log10(abs(fftshift(Im_f_filtrada))),[]), title('Imagen Filtrada')
subplot(2,2,3), imshow(Im), 
subplot(2,2,4), imshow(Im_filtrada), 


sigma1 = 2;
sigma2 = 0.1;

% ************************************ %
%   Generaci??n de filtros gaussianos   %
% ************************************ %

M   = round(3*sigma1);
     
[x,y] = meshgrid(-M:M,-M:M);

gaussian1  = 1/(2*sigma1^2) * exp( -(x.*x + y.*y)/(2*sigma1^2) );
gaussian2  = 1/(2*sigma2^2) * exp( -(x.*x + y.*y)/(2*sigma2^2) );
     

sigma = sqrt((sigma1^2*sigma2^2)/(sigma1^2-sigma2^2) * log(sigma1^2/sigma2^2));
% sigma = 0.2451; % Por relacion de DoG entre sigma1 y sigma2 se calcula sigma 
scale = 1/(2*pi*sigma^2);

% **************************** %
%   Diferencia de gaussianos   %
% **************************** %
h_dog = scale*(gaussian1 - gaussian2);

I_dog = conv2(Im_filtrada, h_dog,'same'); 

% ************************************* %
%   Umbralizaci??n (detecion de bordes)  %
% ************************************* %

th1 = 0.1*max(abs(I_dog(:)));
th2 = 0.2*max(abs(I_dog(:)));

figure; 
subplot(2,2,1); imshow(I_dog,[]); title('Diferecia de Gaussianas')
subplot(2,2,2); edge(Im_filtrada, 'zerocross', 0, h_dog); title('Zero-Cross (th = 0)')
subplot(2,2,3); edge(Im_filtrada, 'zerocross', th1, h_dog); title('Zero-Cross 10% MaxVal')
subplot(2,2,4); edge(Im_filtrada, 'zerocross', th2, h_dog); title('Zero-Cross 20% MaxVal')