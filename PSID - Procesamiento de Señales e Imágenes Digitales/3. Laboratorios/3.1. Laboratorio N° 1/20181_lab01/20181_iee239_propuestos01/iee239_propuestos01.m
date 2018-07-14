%% Pregunta 2
clear; close all; clc;

%%%%%%%%%%%%%
% Pregunta 2a
%%%%%%%%%%%%%
% generar el impulso
impulso = [1; zeros(9,1)];
% obtener la salida al sistema
h = sistemaEjemplo(impulso);
figure;
stem([0:9],h,'lineWidth',2);
title('Respuesta al impulso del sistema');
xlabel('Tiempo');
ylabel('h[n]');

%%%%%%%%%%%%%
% Pregunta 2c
%%%%%%%%%%%%%

% general escal?n y rampa
u = [ones(10,1)];
r = [1:10]';
% respuestas con la funci?n dada
y1 = sistemaEjemplo(u);
y2 = sistemaEjemplo(r);
figure;
subplot(2,2,1);
stem([0:9],y1,'lineWidth',2);
xlabel('Tiempo');
ylabel('Respuesta al escal?n');
title('Rpta con funci?n dada al escalon');
subplot(2,2,2);
stem([0:9],y2,'lineWidth',2);
xlabel('Tiempo');
ylabel('Respuesta a la rampa');
title('Rpta con funci?n dada a la rampa');
% respuestas por convolucion
h = [1 5 2.5];
g1 = conv(h,u);
g2 = conv(h,r);
subplot(2,2,3);
stem([0:length(u)+length(h)-2],g1,'lineWidth',2);
xlabel('Tiempo');
ylabel('Respuesta al escal?n');
title('Rpta con convoluci?n al escalon');
subplot(2,2,4);
stem([0:length(u)+length(h)-2],g2,'lineWidth',2);
xlabel('Tiempo');
ylabel('Respuesta a la rampa');
title('Rpta con convoluci?n a la rampa');

