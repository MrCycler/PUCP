% IEE239: Ejercicios Propuestos
% Primera sesion de laboratorio, Semestre 2017-1
% Ejercicios propuestos


%% 1c

x = [1 2 3 5];
y = [4 8];
[correlacion1,lags]=xcorr(x,y);
[correlacion2]=conv(x,y(end:-1:1));
eje_conv = -length(y)+1:length(x)-1;
subplot(2,1,1)
plot(lags,correlacion1)
title('Correlaci?n mediante xcorr')
subplot(2,1,2)
plot(eje_conv,correlacion2)
title('Correlaci?n mediante conv')

%% 1d

[mixed,fs] = audioread('mixed.wav');

f1 = 400;
f2 = 200;
f3 = 100;

num_muestras = 2000;

tiempo = (0:(num_muestras-1))/fs;
s1 = sin(2*pi*f1*tiempo);
s2 = sin(2*pi*f2*tiempo);
s3 = sin(2*pi*f3*tiempo);

c1 = max(xcorr(mixed,s1))
c2 = max(xcorr(mixed,s2))
c3 = max(xcorr(mixed,s3))

% Las frecuencias f1 y f2 est?n presentes en mixed


%% 2a.
h1_v= [ 3 2 1]; % secuencia h1
n1_v= -3:-1; % dominio de secuencia h1

h2_v= [1 2 3];  % secuencia h2
n2_v= 1: 3; % dominio de secuencia h2

h3_v= [ 2 7 13 7 2];    % secuencia h3
n3_v= -2: 2;    % dominio de secuencia h3

h4_v= [ 1 0 0 0 1]; % secuencia h4
n4_v= -2: 2;    % dominio de secuencia h4


% --- convolucion h1 \ast h2 --- %
alpha_v= conv( h1_v, h2_v); % convoluci?n

% Para determinar su dominio, analizamos el procedimiento que implica la
% suma de convolucion. Primero, se invierte una secuencia (irrelevante cual
% ya que es una operacion conmutativa). Asumiendo h1 se invierte, entonces
% la secuencia resultante tiene dominio [1 2 3].

% Luego, analizando el desplazamiento generado en la convolucion, la
% primera suma de productos distinta de 0 ocurre para n=-2 y la ?ltima para
% n= 2. confirmando esto por teoria, la convolucion de una secuencia de 3
% elementos con otra de 3 elementos debe dar 3+3-1 elementos = 5, lo que
% tiene sentido con lo obtenido.

alpha_n_v= -2: 2;

% --- combinando bloques --- %
% Para las 3 secuencias de interes, el intervalo de n para el que los
% elementos son diferentes de 0 corresponde a : {-2, ... , 2}. Por lo
% tanto, podemos sumer y restar directamente:

n_v= -2: 2;
h_v= alpha_v- h3_v- h4_v;

% --- descripcion grafica --- %
fig01= figure;
subplot( 2, 2, 1); stem( n_v, alpha_v); title( 'convolucion entre h_{1}[n] y h_{2}[n]');
subplot( 2, 2, 2);stem( n_v, h3_v); title( 'h_{3}[n]');
subplot( 2, 2, 3);stem( n_v, h4_v); title( 'h_{4}[n]');
subplot( 2, 2, 4);stem( n_v, h_v); title( 'h[n]');

%% 2b Aplicando la f?rmula de convoluci?n discreta y calculando a mano, se obtiene:
% y[n] = sum_{k=1...4}x[k]*h[n-k]
% y[n] = 0.5*h[n-1] + (1)*h[n-2] + 1.5*h[n-3] + 2*h[n-4]
% y[n] = 0.5*(d[n]+d[n-1]+d[n-2]) + (1)*(d[n-1]+d[n-2]+d[n-3]) + 
%       1.5*(d[n-2]+d[n-3]+d[n-4]) + 2*(d[n-3]+d[n-4]+d[n-5])

%y[n]= 0.5*d[n] + 1.5*d[n-1] + 3*d[n-2] + 4.5*d[n-3] + 3.5*d[n-4] +
%2*d[n-5]

%% 2c
clear all; close all;clc
x = [0.5 1 1.5 2 ]; % secuencia x
nx= 1:4;            % dominio de secuencia x
h = [1 1 1];        % secuencia h
nh = -1:1;          % dominio de secuencia h

% --- convolucion x \ast h usando 'full'--- %
y = conv(x,h);      %
% Para determinar su dominio, al igual que en 1a. Se invierte una secuencia
% y asumiendo h se invierte, entonces la secuencia resultante tiene dominio
% [-1 0 1].
% Luego, al analizar el desplazamiento generado por la primera convoluci?n,
% la primera suma de productos distinta de 0 codurre para n=0 y la ?ltima
% para n=5. Adem?s por teor?a, la convoluci?n de una secuecia de 4
% elementos con otra de 3 elementos debe dar 4+3-1= 6 elementos, lo cual
% corresponde a lo obtenido.
ny = 0:5;

