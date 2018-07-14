% IEE239: script04 - Series y transformada de Fourier
% Descripcion: el script muestra una breve introduccion al analisis en
% frecuencia a partir de la Transformada de Fourier. Se demuestra como un
% respuesta en frecuencia cuadrada (filtro pasabajos en este caso) es una
% sumatoria de funciones exponenciales complejas en espacio de muestras. Se
% analiza el comportamiento de la senal cuadrada al truncar el numero de
% exponenciales para analizar su efecto en frecuencia.

close all; clear all;


%   --- parametros de entrada   --- %
w_size= 1024; % tamaño del vector de muestras en frecuencia
cut_freq= pi/ 4; % frecuencia de corte del filtro
m_v= 1: 100; % vector de numero de componentes (M=1, M=2, ..., M=100)
%   --- END parametros de entrada   --- %


% --- dominio en frecuencia --- %
w_v= 2*pi* ( 0: ( w_size- 1))/ w_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
f01= figure; % crear una nueva ventana para descripciones graficas
% --- END dominio en frecuencia --- %


for i= 1: size( m_v, 2);
    m= m_v( i); % numero de componentes seleccionado
    X_v= zeros( 1, w_size); % inicializacion del filtro (vector de ceros)

    for n= -m: m
        X_v= X_v+ ( cut_freq/ pi* sinc( cut_freq/ pi* n))* exp( -1i* w_v* n); % sumatoria de componentes
    end
    
    plot( w_v, abs( X_v), '-r'); % descripción gráfica
    title( [ 'Filtro pasabajos con \omega_{c}= ' num2str( cut_freq) ' / M= ' num2str( m)]);
    xlabel( '\omega'); ylabel( 'H(e^{j \omega})');
    pause( 0.5);
end

%%
% IEE239: script04 - Series y transformada de Fourier Descripcion: el
% script muestra el uso de la funcion fft, ifft, fftshift y ifftshift para
% obtener pares basados en la transformada discreta de Fourier (DFT)

close all; clear all;


% --- argumentos de entrada --- %
n_size= 1024; % tamaño del vector de muestras en frecuencia
cut_freq= pi/ 4; % frecuencia de corte del filtro
% --- END argumentos de entrada --- %


% --- espacio de muestras y frecuencia --- %
n_v= -n_size/ 2: n_size/ 2- 1;  % espacio de muestras
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END espacio de muestras y frecuencia --- %


% --- senal discreta en espacio y frecuencia --- %
x_v= cut_freq/ pi* sinc( cut_freq/ pi* n_v); % señal en espacio
X_v= fft( x_v); % transformada de Fourier (de 0 a 2pi) de x[n]
X_v= fftshift( X_v); % reordenamiento de -pi a pi
xhat_v= ifft( ifftshift( X_v)); % transformada inversa (debería ser igual a x[n])
% --- END senal discreta en espacio y frecuencia --- %


% --- descripcion grafica --- %
fig01= figure;
figure( fig01);
subplot( 3, 1, 1); plot( n_v, x_v); title( 'señal no periódica en tiempo discreto'); xlabel( 'n'); ylabel( 'x[n]');
subplot( 3, 1, 2); plot( w_v, abs( X_v), 'r'); title( 'DFT directa'); xlabel( '\omega'); ylabel( 'X(e^{j\omega})');
subplot( 3, 1, 3); plot( n_v, xhat_v, 'g'); title( 'DFT inversa'); xlabel( 'n'); ylabel( 'x_{hat}[n]');
% --- END descripcion grafica --- %