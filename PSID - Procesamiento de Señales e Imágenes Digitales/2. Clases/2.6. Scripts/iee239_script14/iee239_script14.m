%% iee239: script 14 - Metodo de Marr-Hildreth
% El script muestra el uso de la funcion 'edge' del Image Processing
% Toolbox para determinar bordes segun el metodo de Laplaciano de
% Gaussiano. Se muestra el caso en el cual se usa un umbral como parte de
% la condicion y el caso en el cual se definen bordes estrictamente como
% cruces por cero. En el ultimo caso, se observa el efecto Spaghetti.

close all; clear all;

i01= imread( 'building.tif');    % imagen de entrada

% --- deteccion de bordes con comando 'edge' --- %
th= 0.05;
sigma_log= 1;

m01= fspecial( 'gaussian', 10* sigma_log, sigma_log);
M01= fftshift( fft2( m01, 1024, 1024));

[ i01_log_sp th_log_sp]= edge( i01, 'log', 0, sigma_log);
[ i01_log th_log]= edge( i01, 'log', th, sigma_log);
% --- END deteccion de bordes con comando 'edge' --- %

% --- descripcion grafica --- %
fig00= figure;
subplot( 1, 2, 1); imagesc( m01); title( 'mascara gaussiana en espacio de muestras'); axis image;
subplot( 1, 2, 2); imagesc( abs( M01)); title( 'mascara gaussiana en frecuencia'); axis image;

fig01= figure;
imagesc( i01); colormap gray
fig02= figure;
subplot( 1, 2, 1); imagesc( i01_log_sp); title( 'bordes por LoG sin umbral');
subplot( 1, 2, 2); imagesc( i01_log); title( ['bordes por LoG con umbral:' num2str( th_log)]);
colormap gray;
% --- END descripcion grafica --- %

%% iee239: script 14 - Deteccion de bordes para imagenes en escala de grises
% el script muestra el uso de la funcion 'edge' del Image Processing
% Toolbox para obtener bordes a partir de diferentes metodos para imagenes
% en escala de grises.

close all; clear all;


i01= imread( 'circuit.tif');    % imagen de entrada

% --- deteccion de bordes con comando 'edge' --- %
th= 0.005;
[ i01_sobel th_sobel]= edge( i01, 'sobel', th);
[ i01_prewitt th_prewitt]= edge( i01, 'prewitt', th);
[ i01_roberts th_roberts]= edge( i01, 'roberts', th);
[ i01_log_sp th_log_sp]= edge( i01, 'log', 0);
[ i01_log th_log]= edge( i01, 'log', th);
[ i01_canny th_canny]= edge( i01, 'canny');
% --- END deteccion de bordes con comando 'edge' --- %




% --- descripcion grafica --- %
fig01= figure;
subplot( 3, 2, 1); imagesc( i01); title( 'imagen original');
subplot( 3, 2, 2); imagesc( i01_sobel); title( 'bordes por mascaras Sobel');
subplot( 3, 2, 3); imagesc( i01_prewitt); title( 'bordes por mascaras Prewitt');
subplot( 3, 2, 4); imagesc( i01_roberts); title( 'bordes por mascaras Roberts');
subplot( 3, 2, 5); imagesc( i01_log); title( 'bordes por LoG');
subplot( 3, 2, 6); imagesc( i01_canny); title( 'bordes por Canny');
colormap gray;

fig02= figure;
subplot( 1, 2, 1); imagesc( i01_log_sp); title( 'bordes por LoG sin umbral');
subplot( 1, 2, 2); imagesc( i01_log); title( ['bordes por LoG con umbral:' num2str( th_log)]);
colormap gray;
% --- END descripcion grafica --- %



%%  iee239: script 14 - Segmentacion global a partir de transformada de Hough
% El script muestra el uso de las funciones 'hough', 'houghpeaks' y
% 'houghlines' del Image Processing Toolbox con el proposito de segmentar
% lineas a partir de la transformada de Hough. La deteccion de bordes es
% realizada a partir del metodo de Canny.

close all; clear all;


% --- imagen de entrada --- %
i01= imread( 'circuit.tif');
i01 = imrotate( i01, 45/ 2, 'crop');   % cambio de orientacion (propositos demostrativos)
[ i01_canny th_canny]= edge( i01, 'canny'); % deteccion de bordes
% --- END imagen de entrada --- %




% --- transformada de Hough --- %
rho_res= 1; % resolucion de parametro rho
theta_res= -90: 89; % resolucion de parametro theta
peaks= 1;  % numero de picos de interes en el espacio rho-theta

[hough_mat, theta_v, rho_v] = hough( i01_canny, 'RhoResolution', rho_res, 'Theta', theta_res);  % calculo de espacio parametrizado
peaks_v= houghpeaks( hough_mat, peaks); % localizacion de maximos en espacio parametrizado
lines_v= houghlines( i01_canny, theta_v, rho_v, peaks_v, 'FillGap', 5, 'MinLength', 2); % localizacion de lineas segun maximos
% --- END transformada de Hough --- %




% --- descripcion grafica --- %
fig02= figure;
figure( fig02);
imagesc( theta_v, rho_v, hough_mat); title( 'espacio parametrizado');
ylabel( 'rho'); xlabel( '\theta'); colorbar;

fig01= figure;
figure( fig01);
subplot( 1, 2, 1); imagesc( i01); axis image; colormap gray; title( 'imagen original');
subplot( 1, 2, 2); 
imagesc( i01_canny); axis image;  title( 'Preprocesamiento: bordes por Canny, Detección de líneas por Hough'); hold on;   % describir bordes y esperar

for i= 1: length( lines_v)
            line_temp= [ lines_v( i).point1; lines_v( i).point2];
            plot( line_temp( :,1), line_temp( :,2), 'LineWidth', 2, 'Color', 'green');  % plotear lineas halladas sobre imagen de bordes
end
% --- END descripcion grafica --- %

%% iee239: script 14 - Umbralizacion de intensidad
% el script muestra el uso de la funcion 'graythresh' para obtener un
% umbral basado en el metodo de Otsu, asumiendo dos clases: primer plano y
% plano de fondo.

close all; clear all;


% --- argumentos de entrada --- %
i01= imread('./poly.tif');
% i01= imread('./huella.png');
i01_size= size( i01);
i01_h= imhist(i01)/ ( i01_size( 1)* i01_size( 2)); % histograma normalizado
% --- END argumentos de entrada --- %




% --- umbralizacion a partir del metodo de Otsu --- %
otsu_th = graythresh( i01)* 255;
i01_otsu_th= uint8( i01> otsu_th)* 255; % imagen umbralizada
% --- END umbralizacion a partir del metodo de Otsu--- %




% --- descripcion grafica --- %
fig01= figure;
figure( fig01); stem(0:255, i01_h); hold on;
stem( otsu_th- 1, i01_h(otsu_th), 'markerfacecolor', 'red', 'color', 'red' );
xlabel('intensidad'); ylabel('pixels'); title('histograma normalizado');
fig02= figure;
figure( fig02);
subplot( 1, 2, 1); imagesc( i01); title( 'imagen original'); axis image;
subplot( 1, 2, 2); imagesc( i01_otsu_th); title( 'segmentacion por Otsu'); axis image; colormap gray;
% --- END descripcion grafica --- %