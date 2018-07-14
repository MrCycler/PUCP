
function [Umbral] = unimodal(Im)

% La funcion pregunta 3 segmenta la imagen de entrada en regiones con baja/alta varianza local

% Parametros de entrada: Im: varianza_locales calculas en la pregunta 1

% Parametros de salida: distancia_euclidiana (contiene la matriz de distancias euclidianas)


[yh,xh] = hist(Im(:),255);

% Se calcula el maximo punto de histograma
[y1,x1] = max(yh);

% Se halla el ultimo punto de histograma
[y2,x2] = find(yh >= 0 , 1 , 'last');

xh1 = xh(x1);
xh2 = xh(x2);

punto1 = [xh1, y1];
punto2 = [xh2, y2];

x = xh(x1:x2);
y = yh(x1:x2);
punto_h = [x;y]';

d = zeros(length(x),1);

% Se calcula las distancia entre recta y los puntos del histograma
for i=1:length(x)
       d(i)=abs(det([punto_h(i,:)-punto1;punto2-punto1]))/norm(punto2-punto1); 
end


% Se halla el umbral (maxima distancia entra un punto de histogrma y la recta)
[dmax,imax] = max(d);

Umbral = imax;

