% IEE239: Ejercicios Propuestos
% Tercera sesion de laboratorio, Semestre 2017-1
close all; clear all;

%% Pregunta 1.

% Ingresamos los coeficientes del filtro
num = 1; 
den = [1 2 2 1];

% Graficamos la respuesta en frecuencia del filtro analogico
w = logspace(-1,1, 1000);
h = freqs(num, den, w);

% el vector h contiene la respuesta en frecuencia del filtro
mag = abs(h);

% ahora a partir de la magnitud de la resp. en frecuencia 
% debemos calcular la frec que corte que corresponde a la magnitud
% que tiene el valor 0.707 (-3db) del valor maximo
v_max = max(mag);
aux = find(mag<0.707*v_max);

% Donde el primier elemento del vector auxiliar aux(1) contiene el valor
% mas cercano a 0.707*v_max

frec_corte = w(aux(1));



% La frecuencia de corte esta almacenada en la variable frec_corte 
% calculada en la seccion anterior
w = 0.4*pi; % frecuencia digital deseada

% calculamos el periodo
T = (2/frec_corte)*tan(w/2);

% Ahora usando la transformada bilineal
[numd, dend] = bilinear(num, den, 1/T);

% Graficamos la respuesta en freciencia digital
freqz(numd, dend);
% Como se puede observar la frecuencia de corte esta en 0.4*pi


% Respuesta al impulso del filtro para 100 muestras
impz(numd, dend, 100);

% Matlab posee funciones que permiten calcular directamente los 
% coeficientes del filtro butter
[fnumd, fdend] = butter(3, 0.4,'low');

% Para hacer una comparacion cuantitativa podemos usar la norma 2 o
% distancia euclidiana entre ambos vectores

err_num = norm(numd-fnumd)
err_den = norm(dend-fdend)
%% Pregunta 3
% Orden del filtro
N=100;
% Establecemos frecuencias de corte
fc=[0.3,0.6];
% realizamos el filtrado por enventanado
[b1]=fir1(N,fc);
A1=freqz(b1);
% Normalización de frecuencias
n_size=2*size(A1,1);
w= 2*pi* ( 0: ( n_size- 1))/ n_size; 
w= fftshift( w);
w= unwrap( w - 2*pi);  
P1=[A1' A1'];
% Espectro de magnitud y fase
subplot(121),plot(w,20*log10(abs(P1)))
subplot(122),plot(w,unwrap(angle(P1)))
%%
%Orden del filtro
N=100;
% Vector de frecuencias de corte del filtro
f21=[0 0.3 0.6 1];
m21=[0 1 1 0];
% Diseño del filtro
b2=fir2(N,f21,m21);
A2=freqz(b2);
% Normalizacion de frecuencias
n_size=2*size(A2,1);
w= 2*pi* ( 0: ( n_size- 1))/ n_size; 
w= fftshift( w);
w= unwrap( w - 2*pi);  
P=[A2' A2'];
subplot(121),plot(w,20*log10(abs(P))),hold on
subplot(122),plot(w,unwrap(angle(P)))
%%
%Orden del filtro
N=100;
% Vector de frecuencias de corte del filtro
f22=[0 0.3 0.3 0.3 0.3 0.6 0.6 0.6 0.6 1];
m22=[0 0 0 1 1 1 1 0 0 0];
% Diseño del filtro
b3=fir2(N,f22,m22);
[A3,w3]=freqz(b3);
% Normalizacion de frecuencias
n_size=2*size(A3,1);
w_H02= 2*pi* ( 0: ( n_size- 1))/ n_size;w_H02= fftshift( w_H02);
w_H02= unwrap( w_H02 - 2*pi);
P=[abs(A3') abs(A3')];
subplot(121),plot(w,20*log10(abs(P))),hold on
subplot(122),plot(w,unwrap(angle(P)))
