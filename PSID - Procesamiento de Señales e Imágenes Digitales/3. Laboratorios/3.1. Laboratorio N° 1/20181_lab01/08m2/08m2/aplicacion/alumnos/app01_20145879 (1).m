%%
% App: 1
% Autor: Pablo Díaz V.
% Ciclo: 2018-1
% Curso: PSID

%% Problema 1
%%
% 1.a

% Sabemos que:
% y[n]-2*y[n-1]=0.5*x[n]-0.6*x[n-1]
% v[n]=0.5*x[n]-0.6*x[n-1]
% Donde:
% y[n] : el calor suministrado
% v[n] : voltaje al calentador

% Hallamos la f. de transf entre x[n] y v[n]

% H(z)=>v(z)/x(z)=>0.5/(-0.6*z^-1)=>-0.8333*1/z^-1


% Hallamos ec. de diferencias 

% H(z)=>y(z)/v(z)

% entonces la ec. de diferencias es:

% y[n]-2*y[n-1]=0.5*x[n]-0.6*x[n-1]

%% 1.b

n=0:19; % inicializamos n
escalon_u=ones(1,[length(n)]);
impulso_u=zeros(1,[length(n)]);
impulso_u(1)=1;
% Vemos la respuesta del sistema a los
% impulsos

x_v=zeros(1,length(n));
x_v(1)=0.5;
x_v(2)=-0.6;
x_v_retrasado=zeros(1,length(n));
x_v_retrasado(1)=0.5;
x_v_retrasado(2)=-0.6;
y_v=zeros(1,length(n));
y_v_retrasado=zeros(1,length(n));

y_v=2.*y_v_retrasado+0.5.*x_v-0.6.*x_v_retrasado;


for i=1:20
    % 
end
figure
subplot(2,1,1)
plot(n,y_v.*escalon_u,'x');
title('Respuesta a escalon_unitario')
subplot(2,1,2)
plot(n,y_v.*impulso_u,'+');
title('Respuesta a impulso_unitario')

% ¿Es BIBOestable?

% Sí es un sistema BIBOestable ya que
% los coef. son menores a 1, por lo
% que en la sumatoria terminan en
% sum. geo.

% ¿Duración de h[n]?

% La duración de h[n] solo depende de los coef.
% que posee en los términos de z^-n
% por lo que tendría una duración de 2 estados
% discretos 

% ¿Podría ser un sistema FIR?

% Debido a la ec. de diferencias y al gráfico
% el sistema sería un sistema finito ya que
% solo responde a un rango de valores 
% iniciales de n
%% 1.c

[z,p]=tf2zpk();
% ¿El sistema es FIR o IIR?

% El sistema es FIR ya que sus polos se 
% encuentran dentro del circulo unitario


% ¿El sistema es BIBOestable?

% No es BIBOestable porque está fuera del 
% circulo unitario

%  Causalidad

% Tiene causalidad ya que según la ec.de 
% diferencias, depende de muestras pasadas
% unicamente
%% 1.d
% g[n]=x[n]+ax[n-1]




%% 1.e

resul_esc=conv(escalon_u,y_v);
resul_imp=conv(impulso_u,y_v);

figure
subplot(2,1,1)
plot(n,resul_esc(1:20),'x');
title('Respuesta a escalon_unitario')
subplot(2,1,2)
plot(n,resul_imp(1:20),'+');
title('Respuesta a impulso_unitario')


% BIBOestabilidad