% --- convolucion x \ast h usando 'same'--- %
y2 = conv(x,h,'same');
% Para determinar su dominio, se toma la parte central de la convoluci?n
% completa correspondiente al tama?o de x. Entonces el dominio ser?a n=1:4
ny2 = 1:4;

subplot(211),stem(nx,x),xlabel('n'),title('x[n]'),
subplot(212),stem(nh,h),xlabel('n'),title('h[n]'),
subplot(211),stem(ny,y),xlabel('n'),title('Full'),
subplot(212),stem(ny2,y2),xlabel('n'),title('Same'),


%% 3a. Demostraci?n te?rica:
%----------y[n] = cos(x[n])
    
    % Escalamiento
%   T{a*x1[n]}=cos(a*x1[n])...(1)
%   a*T{x1[n]}=a*cos(x1[n])...(2)


    % Aditividad
%   T{x1[n] + x2[n]}= cos(x1[n] + x2[n])...(3)
%   T{x1[n]}+T{x2[n]}= cos(x1[n])+cos(x2[n])...(4)

%   (1) ~= (2), (3) ~= (4) -->No lineal

    % Invarianza en el tiempo
%   x1[n]=x[n-k]--------->y1[n]=cos(x1[n])=cos(x[n-k])...(1)
%   	  y[n-k]=cos(x[n-k])...(2)
%   (1) = (2) -->Invariante en el tiempo

%---------y[n] = x[n]*cos(wo*n)
    
    % Escalamiento
%   T{a*x1[n]}=a*x[n]*cos(wo*n)...(1)
%   a*T{x1[n]}=a*x[n]*cos(wo*n)...(2)

    % Aditividad
%   T{x1[n] + x2[n]}=(x1[n] + x2[n])*cos(wo*n)...(3)
%   T{x1[n]}+T{x2[n]}=x1[n]*cos(wo*n)+x2[n]*cos(wo*n)=(x1[n] +*x2[n])*cos(wo*n)...(4)

%   (1) = (2), (3) = (4) -->Lineal

    % Invarianza en el tiempo  
%   x1[n]=x[n-k]--------->y1[n]=x1[n]*cos(wo*n)=x[n-k]*cos(wo*n)...(1)
%   	  y[n-k]=x[n-k]*cos(wo*[n-k])...(2)
%   (1) ~= (2) -->No es invariante en el tiempo

%% 3b.
clear all;close all;
n = 0:20;       %dominio de la secuencia 
xn = n;     	%secuencia rampa
a=2;

% --- y[n] = cos(x[n]) --- %
yn = cos(xn);
stem(n,yn),title('Secuencia original')
% Linealidad: Escalamiento
y1 = cos(a*xn);   % Implementacion de T{a*x[n]}
y2 = a*cos(xn);   % Implementacion de a*T{x[n]}
figure,
subplot(121),stem(n,y1),title('T[a*x[n]]'),
subplot(122),stem(n,y2),title('a* T[x[n]]'),
% Se observa que la secuencia cambia y no es la misma

%Linealidad: Aditividad
x1 = cos(xn);
x2 = cos(xn);
T1 =cos(xn+xn); % Implementacion de T{x1[n] + x2[n]}
T2 = x1 + x2;   % T{x1[n]}+T{x2[n]}
subplot(121),stem(n,T1),title('T1')
subplot(122),stem(n,T2),title('T2')
% Se observa que la secuencia cambia y no es la misma,lo cual indica la no
% linealidad

%Invarianza en el tiempo
k = 3;
xn = n;     	%secuencia rampa
xnk = (xn-k);
y1 = cos(xnk);
ynk = [zeros(1,k) y1];
nk = 0:length(n)+k-1;
subplot(121),stem(n,y1),title('x[n-k]')
subplot(122),stem(nk,ynk),title('y[n-k]')
% Se observa que la secuencia se mantiene al desplazarla

% --- y[n] = xn*cos(wo*n) --- %
clear all;close all;
n = 0:20;
xn = n;
wo = pi;
a=2;
yn = xn.*cos(wo*n);
stem(n,yn),title('Secuencia original')
% Linealidad: Escalamiento
y1 = a*xn.*cos(wo*n);   % Implementacion de T{a*x[n]}
y2 = a*xn.*cos(wo*n);   % Implementacion de a*T{x[n]}
figure,
subplot(121),stem(n,y1),title('T[a*x[n]]'),
subplot(122),stem(n,y2),title('a* T[x[n]]'),
% Se observa que la secuencia se mantiene

%Linealidad: Aditividad

