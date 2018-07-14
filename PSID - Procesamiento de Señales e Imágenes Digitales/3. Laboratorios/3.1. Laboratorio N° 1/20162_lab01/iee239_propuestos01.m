% IEE239: Ejercicios Propuestos
% Primera sesion de laboratorio, Semestre 2016-2
%% Solucion de pregunta 2

clear; close all; clc;

% Secuencia de entrada
N = 50;   % Longitud de la secuencia
n = 0:N-1;   % Muestras
x = 2*(0.9).^n;   % SeÒal de entrada.

% Parte (a)
% Se puede calcular H(z) = (1/4 + (2/4)z^-1 + (1/4)z^-3)/(1) 
b = [1/4 2/4 0 1/4];     % Coeficientes del numerador de H(z)
a = [1];                 % Coeficientes del denominador de H(z)

% Verificar con la funciÛn impz los valores de h[n]
% En este caso se elegir· la longitud del filtro igual a la
% longitud que la secuencia de entrada
h = impz(b,a,N);   
figure(1); stem(n,h); title('Impulse response') ;
% De acuerdo a lo que se observa en la gr·fica el sistema es tipo FIR
% porque la cantidad de elementos diferentes a cero es finita. Adem·s los
% valores de h[n] son directamente los coeficientes del numerador de la
% funciÛn de transferencia.

% Respuesta en frecuencia
figure(2); freqz(b,a);  

% Gr·fica de polos y ceros. 
figure(3); zplane(b,a);  
% ROC: z > 0
% ROC incluye z = 1. Entonces se puede decir que el sistema es BIBO estable.

% Secuencia de salida y[n]
y = filter(b,a,x);
figure(4)
subplot(211); stem(n,x);
subplot(212); stem(n,y);
% La seÒal de entrada es una exponencial acotada. De la seÒal de salida se
% observa la salida tambiÈn est· acotada, lo cual es consistente con la
% propiedad de BIBO estabilidad del sistema.


% Parte (b)
close all;
% H(z) = (1 + (0.5)z^-1)/(1 + (0.5)z^-1 - (0.25)z^-2) 
b = [1 0.5];             % Coeficientes del numerador de H(z)
a = [1 0.5 -0.25];       % Coeficientes del denominador de H(z)
h = impz(b,a,N);   
figure(1); stem(n,h); title('Impulse response') ;
% De acuerdo a lo que se observa en la gr·fica el sistema es tipo IIR
% porque si bien los elementos decrecen no llegan a volverse cero excepto 
% en el infinito.

% Respuesta en frecuencia
figure(2); freqz(b,a); 

% Gr·fica de polos y ceros. 
figure(3); zplane(b,a);  
% ROC: z > 0.809
% ROC incluye z = 1. Entonces se puede decir que el sistema es BIBO estable.

% Secuencia de salida y[n]
y = filter(b,a,x);
figure(4)
subplot(211); stem(n,x);
subplot(212); stem(n,y);
% La seÒal de entrada es una exponencial acotada. De la seÒal de salida se
% observa la salida tambiÈn est· acotada, lo cual es consistente con la
% propiedad de BIBO estabilidad del sistema.

% Parte (c)
close all;
% H(z) = (2)/(1 - (0.9)z^-1) 
b = 2;               % Coeficientes del numerador de H(z)
a = [1 -0.9];        % Coeficientes del denominador de H(z)
h = impz(b,a,N);   
figure(1); stem(n,h); title('Impulse response') ;
% De acuerdo a lo que se observa en la gr·fica el sistema es tipo IIR
% porque si bien los elementos decrecen no llegan a volverse cero excepto 
% en el infinito.

% Respuesta en frecuencia
figure(2); freqz(b,a); 

% Gr·fica de ceros y polos
figure(3); zplane(b,a);  
% ROC: z > 0.90
% ROC incluye z = 1. Entonces se puede decir que el sistema es BIBO estable.

% Secuencia de salida y[n]
y = filter(b,a,x);
figure(4)
subplot(211); stem(n,x);
subplot(212); stem(n,y);
% La seÒal de entrada es una exponencial acotada. De la seÒal de salida se
% observa la salida tambiÈn est· acotada, lo cual es consistente con la
% propiedad de BIBO estabilidad del sistema.

% parte (d)
close all;
% H(z) = (-0.45 -(0.4)z^-1 +z^-2)/(1 - (0.4)z^-1 - (0.45)z^-2) 
b = [-0.45 -0.4 1];    % Coeficientes del numerador de H(z)
a = [1 -0.4 -0.45];    % Coeficientes del denominador de H(z)
h = impz(b,a,N);   
figure(1); stem(n,h); title('Impulse response') ;
% De acuerdo a lo que se observa en la gr·fica el sistema es tipo IIR
% porque si bien los elementos decrecen no llegan a volverse cero excepto 
% en el infinito.

