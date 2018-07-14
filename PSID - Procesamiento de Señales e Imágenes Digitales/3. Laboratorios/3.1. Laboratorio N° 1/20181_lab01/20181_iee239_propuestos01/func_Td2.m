% Sistema recursivo T_{d2}. La rutina recibe la secuencia de entrada 'x_v'
% y el valor de la secuencia de salida 'y_v(-1)' (condiciones iniciales del
% sistema). A partir de ello, la rutina genera la secuencia de salida 'y_v'
% para el mismo dominio de la secuencia de entrada.

function y_v= func_Td2( x_v, r)

y_v= zeros( size( x_v));

for i= 1: length( x_v)
            if i== 1
                        y_v( i)= x_v( i)+ r;
            elseif i== 2
                        y_v( i)= x_v( i)- 3* x_v( i- 1)+ y_v( i- 1);
            elseif i== 3
                        y_v( i)= x_v( i)- 3* x_v( i- 1)+ 3* x_v( i- 2)+ y_v( i- 1);
            else
                        y_v( i)= x_v( i)- 3* x_v( i- 1)+ 3* x_v( i- 2)- x_v( i- 3)+ y_v( i- 1);
            end
end