x1=xn.*cos(wo*n);
x2=xn.*cos(wo*n);
T1 =(xn+xn).*cos(wo*n); % Implementacion de T{x1[n] + x2[n]}
T2 = x1 + x2;   % T{x1[n]}+T{x2[n]}
subplot(121),stem(n,T1),title('T1')
subplot(122),stem(n,T2),title('T2')
% Se observa que la secuencia se mantiene tambi?n, lo cual verifica la
% linealidad

%Invarianza en el tiempo
k = 3;
xn = n;     	%secuencia rampa
xnk = (xn-k);
ynnk = xnk.*cos(wo*n);
y1 = xn.*cos(wo*n); %transformaci?n original
ynk = [zeros(1,k) y1];%transformaci?n desplazada
nk = 0:length(n)+k-1;
subplot(121),stem(n,ynnk),title('x[n-k]')
subplot(122),stem(nk,ynk),title('y[n-k]')
% Se observa que la secuencia var?a al desplazarla, esto comprueba que no
% es invariante en el tiempo.

%% 3c
% Se determina la Ec. de diferencias a partir del diagrama de la Figura 2:

% y[n] = (1/2)*x[n-2]+(1/2)*y[n-1]+(1/8)*y[n-2]+(1/16)*y[n-3]

% Asumiendo que el sistema est? en reposo.
% Para implementar la rpta. al impulso, consideramos x[n]=d[n]. Al
% reemplazar en la ec. de diferencias, se observa que el sistema es 0 para
% n<2.
n=1:200;    %Definimos el vector n

% Desplazamos la posici?n de h para poder crear el vector, es decir
% h(1)=h[0] .
h(1)=0;
h(2)=0;
for k=3:length(n)
    if(k==3)
        h(k)= (1/2);
    else
        h(k)= (1/2)*h(k-1)+(1/8)*h(k-2)+(1/16)*h(k-3);
    end
end

figure, stem(n-1,h),xlabel('n'),ylabel('h[n]'),title('Respuesta al impulso'),grid on

%% 3d.
clear all;close all;clc;

Fs = 8000;      %Frecuencia de muestreo
% Duraci?n temporal de las notas:
n1 = 0:2000;
n2 = 0:4000;
n3 = 0:8000;

% Generar los tonos de la notas con su respectiva duraci?n temporal:
G= sin(2*pi*392.0*n1/Fs);
g= sin(2*pi*392.0*n2/Fs);
A= sin(2*pi*440.0*n2/Fs);
C= sin(2*pi*523.25*n2/Fs);
cc= sin(2*pi*523.25*n3/Fs);
bb= sin(2*pi*493.88*n3/Fs);
D= sin(2*pi*587.33*n2/Fs);

% Se genera la secuencia, concatenando los tonos generados previamente
m = [G G A g C bb G G A g]';
sound(m,Fs);    %Permite escuchar la secuencia generada

% Para modificar la Fs=4000, se debe de muestrear a la mitad de lo
% muestreado en la se?al original, es decir, se toma una muestra cada dos
% muestras (m2)
m2 = m(1:2:end);
fs2 = Fs/2;
sound(m2,fs2)

% De forma similar, para modificar la Fs=1000, se debe de muestrear una
% muestra cada 8 de la secuencia original.
m4 = m(1:8:end);
fs4 = Fs/8;
sound(m4,fs4)

% Usando xcorr de la secuencia con la se?al correspondiente a la nota 'bb':
[C2,lag] = xcorr(m,bb);
[~,I] = max(abs(C2));
Sample = lag(I);      %muestra donde inicia la nota bb
timeD = Sample/Fs;  %Se divide entre la frecuencia de muestreo para obtener el tiempo

plot(lag,C2),title('Correlaci?n cruzada')

% se obtiene un pico correspondiente al n?mero de veces que esta nota
% est? presente en la secuencia que es 1.


%% 4a. expresion matematica y expresion de periodo

% expresion en tiempo discreto: s_{k}[n]= exp(j 2\pi \frac{k}{8} n). Exponenciales complejas armonicamente relacionadas
% periodo funcamental en cada caso: T= \frac{8}{k}, N= 8

%% 4b. exponenciales complejas dentro del rango fundamental

N= 8;   % periodo de la familia de exponenciales complejas
n_v= 0: 2* N- 1;    % espacio de muestras

s0_v= exp( 1i* 2* pi* 0/ N* n_v);
s2_v= exp( 1i* 2* pi* 2/ N* n_v);
s4_v= exp( 1i* 2* pi* 4/ N* n_v);
s6_v= exp( 1i* 2* pi* 6/ N* n_v);

