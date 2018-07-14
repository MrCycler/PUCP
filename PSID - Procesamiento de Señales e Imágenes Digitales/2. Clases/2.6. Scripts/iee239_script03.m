% IEE239: script03: Analisis en Frecuencia
% El script muestra el análisis del espectro de la señal discreta
% frente al criterio de Nyquist. Se muestra tanto el caso en el cual la
% frecuencia de muestreo cumple con dicho criterio y el caso contrario. El
% análisis del espectro de frecuencia complementa el análisis inicial
% basado únicamente en espacio al mostrar directamente las componentes
% dentro del rango fundamental.

close all; clear all;

% --- muestreo de sinusoidal (sin aliasing) --- %
a= 1; % amplitud
f= 10; % frecuencia de la senal (Hz)
t_final= 20; % tiempo final de evaluacion (s)
fs= 95; % frecuencia de muestreo (Hz)
n_v= 0: fs* t_final; % vector de muestras
x01= a* sin( 2* pi* f* n_v/ fs); % senal muestreada
% ---  END muestreo de sinusoidal (sin aliasing) --- %


% --- respuesta en frecuencia (descomposicion en exponenciales complejas) --- %
n_size= 2048;
X01= fftshift( fft( x01, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END respuesta en frecuencia (descomposicion en exponenciales complejas) --- %


% --- descripcion grafica --- %
f01= figure; 
subplot( 3, 1, 1); stem( n_v/ fs, x01, 'o');
grid on; ylabel( 'amplitud'); xlabel( 'tiempo (s)');
legend( 'x(nT)');
subplot( 3, 1, 2); stem( n_v, x01, 'ro');
grid on; ylabel( 'amplitud'); xlabel( 'espacio de muestras'); axis tight;
legend( 'x[n]');
subplot( 3, 1, 3); plot( w_v, abs( X01));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X[\omega]');
% --- END descripcion grafica --- %


% --- muestreo de sinusoidal (con aliasing) --- %
a= 1; % amplitud
f= 10; % frecuencia de la senal (Hz)
t_final= 20; % tiempo final de evaluacion (s)
fs= 18; % frecuencia de muestreo (Hz)
n_v= 0: fs* t_final; % vector de muestras
x02= a* sin( 2* pi* f* n_v/ fs); % senal muestreada
% --- END muestreo de sinusoidal (con aliasing) --- %


% --- respuesta en frecuencia (descomposicion en exponenciales complejas) --- %
n_size= 2048;
X02= fftshift( fft( x02, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END respuesta en frecuencia (descomposicion en exponenciales complejas) --- %


% --- descripcion grafica --- %
f02= figure; 
subplot( 3, 1, 1); stem( n_v/ fs, x02, 'o');
grid on; ylabel( 'amplitud'); xlabel( 'tiempo (s)');
legend( 'x(nT)');
subplot( 3, 1, 2); stem( n_v, x02, 'ro');
grid on; ylabel( 'amplitud'); xlabel( 'espacio de muestras'); axis tight;
legend( 'x[n]');
subplot( 3, 1, 3); plot( w_v, abs( X02));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X[\omega]');
% --- END descripcion grafica --- %

%% IEE239: Cambio de tasa de muestreo
% El script muestra el procedimiento para sobrmuestrear y submuestrar una
% señal discreta. Adicionalmente, se muestra el análisis del resultado
% respecto a la entrada en espacio y en espectro de frecuencia.

close all; clear all;

% --- generacion de senal --- %
w_N= 55; % frecuencia de corte (100= pi)
x_size= 128; % tamano de muestras de senal
n_v= 0: x_size- 1; % vector de muestras
x01= fir2( x_size- 1, linspace( 0, 1, 100), [ linspace( 1, 0, w_N) zeros( 1, ( 100- w_N))]); % generacion de senal (diseno finite impulse response)
n_size= 2048;
X01= fftshift( fft( x01, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END generacion de senal --- %

% --- upsampling --- %
L= 2;
x01_us= zeros( 1, length( x01)* L); % vector de ceros del tamano final
x01_us( 1: L: end)= x01; % introduccion de los elementos de la senal en el vector de ceros
n_size= 2048;
X01_us= fftshift( fft( x01_us, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END upsampling --- %


% --- downsampling --- %
M= 2; % factor de downsampling
x01_ds= x01( 1: M: end); % operacion downsampling
n_size= 2048;
X01_ds= fftshift( fft( x01_ds, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
% --- END downsampling --- %


% --- descripcion grafica --- %
f04= figure;
subplot( 2, 1, 1); stem( n_v, x01, 'k'); hold on;
stem( x01_us);
grid on; title( 'Señal original x[n] vs. señal sobremuetreada x_{e}[n]'); ylabel( 'amplitud'); xlabel( 'espacio de muestras'); axis tight;
legend( 'x[n]', 'x_{e}[n]');
subplot( 2, 1, 2); plot( w_v, abs( X01), 'k'); hold on;
plot( w_v, abs( X01_us));
grid on; title( 'Espectro de señal original X[e^{j\omega}] vs. espectro de señal submuetreada x_{e}[e^{j\omega}]'); ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X[e^{j\omega}]', 'X_{e}[e^{j\omega}]');

f03= figure;
subplot( 2, 1, 1); stem( n_v, x01, 'k'); hold on;
stem( x01_ds);
grid on; title( 'Señal original x[n] vs. señal sobremuetreada x_{d}[n]'); ylabel( 'amplitud'); xlabel( 'espacio de muestras'); axis tight;
legend( 'x[n]', 'x_{d}[n]');
subplot( 2, 1, 2); plot( w_v, abs( X01), 'k'); hold on;
plot( w_v, abs( X01_ds));
grid on; title( 'Espectro de señal original X[e^{j\omega}] vs. espectro de señal submuetreada x_{d}[e^{j\omega}]'); ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X[e^{j\omega}]', 'X_{d}[e^{j\omega}]');
% --- END descripcion grafica --- %