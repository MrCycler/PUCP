% IEE239: Procesamiento de Senales e Imagenes Digitales
% Ejercicios propuestos 2 - 2017-1
close all; clear all;


%% Pregunta 1a

n_v= 0: 44100* 0.25- 1;  % espacio de muestras
Fs= 44100;  % frecuencia de muestreo

% --- generacion de senales DTMF de 0 a 9 --- %
dtmf_mat= zeros( 10, 44100* 0.25);  % matrix para almacenar tonos DTMF de 0.25 segundos a Fs de 44100 Hz
dtmf_mat( 1, :)= cos( 2* pi* 941/ Fs* n_v)+ cos( 2* pi* 1336/ Fs* n_v);  % tecla 0
dtmf_mat( 2, :)= cos( 2* pi* 697/ Fs* n_v)+ cos( 2* pi* 1209/ Fs* n_v);  % tecla 1
dtmf_mat( 3, :)= cos( 2* pi* 697/ Fs* n_v)+ cos( 2* pi* 1336/ Fs* n_v);  % tecla 2
dtmf_mat( 4, :)= cos( 2* pi* 697/ Fs* n_v)+ cos( 2* pi* 1477/ Fs* n_v);  % tecla 3
dtmf_mat( 5, :)= cos( 2* pi* 770/ Fs* n_v)+ cos( 2* pi* 1209/ Fs* n_v);  % tecla 4
dtmf_mat( 6, :)= cos( 2* pi* 770/ Fs* n_v)+ cos( 2* pi* 1336/ Fs* n_v);  % tecla 5
dtmf_mat( 7, :)= cos( 2* pi* 770/ Fs* n_v)+ cos( 2* pi* 1477/ Fs* n_v);  % tecla 6
dtmf_mat( 8, :)= cos( 2* pi* 852/ Fs* n_v)+ cos( 2* pi* 1209/ Fs* n_v);  % tecla 7
dtmf_mat( 9, :)= cos( 2* pi* 852/ Fs* n_v)+ cos( 2* pi* 1336/ Fs* n_v);  % tecla 8
dtmf_mat( 10, :)= cos( 2* pi* 852/ Fs* n_v)+ cos( 2* pi* 1477/ Fs* n_v);  % tecla 9


% --- leer secuencia --- %
prompt= 'Ingresar numero de 7 digitos:';
seq_str= input( prompt, 's');    % ingresar n?mero

seq= zeros( 1, 7);  % vector vacio donde se almacenaran los digitos ingresados
for i= 1: 7
    seq( i)= str2double( seq_str( i));  % convertir cada digito en char a double y almacenar
end

if length( seq)~= 7 % verificar que son 7 digitos
    error( 'Error: el numero debe contener 7 digitos con valores entre 0 y 9.');
elseif sum( seq== abs(round( seq)))~= 7 % verificar que son enteros entre 0 y 9
    error( 'Error: los d?gitos deben ser valores enteros entre 0 y 9.')
end

disp( [ 'Secuencia ingresada: ' num2str( seq)]);


% -- crear secuencia de tonos DTMF y reproducir --- %
dtmf_v= zeros( 1, Fs* 0.25* 7);  % vector vacio para 7 digitos DTMF
for i= 1: 7
    dtmf_v( Fs* 0.25*( i- 1)+ 1: Fs* 0.25*( i))= dtmf_mat( seq( i)+1, :);   % ingresar 0.25 segundos de cada digito de la secuencia leida en el vector final
end

player= audioplayer( dtmf_v, Fs);   % el reproductor genera la se?al anal?gica con la informaci?n de la frecuencia de muestreo almacenada en Fs
play( player);  % reproducir tonos DTMF


%% Pregunta 1b

% --- leer tonos DTMF --- %   Pregunta 1c
[ x01_v, Fs]= audioread( './dtmf01.wav');
player= audioplayer( x01_v, Fs);   % el reproductor genera la se?al anal?gica con la informaci?n de la frecuencia de muestreo almacenada en Fs
play( player);  % reproducir tonos DTMF


% % --- leer tonos DTMF y agregar ruido --- %   Pregunta 1c
% [ x01_v, Fs]= audioread( './dtmf01.wav');
% x01_v= x01_v+ 3* randn( size( x01_v)); % incluir ruido aditivo de distribucion normal con media 0 y desviacion estandar de 0.1 
% player= audioplayer( x01_v, Fs);   % el reproductor genera la se?al anal?gica con la informaci?n de la frecuencia de muestreo almacenada en Fs
% play( player);  % reproducir tonos DTMF