% Respuesta en frecuencia
figure(2); freqz(b,a); 

% Gr·fica de ceros y polos
figure(3); zplane(b,a);  
% ROC: z > 0.90
% ROC incluye z = 1. Entonces se puede decir que el sistema es BIBO estable.

% Secuencia de salida y[n]
y = filter(b,a,x);
figure(4)
subplot(211); stem(n,x);
subplot(212); stem(n,y);
% La seÒal de entrada es una exponencial acotada. De la seÒal de salida se
% observa la salida tambiÈn est· acotada en el rango [-2,1], lo cual es consistente con la
% propiedad de BIBO estabilidad del sistema.


% Parte (e)
close all;
% Se puede calcular H(z) = (1 + (0.8)z^-1 + ((0.8)^2)z^-2 + ((0.8)^3)z^-3) ...
% ... + ((0.8)^4)z^-4/((1 + (0.9)z^-1 + ((0.9)^2)z^-2 + ((0.9)^3)z^-3) + ((0.9)^4)z^-4) 
b = [1 0.8 0.8^2 0.8^3 0.8^4];
a = [1 0.9 0.9^2 0.9^3 0.9^4];
h = impz(b,a,N);   
figure(1); stem(n,h); title('Impulse response') ;
% De acuerdo a lo que se observa en la gr·fica el sistema es tipo IIR
% porque si bien los elementos decrecen no llegan a volverse cero excepto 
% en el infinito.

% Respuesta en frecuencia
figure(2); freqz(b,a); 

% Gr·fica de ceros y polos
figure(3); zplane(b,a);  
% Magnitud de los polos seg˙n la gr·fica
d1 = sqrt(0.2781^2 + 0.856^2);   % 0.9
d2 = sqrt((-0.7281)^2 + 0.529^2);  % 0.9
% ROC: z > 0.90
% ROC incluye z = 1. Entonces se puede decir que el sistema es BIBO estable.


y = filter(b,a,x);
figure(4)
subplot(211); stem(n,x);
subplot(212); stem(n,y);
% La seÒal de entrada es una exponencial acotada. De la seÒal de salida se
% observa tambiÈn est· acotada, lo cual es consistente con la % propiedad
% de BIBO estabilidad del sistema.


%% Solucion de pregunta 3

close all; clear all;

% a.
% Por divisi√≥n de polinomios, la funci√≥n de transferencia es expresable
% como:
% H(z) = \frac{Y(z)}{X(z)} = \frac{2/5z^{-3}-29/15z^{-2}-33/15z^{-1}+7}{2/15z^{-2}-13/15z^{-1}+1}
% = (3z^{-1}+ 5)+ \frac{1}{1- 2/3z^{-1}} + \frac{1}{1- 1/5z^{-1}}
% Entonces, asumiendo causalidad, la respuesta al impulso es expresable
% como:
% 
% h[n]= 3\delta{n-1}+ 5\delta[n]+ (2/3)^{n}u[n]+ (1/5)^{n}u[n].
% 
% Es demostrable que la respuesta al impulso es absolutamente sumable dado
% que los t√©rminos que se extienden al infinito son de raz√≥n decreciente.
% Por lo tanto, se trata de un sistema BIBO estable.

% Alternativa: analizar su diagrama de polos y ceros:
num= [ 7 -33/15 -29/15 2/5];
den= [ 1 -13/15 2/15];

zplane( num, den);  % describir el diagrama de polos y ceros. Argumento de entrada, coeficientes de la ecuacion de diferencias.

% De la gr√°fica, se observa que los polos est√°n incluidos dentro del
% circulo unitario: asumiendo que se trata e un sistema causal, la R.O.C.
% sera la interseccion de las R.O.C. de todos los terminos en su forma causal.
% Entonces, la R.O.C. es |z|> 2/3. Dado que se incluye al circulo
% unitario, se asegura que el sistema es BIBO estable.

% b.

% codigo para calcular la respuesta al impulso del sistema

delta01_v= [ 1; zeros( 5- 1, 1)];    %  funcion impulso unitario para n \in \{0; 4\}
delta02_v= [ 1; zeros( 20- 1, 1)];    %  funcion impulso unitario para n \in \{0; 19\}
delta03_v= [ 1; zeros( 100- 1, 1)];    %  funcion impulso unitario para n \in \{0; 99\}


x01_v= delta03_v;   % variar senal de entrada
y01_v= zeros( size( x01_v));    % memory allocation (MALLOC): separar memoria para respuesta del sistema

