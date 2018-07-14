% IEE239: ejercicios propuestos 05 2018-1
% Umbralizacion de intensidad para histogramas bimodales
% La subrutina determina de manera iterativa el valor umbral que separa a
% dos conjuntos bien diferenciados en el histograma de una imagen. El
% metodo consiste en calcular las medias de ambas distribuciones y
% establecer el umbral en cada iteracion como su semisuma. El proceso se
% detiene cuando el umbral converge a un valor fijo, dado un factor de
% tolerancia.
% 
% Argumentos de entrada
% i01: imagen en escala de grises a umbralizar. Se consideran de precision
% float double con valores en el intervalo {0, 1, ..., 255}.
% t_0: umbral inicial
% iter_max: limite de iteraciones
% 
% Argumentos de salida
% i01_th: image umbralizada
% t: umbral optimo

function [ i01_th, t]= func_bihist( i01, t_0, tol, iter_max)

bins= 0:255;    % bins del histograma
h01_v= hist(i01( :), bins); % histograma

t= t_0; % umbral actual
wh_var= 1;  % variable auxiliar (do-while)
iter= 1;    % iteracion actual

while wh_var== 1
            s01= sum( h01_v(1: t+ 1));  % elementos de la clase 1
            s02= sum( h01_v(t+ 1: end));    % elementos de la clase 2
            if s01~= 0
                        p1= sum( h01_v(1: t+ 1).* (0: t))/ s01; % media de la clase 1
            else
                        p1= 0;  % asumir media de clase 1 como 0 en caso este vacia (evitar division entre 0)
            end
            if s02~= 0
                        p2= sum( h01_v(t+ 1: end).* (t: 255))/ s02; % media de la clase 2
            else
                        p2= 0;    % asumir media de clase 2 como 0 en caso este vacia (evitar division entre 0)
            end
            t_est= round( (p1+ p2)/ 2); % umbral estimado
            
            if ( abs( t- t_est)< tol) || iter== iter_max % verificar si el umbral converge a un valor fijo o si se alcanza el maximo de iteraciones
                        wh_var= 0; % fin del proceso iterativo
            else
                        t= t_est;   % reemplazar umbral
                        iter= iter+ 1;  % ejecutar una nueva iteracion
            end
end

i01_th= i01> t; % imagen umbralizada