% % --- usar tonos DTMF creados en el inciso a --- %    Pregunta 1d
% x01_v= dtmf_v;

% --- separar tonos del audio original --- %
dtmf_read_mat= zeros( 7, Fs* 0.25);  % matriz libre para separar 7 digitos DTMF
for i= 1: 7
    dtmf_read_mat( i, :)= x01_v( Fs* 0.25*( i- 1)+ 1: Fs* 0.25*( i));   % ingresar 0.25 segundos de la secuencia leida en el vector final
end


% --- Mostrar el espectro de frecuencia de cada segmento de 0.25 s --- %
fig_spectrum= figure;
subplot( 4, 2, 1);
dtmf_spectrum( dtmf_read_mat( 1, :), Fs); title( 'Primer tono DTMF');   % analisis del espectro de frecuencia de cada segmento de 0.5 s
subplot( 4, 2, 2);
dtmf_spectrum( dtmf_read_mat( 2, :), Fs); title( 'Segundo tono DTMF');
subplot( 4, 2, 3);
dtmf_spectrum( dtmf_read_mat( 3, :), Fs); title( 'Tercer tono DTMF');
subplot( 4, 2, 4);
dtmf_spectrum( dtmf_read_mat( 4, :), Fs); title( 'Cuarto tono DTMF');
subplot( 4, 2, 5);
dtmf_spectrum( dtmf_read_mat( 5, :), Fs); title( 'Quinto tono DTMF');
subplot( 4, 2, 6);
dtmf_spectrum( dtmf_read_mat( 6, :), Fs); title( 'Sexto tono DTMF');
subplot( 4, 2, 7);
dtmf_spectrum( dtmf_read_mat( 7, :), Fs); title( 'Septimo tono DTMF');


% --- sistema para determinar tonos DTMF (banco de filtros) --- %
filter_length= 8192;    % duracion de cada sistema de analisis de tonos (sistemas LTI FIR)
h_697_v= fir1( filter_length, [ 677/( Fs/ 2) 717/( Fs/ 2)]); % sistema para detectar tono de 697 Hz: filtro cuyo espectro solo preserva componentes entre 677 y 717 Hz
h_770_v= fir1( filter_length, [ 750/( Fs/ 2) 790/( Fs/ 2)]); % mismo criterio para el resto de sistemas...
h_852_v= fir1( filter_length, [ 832/( Fs/ 2) 872/( Fs/ 2)]);
h_941_v= fir1( filter_length, [ 921/( Fs/ 2) 961/( Fs/ 2)]);
h_1209_v= fir1( filter_length, [ 1189/( Fs/ 2) 1229/( Fs/ 2)]);
h_1336_v= fir1( filter_length, [ 1316/( Fs/ 2) 1356/( Fs/ 2)]);
h_1477_v= fir1( filter_length, [ 1457/( Fs/ 2) 1497/( Fs/ 2)]);

fig_dtmf_spectrum= figure;
subplot( 4, 2, 1);
dtmf_spectrum( h_697_v, Fs); title( 'Espectro de sistema para 697 Hz.'); % analisis del espectro de frecuencia de cada segmento de 0.5 s...
subplot( 4, 2, 2);
dtmf_spectrum( h_770_v, Fs); title( 'Espectro de sistema para 770 Hz.');
subplot( 4, 2, 3);
dtmf_spectrum( h_852_v, Fs); title( 'Espectro de sistema para 852 Hz.');
subplot( 4, 2, 4);
dtmf_spectrum( h_941_v, Fs); title( 'Espectro de sistema para 941 Hz.');
subplot( 4, 2, 5);
dtmf_spectrum( h_1209_v, Fs); title( 'Espectro de sistema para 1209 Hz.');
subplot( 4, 2, 6);
dtmf_spectrum( h_1336_v, Fs); title( 'Espectro de sistema para 1336 Hz.');
subplot( 4, 2, 7);
dtmf_spectrum( h_1477_v, Fs); title( 'Espectro de sistema para 1477 Hz.');


% --- respuesta del sistema ante cada segmento DTMF de entrada --- %

