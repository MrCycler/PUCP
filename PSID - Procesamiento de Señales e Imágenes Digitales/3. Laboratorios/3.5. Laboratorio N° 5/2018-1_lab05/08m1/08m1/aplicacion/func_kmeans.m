function [ S, m] = func_kmeans( K, iter, D)

%  [ S, m] = func_kmeans( K, iter, D) particiona los datos contenidos en
%  DATA en K clases mediante el metodo de k-medias. Las variables de
%  entrada y salida de la funcion son :
%  
%  Entradas =>  K:      Numero de clases deseadas.
%
%               ITER:   Numero maximo de iteraciones del algoritmo k-medias.
%
%               D:      Imagen RGB en formato columna. Debe tener dimension
%                       Nx3, donde N es el numero de elementos de la imagen
%                       RGB. La intensidad de cada capa debe estar entre 0
%                       y 1.
%
%  Salidas =>   S:      Vector columna que indica a que grupo o cluster pertenece
%                       cada elemento de D.
%
%               M:      Medias de cada uno de las clases obtenidas.

N = size(D,1);    % numero de elementos de la imagen
S = zeros( N, 1);  % reserva de espacio para indices de correspondencia
m = rand( K, 3); % medias iniciales (distribucion uniforme)

for i = 1: iter
            for j= 1: K
                        % /// calcular distancia euclidiana entre cada elemento de D y las medias actuales m /// %
            end
            
            % /// actualizar la correspondencia de cada elemento a las medias actuales /// %
            
            for j= 1: K
                        % /// actualizar los valores de las medias para la iteracion actual /// %
            end
end