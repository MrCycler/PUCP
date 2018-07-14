% IEE239: script 09 - Diseno de Filtros Digitales: Metodo de Enventanado
% El script muestra el diseno de un filtro pasabajos de respuesta al
% impulso finita (FIR) a partir de un filtro pasabajos ideal. La ventana
% usada es una rectangular de tamano M. La respuesta al impulso del filtro
% ideal es desfazada un valor arbitrario para incluir las componentes
% preponderantes en el filtro FIR por dise??ar.

close all; clear all;




% --- parametros de espacio de muestras --- %
N= 2048;                                                                    % tama??o del filtro IIR ideal (aproximaci??n de -infinito a +infinito)
M= 250;                                                                     % tama??o del filtro FIR (0 a M-1)
n_v= -round( N/ 2): round( N/2);                                            % vector de tiempo
w_0= pi/16;                                                                 % frecuencia de corte del pasabajos
offset= M/ 2;                                                               % desplazamiento en tiempo (preservar componentes predominantes en el filtro FIR)
% offset= 0;                                                               % desplazamiento en tiempo (preservar componentes predominantes en el filtro FIR)
% --- END parametros de espacio de muestras --- %




% --- rpta al impulso deseada y rpta al impulso por enventanado --- %
h01d= 1./(pi* n_v).* sin( w_0* n_v);                                        % filtro IIR ideal (aproximaci??n)
h01d( n_v== 0)= w_0./(pi);                                                  % L'Hospital
win01= n_v>= 0 & n_v<= M-1;                                                 % ventana rectangular
h01= 1./(pi* (n_v- offset)).* sin( w_0* (n_v- offset));                     % filtro IIR ideal (aproximaci??n)
h01( n_v== offset)= w_0./(pi);                                              % L'Hospital
h01= h01.* win01;                                                           % filtro FIR a partir del m??todo de enventanado
% --- END rpta al impulso deseada y rpta al impulso por enventanado --- %




% --- analisis en frecuencia --- %
H01d= fftshift( fft( h01d));                                                % respuesta en frecuencia del filtro IIR ideal
H01= fftshift( fft( h01));                                                  % respuesta en frecuencia del filtro FIR
n_size= size( n_v, 2);                                                     % vector de frecuencia
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;                                      % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);                                                   % puntos discretos en frecuencia (de -pi a pi)
% --- END analisis en frecuencia --- %




% --- descripcion grafica --- %
f01= figure;
subplot( 4, 1, 1); plot( n_v, h01d, 'r');
title('filtro IIR ideal (aproximaci??n)'); xlabel('\omega');
subplot( 4, 1, 3); plot( n_v, h01); title('filtro FIR');
subplot( 4, 1, 2); plot( w_v, abs( H01d), 'r');
title('esp. de mag. del filtro IIR ideal');  xlabel('\omega');
subplot( 4, 1, 4); plot( w_v, abs( H01));
title('esp. de mag. del filtro FIR');  xlabel('\omega');
% --- END descripcion grafica --- %



%%

% IEE239: script 09 - Diseno de Filtros Digitales: Metodo de Muestreo en
% Frecuencia
% el script muestra el dise??o de un filtro pasabajos de respuesta al
% impulso finita (FIR) a partir de la respuesta en frecuencia deseada. Se
% aprovecha la simetr??a de la respuesta, por lo que se requieren solo la
% mitad de muestras en frecuencia para el dise??o. Adicionalmente, las
% descripciones graficas muestran como a pesar que las muestras
% seleccionadas en frecuencia cumplen con el diseno, el resto de muestras
% por una alta variacion.

close all; clear all;




% --- parametros de dise??o --- %
M= 10;
N= ( M- 1)/ 2;
k= 0: N;
n= 0: M- 1;
alpha= 0;
w_k= 2* pi/ M* ( k+ alpha);
H01d= [1; 1; 1; 0; 0; 0];                                                   % respuesta deseada en frecuencia (ordenada de 0 a pi)
% --- END parametros de dise??o --- %




% --- simetria en frecuencia --- %
H01_conj= conj( H01d( end-1: -1: 2));                                       % simetr??a: H(k+\alpha)= H^{*}(M-k-\alpha)
H01_full= [ H01d; H01_conj];                                                % respuesta deseada completa (la mitad de elementos obtenidos por simetria)
% --- END simetria en frecuencia --- %




% --- diseno por muestreo en frecuencia --- %
h01= ifft( H01_full);                                                       % respuesta al impulso del filtro dise??ado
H01= fftshift(fft( h01));                                                   % verificaci??n: DFT del filtro dise??ado (debe ser igual a la respuesta deseada)
n_size= size( H01, 1);                                                      % vector de frecuencia
w_H01= 2*pi* ( 0: ( n_size- 1))/ n_size;                                    % puntos discretos en frecuencia (de 0 a 2pi)
w_H01= fftshift( w_H01);
w_H01= unwrap( w_H01 - 2*pi);                                               % puntos discretos en frecuencia (de -pi a pi)

H02= fftshift(fft( h01, M* 2));                                             % DFT del filtro dise??ado para mayor n??mero de muestras (2L)
n_size= size( H02, 1);                                                      % vector de frecuencia
w_H02= 2*pi* ( 0: ( n_size- 1))/ n_size;                                    % puntos discretos en frecuencia (de 0 a 2pi)
w_H02= fftshift( w_H02);
w_H02= unwrap( w_H02 - 2*pi);                                               % puntos discretos en frecuencia (de -pi a pi)

H03= fftshift(fft( h01, 1024));                                             % DFT del filtro dise??ado para mayor n??mero de muestras (1024)
n_size= size( H03, 1);                                                      % vector de frecuencia
w_H03= 2*pi* ( 0: ( n_size- 1))/ n_size;                                    % puntos discretos en frecuencia (de 0 a 2pi)
w_H03= fftshift( w_H03);
w_H03= unwrap( w_H03 - 2*pi);                                               % puntos discretos en frecuencia (de -pi a pi)
% --- END diseno por muestreo en frecuencia --- %




% --- descripcion grafica --- %
figure;
subplot( 3, 1, 1); stem( w_H01, abs( H01));
title( ['esp. de mag. del filtro dise??ado (N= ' num2str( size( H01, 1)) ')']); xlabel('\omega');
subplot( 3, 1, 2); stem( w_H02, abs( H02), 'k');
title( ['esp. de mag. del filtro dise??ado (N= ' num2str( size( H02, 1)) ')']); xlabel('\omega');
subplot( 3, 1, 3); stem( w_H03, abs( H03), 'r');
title( ['esp. de mag. del filtro dise??ado (N= ' num2str( size( H03, 1)) ')']); xlabel('\omega');
% --- END descripcion grafica --- %