tone_read= zeros( 1, 7);   % vector para listar los tonos detectados
for i= 1: 7
    % --- determinar salida a partir de convolucion con cada filtro del sistema --- %
    y_697_v= conv( dtmf_read_mat( i, :), h_697_v);
    y_770_v= conv( dtmf_read_mat( i, :), h_770_v);
    y_852_v= conv( dtmf_read_mat( i, :), h_852_v);
    y_941_v= conv( dtmf_read_mat( i, :), h_941_v);
    y_1209_v= conv( dtmf_read_mat( i, :), h_1209_v);
    y_1336_v= conv( dtmf_read_mat( i, :), h_1336_v);
    y_1477_v= conv( dtmf_read_mat( i, :), h_1477_v);
    
    % --- calcular energia de cada respuesta --- %
    e_697= sum( y_697_v.^2);    % mayor energia preservada por el filtro implica que el segmento incluia un tono en dicha frecuencia. Ausencia de energia implica lo contrario.
    e_770= sum( y_770_v.^2);    % valor absoluto obviado ya que se sabe que las muestras son reales.
    e_852= sum( y_852_v.^2);
    e_941= sum( y_941_v.^2);
    e_1209= sum( y_1209_v.^2);
    e_1336= sum( y_1336_v.^2);
    e_1477= sum( y_1477_v.^2);
    
    % --- determinar respuestas de mayor energia para identificar tono DTMF --- %
    [ ~, maxindex01]= max( [e_697 e_770 e_852 e_941]);
    [ ~, maxindex02]= max( [e_1209 e_1336 e_1477]);
    
    % --- analizar alternativas e identificar tono --- %
    if maxindex01== 1 & maxindex02== 1
        tone_read( i)= 1;
    elseif maxindex01== 1 & maxindex02== 2
        tone_read( i)= 2;
    elseif maxindex01== 1 & maxindex02== 3
        tone_read( i)= 3;
    elseif maxindex01== 2 & maxindex02== 1
        tone_read( i)= 4;
    elseif maxindex01== 2 & maxindex02== 2
        tone_read( i)= 5;
    elseif maxindex01== 2 & maxindex02== 3
        tone_read( i)= 6;
    elseif maxindex01== 3 & maxindex02== 1
        tone_read( i)= 7;
    elseif maxindex01== 3 & maxindex02== 2
        tone_read( i)= 8;
    elseif maxindex01== 3 & maxindex02== 3
        tone_read( i)= 9;
    else
        tone_read( i)= 0;
    end
end


% --- mostrar espectro de frecuencia de las respuestas a cada filtro para el ultimo digito --- %
fig_dig_spectrum= figure;
subplot( 4, 2, 1);
dtmf_spectrum( y_697_v, Fs); title( 'Espectro de respuesta para 697 Hz.');
subplot( 4, 2, 2);
dtmf_spectrum( y_770_v, Fs); title( 'Espectro de respuesta para 770 Hz.');
subplot( 4, 2, 3);
dtmf_spectrum( y_852_v, Fs); title( 'Espectro de respuesta para 852 Hz.');
subplot( 4, 2, 4);
dtmf_spectrum( y_941_v, Fs); title( 'Espectro de respuesta para 941 Hz.');
subplot( 4, 2, 5);
dtmf_spectrum( y_1209_v, Fs); title( 'Espectro de respuesta para 1209 Hz.');
subplot( 4, 2, 6);
dtmf_spectrum( y_1336_v, Fs); title( 'Espectro de respuesta para 1336 Hz.');
subplot( 4, 2, 7);
dtmf_spectrum( y_1477_v, Fs); title( 'Espectro de respuesta para 1477 Hz.');


% --- mostrar espectro de frecuencia de las respuestas a cada filtro para el ultimo digito --- %
fig_energy= figure;
subplot( 4, 2, 1); plot( y_697_v); title( [ 'rpta ante sistema que preserva tonos de 697 Hz. Energia: ' num2str( e_697)]);
subplot( 4, 2, 2); plot( y_770_v); title( [ 'rpta ante sistema que preserva tonos de 770 Hz. Energia: ' num2str( e_770)]);
subplot( 4, 2, 3); plot( y_852_v); title( [ 'rpta ante sistema que preserva tonos de 852 Hz. Energia: ' num2str( e_852)]);
subplot( 4, 2, 4); plot( y_941_v); title( [ 'rpta ante sistema que preserva tonos de 941 Hz. Energia: ' num2str( e_941)]);
subplot( 4, 2, 5); plot( y_1209_v); title( [ 'rpta ante sistema que preserva tonos de 1209 Hz. Energia: ' num2str( e_1209)]);
subplot( 4, 2, 6); plot( y_1336_v); title( [ 'rpta ante sistema que preserva tonos de 1336 Hz. Energia: ' num2str( e_1336)]);
subplot( 4, 2, 7); plot( y_1477_v); title( [ 'rpta ante sistema que preserva tonos de 1477 Hz. Energia: ' num2str( e_1477)]);

