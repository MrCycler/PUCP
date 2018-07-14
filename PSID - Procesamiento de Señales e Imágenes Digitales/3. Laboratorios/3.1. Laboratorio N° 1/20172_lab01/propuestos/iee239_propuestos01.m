% IEE239: Ejercicios Propuestos
% Primera sesion de laboratorio, Semestre 2017-1
close all; clear all;

%% Pregunta 1.
% --- lectura y reproduccion de audio --- %
str01= './scream.wav';  % asumiendo que MATLAB apunta a la carpeta en la cual se encuentran los archivos WAV
str02= './back.wav';

[ scream_v, fs01]= audioread( str01);    % scream_v: secuencia de audio, fs01: frecuencia de muestreo a la cual fue adquirida la senal
length_v= 1: 4* fs01;   % numero de muestras 4 primeros segundos de audio para una frecuencia de muestreo fs01
scream_v= scream_v( length_v, 1);   % preservar unicamente los primeros 4 segundos de audio
player= audioplayer( scream_v, fs01);
play( player);  % reproducir audio

[ back_v, fs02]= audioread( str02);
back_v= back_v( length_v, 1);
player= audioplayer( back_v, fs02);
play( player);

% --- descripcion grafica --- %
fig01= figure;
subplot( 2, 1, 1); plot( scream_v); title( 'audio con sonidos agudos (alta frecuencia)');
xlabel( 'muestras'); ylabel( 'amplitud');
subplot( 2, 1, 2); plot( back_v); title( 'audio con sonidos graves (baja frecuencia)');
xlabel( 'muestras'); ylabel( 'amplitud');

% --- superposicion de audio --- %
super_v= scream_v+ back_v;
player= audioplayer( super_v, fs02);    % dado que fs01 y fs02 tienen el mismo valor, es posible realizar la suma sin distorsionar el audio.
play( player);

% --- respuesta de audio superpuesto a sistema LTI --- %
load ./lti01.mat    % asumiendo que MATLAB apunta a la carpeta en la cual se encuentran el archivo MAT
y01= conv( super_v, b_v, 'same');   % Primer argumento: secuencia de entrada. Segundo argumento, respuesta al impulso. Usar bandera 'same' para preservar el tamano de la secuencia de entrada.
e_y01= norm( y01- scream_v);
player= audioplayer( y01, fs02);    % reproducir resultado
play( player);

% --- sistema para preservar componentes graves en funcion a sistema LTI original --- %
b_hat_v= zeros( size( b_v));    % vector de 0s
b_hat_v( 1025)= 1;    % impulso unitario (asumiendo que la posicion 1025 del vector corresponde a n= 0) [fase lineal]
b_hat_v= b_hat_v- b_v;   % respuesta al impulso del nuevo sistema
z01= conv( super_v, b_hat_v, 'same');   % Primer argumento: secuencia de entrada. Segundo argumento, respuesta al impulso. Usar bandera 'same' para preservar el tamano de la secuencia de entrada.
e_z01= norm( z01- back_v);
player= audioplayer( z01, fs02);    % reproducir resultado
play( player);


% --- Media acumulada --- %
y_v= zeros( size( super_v));    % vector de ceros (primera posicion corresponde a n= 0)
iter_t= tic;    % iniciar cuenta de tiempo de procesamiento
for i= 1: length( super_v)
            y_v( i)= 1/( i- 1+ 1)* sum( super_v( 1: i));    % media acumulada para cada valor de n calculada de forma no recursiva
end
iter_time_v= toc( iter_t);  % terminar cuenta

y_rec_v=  zeros( size( super_v));    % vector de ceros (primera posicion corresponde a n= 0)

iter_rec_t= tic;    % iniciar cuenta de tiempo de procesamiento
y_rec_v( 1)= super_v( 1);   % analizar salida cuando n=0: asumir sistema en reposo
for i= 2: length( super_v)
            y_rec_v( i)= (i- 1)/( i- 1+ 1)* y_rec_v( i- 1)+ 1/( i- 1+ 1)* super_v( i);    % media acumulada calculada de forma recursiva (depende de salida anterior)
end
iter_rec_time= toc( iter_rec_t);    % terminar cuenta

e_acumulada= norm( y_v- y_rec_v);   % verificar si ambas secuencias son equivalentes

% --- reproduccion y descripcion grafica --- %
player= audioplayer( y_v, fs02);
play( player);

fig_acumulada= figure;
subplot( 2, 1, 1); plot( super_v);
title( 'entrada de sistema media acumulada');
ylabel( 'amplitud'), xlabel( 'muestras');
subplot( 2, 1, 2); plot( y_v, 'r');
title( 'salida de sistema media acumulada');
ylabel( 'amplitud'), xlabel( 'muestras');


%% Pregunta 3.
% --- Calculando la respuesta al impulso --- %

b1=[0.14, 0.14]; 
a1=[1, -0.73];
h1=impz(b1,a1,20);

% Pregunta 3.1:

% --- Calculando la respuesta al impulso con h[n]--- %

n=(0:19)';  % se generan 20 muestras de forma vertical    
h2= 0.14*((0.73).^(n)+ (n-1>=0).*(0.73).^(n-1) );
%Se considera (n-1>=0) para considerar el retrazo en tiempo de u[n-1]

% --- descripcion grafica --- %
fig01= figure;
subplot( 2, 1, 1); stem(n,h1); title( 'Respuesta al impulso calculada con Impz');
xlabel( 'muestras'); ylabel( 'amplitud');
subplot( 2, 1, 2); stem(n,h2 ); title( 'Respuesta al impulso calculada de forma analitica');
xlabel( 'muestras'); ylabel( 'amplitud');

error=norm(h1-h2);

%%
% Pregunta 3.2:

% ---Calculando polos y ceros ---%
zplane(b1,a1)

%%
% Pregunta 3.3:

% ---Calculando la señal discreta x[n] ---%

n=0:199;  % Vector de espacio de muestras.
T=1/2000; % Frecuencia de muestreo
t=n*T;    % Vector de Tiempo discreto
x= sin(2*pi*10*t)+0.5*sin(2*pi*500*t);

plot(n,x); title('Señal discreta x[n]');
xlabel( 'muestras'); ylabel( 'amplitud');

%%
% ---Calculando la señal discreta y[n] ---%

y=conv(x,h1);    
y=y(1:end-20+1); %el Vector resultante es recortado a la misma longitud de x[n] 
fig01= figure;
subplot( 2, 1, 1); plot(n,y); title( 'Respuesta del sistema y[n]');
xlabel( 'muestras'); ylabel( 'amplitud');
subplot( 2, 1, 2); plot(n,x ); title( 'Señal de entrada x[n]');
xlabel( 'muestras'); ylabel( 'amplitud');