%%%%%%%%%%%%%
% Pregunta 2d
%%%%%%%%%%%%%
H = toeplitz([1;5;2.5;zeros(9,1)],[1 zeros(1,9)]');
G = pinv(H);
x = rand(10,1);
y = H*x;
x_estimado = G*y;

% Ejemplo de sistema variante en el tiempo
H2 = randn(12,10);
G2 = pinv(H2);
x2 = rand(10,1);
y2 = H2*x2;
x2_estimado = G2*y2;

%% Pregunta 3
close all; clear all;

% --- a. secuencia de interes --- %
N= 48;  % longitud del dominio
n_v= 0: N-1;    % espacio de muestras
x01_v= ( n_v- 5).*( n_v>= 5 & n_v< 16)+ ( 25- n_v).* ( n_v>= 16 & n_v< 25); % secuencia triangular

fig01= figure; stem( n_v, x01_v); xlabel( 'n'); ylabel( '\hat{x}[n]'); title( 'Secuencia Triangular');

% --- b. determinar ecuacion de diferencias del sistema y respuesta ante triangular --- %
% Del diagrama de bloques, obtenemos la siguiente relacion implicita:
% y[ n]- y[ n- 1]= x[ n]- 3x[ n- 1]+ 3x[ n- 2]- x[ n- 3]

y01_v= func_Td2( x01_v, 0);  % sistema a partir de for-loops, inicialmente en reposo
b_v= [ 1 -3 3 -1];    % coeficientes de entrada
a_v= [ 1 -1]; % coeficientes de salida
y_filter_v= filter( b_v, a_v, x01_v);   % verificar con filter

fig02= figure;
subplot( 2, 1, 1); stem( n_v, x01_v); xlabel( 'n'); ylabel( 'x[n]'); title( 'Secuencia de entrada') % descripcion grafica
subplot( 2, 1, 2); stem( n_v, y01_v, 'r'); xlabel( 'n'); ylabel( 'T\{x[n]\}'); title( 'Respuesta del sistema ante x[n]') % descripcion grafica

% De la grafica, se observa que la secuencia de salida genera cambios en
% las posiciones en las cuales la entrada sufre cambios. Considerando que
% la primera derivada de una secuencia triangular corresponde a una onda
% cuadrada y que la derivada de esta ultima corresponde a tres impulsos
% ubicados en las transiciones, se concluye que el sistema es un
% derivador de 2do orden.

% --- c. verificar secuencia de salida a partir de filter() --- %
y01_alt_v= filter( b_v, a_v, x01_v);
errval= norm( y01_v- y01_alt_v);    % distancia ecludiana entre salida por la rutina func_Td2 y por filter

% errval es cercano a 0 absoluto, lo que indica que ambos vectores son
% iguales.

fig03= figure;
subplot( 2, 1, 1); stem( n_v, y01_v); xlabel( 'n'); ylabel( 'T\{x[n]\}'); title( 'Respuesta del sistema a partir de for-loops') % descripcion grafica
subplot( 2, 1, 2); stem( n_v, y01_alt_v, 'r'); xlabel( 'n'); ylabel( 'T\{x[n]\}'); title( 'Respuesta del sistema a partir de filter') % descripcion grafica

% --- d. respuesta ante secuencia con retardo --- %
D= 10;
x02_v= [ zeros( 1, D) x01_v( 1: end- D)];   % ingresar D ceros, descartar ultimas D muestras
y02_v= func_Td2( x02_v, 0);  % sistema a partir de for-loops, inicialmente en reposo

fig04= figure;
subplot( 2, 2, 1); stem( n_v, x01_v); xlabel( 'n'); ylabel( 'x[n]'); title( 'Secuencia de entrada'); % descripcion grafica
subplot( 2, 2, 2); stem( n_v, x02_v); xlabel( 'n'); ylabel( 'x_{d}[n]'); title( 'Secuencia de entrada retardada'); % descripcion grafica
subplot( 2, 2, 3); stem( n_v, y01_v, 'r'); xlabel( 'n'); ylabel( 'T\{x[n]\}'); title( 'Respuesta ante x[n]'); % descripcion grafica
subplot( 2, 2, 4); stem( n_v, y02_v, 'r'); xlabel( 'n'); ylabel( 'T\{x_{d}[n]\}'); title( 'Respuesta ante x_{d}[n]'); % descripcion grafica

% De las graficas, se observa que la respuesta ante la entrada con retardo
% es similar a la salida original retardada el mismo numero de muestras.
% Esto es un indicio de que el sistema puede ser invariante en el tiempo.
% No podemos asegurar ello ya que, para que cumpla con la propiedad,
% deberiamos demostrar que el comportamiento es valido para toda secuencia
% de entrada (y no solo para un caso particular).

% --- e. respuesta al impulso del sistema --- %
% Por division de polinomios, encontramos que h[n] corresponde a {->1<-,
% -2, 1}. Ya que la respuesta al impulso tiene solo 3 muestras diferentes
% de 0 en {0, 1, 2}, su respuesta al impulso es de duracion finita: es un
% sistma FIR.
% 
% De la misma forma, analizando si la respuesta al impulso es absolutamente
% sumable, obtenemos que la suma del valor absoluto de cada elemento
% corresponde a 4. Por lo tanto, h[n] es absolutamente sumable y en
% consecuencia el sistema LTI es BIBO estable

h_v= impz( b_v, a_v, N);    % verificar con impz()
y_conv_v= conv( h_v, x01_v);    % respuesta por convolucion.
y_conv_v= y_conv_v( 1: length( x01_v)); % mantener longitud original

fig05= figure;
subplot( 3, 1, 1); stem( n_v, h_v); xlabel( 'n'); ylabel( 'h[n]'); title( 'Respuesta al impulso del sistema'); % descripcion grafica
subplot( 3, 1, 2); stem( n_v, y01_v, 'r'); xlabel( 'n'); ylabel( 'y[n]'); title( 'Salida por implementacion recursiva'); % descripcion grafica
subplot( 3, 1, 3); stem( n_v, y_conv_v, 'g'); xlabel( 'n'); ylabel( 'y[n]'); title( 'Salida por convolucion'); % descripcion grafica

% --- f. sistema inverso a partir de transformada Z --- %
% Del inciso anterior, se sabe que el sistema FIR tiene la siguiente
% funcion de transferencia: H(z)= 1 -2z^{-1}+ z^{-3}. Por lo tanto, si
% creamos un sistema lineal cuya funcion de transferencia sea Hinv(z)=
% 1/H(z) = 1/( 1 -2z^{-1}+ z^{-3}), se podria revertir el efecto del
% sistema H sobre la secuencia de entrada x:

% Expresado de forma analitica: Tinv{T{x[n]}}= Tinv{y[n]}= x[n]

a_inv= [ 1 -2 1];   % coeficientes del denominador para hinv
b_inv= 1;   % coeficientes dle numerador para hinv
z01_v= filter( b_inv, a_inv, y01_v);    % usar filter para implementar el sistema inverso y obtener su respuesta ante y[n]

fig06= figure;
subplot( 3, 1, 1); stem( n_v, x01_v); xlabel( 'n'); ylabel( 'x[n]'); title( 'Secuencia de entrada x');
subplot( 3, 1, 2); stem( n_v, y01_v, 'r'); xlabel( 'n'); ylabel( 'y[n]'); title( 'Respuesta de sistema Td2 ante x');
subplot( 3, 1, 3); stem( n_v, z01_v, 'g'); xlabel( 'n'); ylabel( 'z[n]'); title( 'Respuesta de sistema inverso ante y');

% --- analisis de sistema inverso --- %
% Teoricamente, la unica forma de obtener una salida causal a partir de una
% entrada causal es si el sistema es causal. Dado que funcion de
% transferencia del filtro inverso est? compuesta solo por polos, entonces
% se sabe que se trata de un sistema de respuesta al impulso infinita.
% Podemos brindar un indicio de ello a partir de la funcion impz(), de tal
% forma que hallemos la respuesta al impulso del sistema inverso para un
% gran numero de muestras:

M= 256;
m_v= 0: M- 1;
hinv_v= impz( b_inv, a_inv, M);

fig07= figure;
stem( m_v, hinv_v); xlabel( 'n'); ylabel( 'h_{inv][n]'); title( 'Respuesta la impulso del sistema inverso');

% De la grafica, podemos observas que la respuesta al impulso crece casi
% con pendiente constante. Si se varia el numero de muestras a analizar, se
% observa que el patron se mantiene. Esto indica que le sistema podria ser
% IIR. Por otro lado, dado que los valores de la secuencia crecen en
% funcion a n, el sistema podria ser inestable. Para verificar lo ultimo,
% se describe su diagrama de polos y ceros:

fig08= figure;
zplane( b_inv, a_inv);  % diagrama de polos y ceros del sistema inverso

% El diagrama muestra que existe un polo doble en z=1. Siendo el sistema
% causal, entonces su region de convergencia corresponde a |z|> 1. Al no
% incluir al circulo unitariom se demuestra que se trata de un sistema
% inestable.