% --- imprimir secuencia hallada --- %
disp( [ 'Secuencia de tonos DTMF corresponde a: ' num2str( tone_read)]);


%% Pregunta 2: DFT
time=2.2;
freqs=120;
n=0:time*freqs-1;
x_1=((0.2).^n).*(n<11);
x_2=((0.5).^n).*(n<21);
%a
figure;
subplot(2,1,1);stem(x_1);
subplot(2,1,2);stem(x_2);
title('Descripcion grafica de las se??ales')
xlabel('Espacio de muestras')
ylabel('Amplitud')

n_size= 2048;
X_1= fftshift( fft( x_1, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);  

X_2= fftshift( fft( x_2, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);  

figure;
subplot( 2, 1, 1); plot( w_v, abs( X_1));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X_1[\omega]');
subplot( 2, 1, 2); plot( w_v, abs( X_2));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X_2[\omega]');

%b 
x_3=x_1+x_2;

X_3= fftshift( fft( x_3, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);

figure;
stem(x_3);
title('Descripcion grafica de X_3')
xlabel('Espacio de muestras')
ylabel('Amplitud')

figure;
plot( w_v, abs( X_3));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X_3[\omega]');

%c
res=norm(X_2+X_1-X_3); % Se suma el espectro de X_e2 y X_1 y luego se resta 
                       % con el espectro de X_3, a fin de evaluar cuando 
                       % difieren entre si las se??ales. el resultado esta 
                       % por el orden de 1e-14, dicho valor se puede tomar 
                       % como cero y con ello comprobar la propiedad de
                       % linealidad.
%d

% Dado que se tiene una frecuencia de muestreo de 100 Hz, un segundo
% es representado con 100 muestras y medio segundo con 50.


x_3def=[zeros(1,50) x_3(1:end-50)];
X_3def= fftshift( fft( x_3def, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ n_size;  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);  


figure;
stem(x_3def);
title('Descripcion grafica de X_3')
xlabel('Espacio de muestras')
ylabel('Amplitud')

figure;
plot( w_v, abs( X_3def));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X_3def[\omega]','X_3[\omega]');


re=norm(X_3def-X_3);
% Solo analizando con la norma se puede apreciar que existe una diferencia
% entre ambos resultados. esto se da, ya que al producirse un desfase en
% tiempo en frecuencia se da una modulacion de la se??al siguiendo la
% relacion:

% x[n-k]=X(e^iw)e^(-iwk)
% Esto se puede apreciar mejor visualizando la parte real de ambas se??ales.

figure;
plot( w_v, real( X_3def));
hold all
plot( w_v, real( X_3));
grid on; ylabel( 'amplitud'); xlabel( 'frecuencia (\omega)'); axis tight;
legend( 'X_3def[\omega]','X_3[\omega]');


%% Pregunta 3
% Lectura del archivo
% a)
[y,Fs] = audioread('handel.wav');
% Se toma una porci?n del audio.
y = y(1:(2^(nextpow2(length(y))-1)));
% Se reproduce el archivo
% sound(y,Fs)
% Se define el orden del filtro
Norder = 64;
% El comando fir1 devuelve coeficientes considerando el orden del filtro y
% la frecuencia de corte. En este caso, se toma un orden igual a 64 y una
% frecuencia de corte de 0.5 pi.
gn = fir1(Norder,0.5);

% Etapa 1:
% Salida de la se?al convolucionada con el filtro para hallar las bajas
% frecuencias
lowfilter  = conv(y,gn,'same');
% Operaci?n matem?tica para hallar la para hallar las altas frecuencias en
% funci?n a la se?al y al filtro pasabajos.
highfilter = y - lowfilter;
% Downsampleo de ambas se?ales.
lowfilter = downsample(lowfilter,2);
highfilter = downsample(highfilter,2);
% Se?al resultante
sound(highfilter,Fs/2);

% Etapa 2:
lowfilter2 = conv(lowfilter,gn,'same');
highfilter2 = lowfilter - lowfilter2;

lowfilter2 = downsample(lowfilter2,2);
highfilter2 = downsample(highfilter2,2);

sound(highfilter2,Fs/4);

% Etapa 3:
lowfilter3 = conv(lowfilter2,gn,'same');
highfilter3 = lowfilter2 - lowfilter3;

lowfilter3 = downsample(lowfilter3,2);
highfilter3 = downsample(highfilter3,2);

sound(highfilter3,Fs/8);
%