for i= 1: length( x01_v)

            if i== 1
                        y01_v( i)= num( 1)* x01_v( i)+ num( 2)* 0+ num( 3)* 0+ num( 4)* 0 ...   % ingresando condiciones iniciales y asumiendo entrada causal
                - den( 2)* 0- den( 3)* 0;
                
            elseif i== 2
               
                        y01_v( i)= num( 1)* x01_v( i)+ num( 2)* x01_v( i- 1)+ num( 3)* 0+ num( 4)* 0 ...    % ingresando condiciones iniciales y asumiendo entrada causal
                - den( 2)* y01_v( i- 1)- den( 3)* 0;
                
            elseif i== 3
                
                        y01_v( i)= num( 1)* x01_v( i)+ num( 2)* x01_v( i- 1)+ num( 3)* x01_v( i- 2)+ num( 4)* 0 ... % ingresando condiciones iniciales y asumiendo entrada causal
                - den( 2)* y01_v( i- 1)- den( 3)* y01_v( i- 2);
                
            else                
    
            y01_v( i)= num( 1)* x01_v( i)+ num( 2)* x01_v( i- 1)+ num( 3)* x01_v( i- 2)+ num( 4)* x01_v( i- 3) ...  
                - den( 2)* y01_v( i- 1)- den( 3)* y01_v( i- 2);
            
            end
end

% c. verificacion con funcion impz
[ h01_v, n01_v]= impz( [ 7 -33/15 -29/15 2/5], [ 1 -13/15 2/15], 5);
[ h02_v, n02_v]= impz( [ 7 -33/15 -29/15 2/5], [ 1 -13/15 2/15], 20);
[ h03_v, n03_v]= impz( [ 7 -33/15 -29/15 2/5], [ 1 -13/15 2/15], 100);

fig01= figure;
subplot( 3, 1, 1); stem( n01_v, h01_v);
subplot( 3, 1, 2); stem( n02_v, h02_v, 'r');
subplot( 3, 1, 3); stem( n03_v, h03_v, 'g');

% De las graficas, se observa que la respuesta al impulso decrece en
% funcion a l numero de muestra. Sin embargo, al analizar sus valores en
% workspace, estos no llegan a 0, por lo que teoricamente la respuesta al
% impulso nunca acaba. De la evidencia, se puede decir que se trata de un
% sistema de respuesta al impulso de duracion infinita (IIR)

% d.

A= 4* rand( 1, 5);
phi= 2* pi* rand( 1, 5);
n_v= 0: 30;
alpha_mat= zeros( 5, 31);   % Memory allocation
alpha_mat( 1, :)= A( 1)* cos( pi/ 8* n_v+ phi( 1));
alpha_mat( 2, :)= A( 2)* cos( pi/ 8* n_v+ phi( 2));
alpha_mat( 3, :)= A( 3)* cos( pi/ 8* n_v+ phi( 3));
alpha_mat( 4, :)= A( 4)* cos( pi/ 8* n_v+ phi( 4));
alpha_mat( 5, :)= A( 5)* cos( pi/ 8* n_v+ phi( 5));

% --- descripcion grafica --- %
fig02= figure;
plot( n_v, alpha_mat);
legend( '\alpha_{1}[n]', '\alpha_{2}[n]', '\alpha_{3}[n]', '\alpha_{4}[n]', '\alpha_{5}[n]');
title( 'funciones sinusoidales con argumentos aleatorios');
xlabel( 'n'); ylabel( 'x[n]');


% e.

alpha_full_v= 10* alpha_mat( 1, :)+ 20* alpha_mat( 2, :)+ 30* alpha_mat( 3, :)+ 40* alpha_mat( 4, :)+ 50* alpha_mat( 5, :);
y_full_v= filter( num, den, alpha_full_v);

y_alt_v= 10* filter( num, den, alpha_mat( 1, :))+ 20* filter( num, den, alpha_mat( 2, :))+...
    30* filter( num, den, alpha_mat( 3, :))+ 40* filter( num, den, alpha_mat( 4, :))+ 50* filter( num, den, alpha_mat( 5, :));

y_error= norm( y_full_v- y_alt_v);

fig03= figure;
subplot( 2, 1, 1); stem( n_v, y_full_v);
title( 'Demostracion de sistema lineal');
xlabel( 'n'); ylabel( 'y_{full}[n]');
subplot( 2, 1, 2); stem( n_v, y_alt_v, 'r');
title( 'Demostracion de sistema lineal');
xlabel( 'n'); ylabel( 'y_{alt}[n]');

% Se trata de un sistema lineal, dado que se demuestra que cumple con la
% propiedad de superposici√≥n (es decir, las propiedades de aditividad y
% escalamiento.). Las graficas muestran que ambas respuestas son iguales.