fig01= figure;  % componentes real e imaginaria a partir de exponencial compleja
subplot( 4, 1, 1);
stem( n_v, real( s0_v)); hold on;
stem( n_v, imag( s0_v), 'r'); hold on;
title( 's_{0}[n]'); legend( 'real', 'imag');
subplot( 4, 1, 2);
stem( n_v, real( s2_v)); hold on;
stem( n_v, imag( s2_v), 'r'); hold on;
title( 's_{2}[n]'); legend( 'real', 'imag');
subplot( 4, 1, 3);
stem( n_v, real( s4_v)); hold on;
stem( n_v, imag( s4_v), 'r'); hold on;
title( 's_{4}[n]'); legend( 'real', 'imag');
subplot( 4, 1, 4);
stem( n_v, real( s6_v)); hold on;
stem( n_v, imag( s6_v), 'r'); hold on;
title( 's_{6}[n]'); legend( 'real', 'imag');

%% 4c. verificar componentes de s_{6}[n]

real_s6_v= cos( 2* pi* 6/ N* n_v);  % directamente por identidad de Euler
imag_s6_v= sin( 2* pi* 6/ N* n_v);

fig02= figure;
subplot( 2, 1, 1);
stem( n_v, real( s6_v)); hold on;
stem( n_v, imag( s6_v), 'r'); hold on;
title( 'componentes a partir de exponencial compleja'); legend( 'real', 'imag');
subplot( 2, 1, 2);
stem( n_v, real_s6_v); hold on;
stem( n_v, imag_s6_v, 'r')
title( 'componentes a partir de sinusoidales'); legend( 'real', 'imag');

%% 4d. periodicidad de exponenciales complejas armonicamente relacionadas en tiempo discreto

sn3_v= cos( 2* pi* -3/ N* n_v);
s0_v= cos( 2* pi* 0/ N* n_v);
s5_v= cos( 2* pi* 5/ N* n_v);
s8_v= cos( 2* pi* 8/ N* n_v);

fig03= figure;
subplot( 4, 1, 1); stem( n_v, sn3_v); title( 's_{-3}[n]');
subplot( 4, 1, 2); stem( n_v, s0_v, 'r'); title( 's_{0}[n]');
subplot( 4, 1, 3); stem( n_v, s5_v, 'g'); title( 's_{5}[n]');
subplot( 4, 1, 4); stem( n_v, s8_v, 'k'); title( 's_{8}[n]');

% dado que N= 8. la secuencia para k=-3 es equivalente a la secuencia para
% k=5, ya que se cumple con la condicion s_{k+N}= s_{k}. Los mismo ocurre
% con k= 0 y k= 8. ambos son casos particulares de la periodicidad de las
% exponenciales complejas armonicamente relacionadas en tiempo discreto.

%% 4e. ecuacion de diferencias del sistema

% a_v= \{ 1, -0.4, 0.75\}
% b_v= \{ 2.2403, 2.4908, 2.2403\}
%
% ecuacion de diferencias:
% y[n]- 0.4 y[n-1]+ 0.75 y[n-2]= 2.2403 x[n]+ 2.4908 x[n-1]+ 2.2403 x[n-2]
% (M= N= 3).

%% 4f. respuesta del sistema ante secuencia sinusoidal

x_v= real( cos( 2* pi* 3/ N* n_v));
a_v= [ 1, -0.4, 0.75];
b_v= [ 2.2403, 2.4908, 2.2403];

y_v= filter( b_v, a_v, x_v);

fig04= figure;
subplot( 2, 1, 1); stem( x_v); title( 'secuencia de entrada');
subplot( 2, 1, 2); stem( y_v); title( 'secuencia de salida');

%% 4g. analisis de invariante en el tiempo

xd_v= [ zeros( 1, 5) x_v];      % entrada retardada 5 muestras
yd_v= [ zeros( 1, 5) y_v];      % salida retardada 5 muestras
Txd_v= filter( b_v, a_v, xd_v);

fig05= figure;
subplot( 2, 1, 1); stem( yd_v), title( 'salida original con retardo');
subplot( 2, 1, 2); stem( Txd_v, 'r'), title( 'respuesta a entrada con retardo');

%% 4h. analisis de invariante en el tiempo (cont.)

xd_v= [ zeros( 1, 10) x_v];      % entrada retardada 5 muestras
yd_v= [ zeros( 1, 10) y_v];      % salida retardada 5 muestras
Txd_v= filter( b_v, a_v, xd_v);

fig06= figure;
subplot( 2, 1, 1); stem( yd_v), title( 'salida original con retardo');
subplot( 2, 1, 2); stem( Txd_v, 'r'), title( 'respuesta a entrada con retardo');

% De lo observado, un retardo en la entrada implica el mismo retardoen la
% salida. De los casos paticulares evaluados, el sistema podr?a ser
% invariante en el tiempo. Sin embargo, no es posible concluir con certeza
% esto ya que no se analiza el caso general.