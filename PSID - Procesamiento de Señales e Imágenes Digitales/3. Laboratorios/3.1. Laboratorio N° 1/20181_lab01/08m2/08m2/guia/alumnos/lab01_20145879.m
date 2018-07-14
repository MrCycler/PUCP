%%
% Guía: 1
% Autor: Pablo Díaz V.
% Ciclo: 2018-1
% Curso: PSID
%%
% Limpiamos datos o ventanas abiertas
clear all;
close all;
clc;

%% Problema 1
%%
% 1.a


% y[n]=5*(x[n-1]-x[n-2]+0.3*u[n])
y_n=zeros(1,3);
y_n(1)=1.5;
y_n(2)=5;
y_n(3)=-5;

%%
% 1.b

% H(z)=5*(z^(-1)-z^(-2)+0.3*1) ; para n>=0
% H(z)=0                       ; para otro valor de n
% Hallamos las raices
raices=roots([1.5 5 -5]);
r1=raices(1);
r2=raices(2);
% h[n]= -4.1384^n*u[n]+0.8054^n*u[-n-1]
% y[n]=1.5*u[n]-5*x[n-1]+5*x[n-2]

%%
% 1.c
[z,p]=tf2zpk(r1,r2);
zplane(r1,r2);
title('Grafica de polos y ceros en el plano complejo');

% Caracterizacion del sistema

% FIR O IIR?
% tiene un cero fuera del circulo unitario

% BIBOestable o no?
% Es BIBOestable ya que sus polos están dentro
% del circulo unitario

% Causal, Bilateral o anticausal?

% Es causal ya que solo depende de muestras pasadas
%%
% 1.d






%% Problema 2
%%
% 2.a

G_z=zeros(1,12); % Inicializamos
j=1;
for i=0.9:0.1:2
   G_z(j)=sistema_preg2(i); % Evaluamos en todos los indices
   j=j+1;
   
end
% Identificar el cero del sistema
   % El cero del sistema se encuentra en n=1;
   G_z(1+1);%Matlab empieza los indices desde 1
%%
% 2.b

G_z2=zeros(1,21);
j=1;
for i=-1:0.1:1
   G_z2(j) =sistema_preg2(i);
   j=j+1;
   
  
end
% El polo del sistema se encuentra en:
 G_z2(11);
%%
% 2.c

punto_conveniente=sistema_preg2(1);

%K=(1-bz^+1) y az^-1=1

%%
% 2.d
%%
% 2.e
n=0:0.1:3;
x_c=exp(j*2*pi*sqrt(8)*0.1.*n)+exp(j*8*pi*0.1.*n);

% ¿ Es x(t) periodica ?

% Al pasar la ec. a su forma polar podemos
% ver que la ec. depende de ecuaciones tanto
% de cosenos como senos por lo que 
% para un tiempo t=2*pi*t0 se verá el mismo
% resultado que el visto en t0

% ¿ Es x[t] periódica ?

for m=1:32-1
    
end



%% Problema 3
%%
% 3.a

n=0:9; % Inicializamos n
delta_n=zeros(1,length(n));
delta_n2=zeros(1,length(n));
% como para n=0 delta=1 en delta_n
delta_n(1)=1;
% y para n=1 delta=1 en delta_n2
delta_n2(2)=1;
% Ahora calculamos los impulsos
impulso_n=preg3_sist1(n);
impulso_n2=preg3_sist2(n);
% Guardo las variables proque las usaré 
% en el cal. euclidiano
n1_1=impulso_n;
n2_1=impulso_n2;
% delta_n con impulso_n no son necesariamente
% correspondientes


figure
subplot(2,2,1)

plot(n,impulso_n,'o');xlabel('n1');ylabel('h[n1]');
title('Sin retardo');
grid on;
subplot(2,2,3)

plot(n,impulso_n2,'+');xlabel('n2');ylabel('h[n2]');
grid on;

% Además generamos el retardo
delta_n=zeros(1,length(n));
delta_n2=zeros(1,length(n));
delta_n(2)=1;
delta_n2(3)=1;
% retardo también para las f. de trans
impulso_n(n<11)=preg3_sist1(n+1);
impulso_n2(n<12)=preg3_sist2(n+1);
% Guardo las variables proque las usaré 
% en el cal. euclidiano
n1_2=impulso_n;
n2_2=impulso_n2;


subplot(2,2,2)
plot(n,impulso_n,'o');xlabel('n1');ylabel('h[n1]');
title('Con retardo');
grid on;
subplot(2,2,4)
plot(n,impulso_n2,'+');xlabel('n2');ylabel('h[n2]');

grid on;
axis tight;

% ¿ Qué sistema puede ser invariante en el tiempo?

% El primer sistema no puede ser invariante en 
% el tiempo ya que el primero presenta
% un valor distinto con respecto
% al que se esperaría de un sistema shift-invariant

%%
% 3.b

% Caso T 1
dist_eucli_n1_1=norm(n1_1,2);
dist_eucli_n1_2=norm(n1_2,2);

% Como las dis. son diferentes entonces
% no es un sistema invariante en el tiempo

% Caso T 2
dist_eucli_n2_1=norm(n2_2,2);
dist_eucli_n2_2=norm(n2_2,2);

% Como son iguales el sistema es invariante
% en el tiempo

%%
% 3.c

% Asumiendo que es FIR

%h[n]=