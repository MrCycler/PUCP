% IEE239: script 08 - Diseno de filtros IIR por invarianza del impulso

% El script describe graficamente la transformada de Fourier en tiempo
% continuo del filtro analogico de interes. Para ello, se grafica H(s) para
% s igual a j\Omega. Luego, se describe graficamente la transformada de
% Fourier en tiempo discreto de la version digital obtenida a partir del
% metodo de invarianza del impulso. Para ello, se grafica H(z) para z igual
% a e^{j\omega}. Se demuestra que, dado que un filtro analogico fisicamente
% realizable no es limitado en banda, muestrear el filtro continuo
% necesariamente genera aliasing.

close all; clear all;

Omega_v= -8* pi: 0.1: 8* pi;  % dominio en frecuencia angular (aproximacion de dominio continuo)
H01= ( 1i* Omega_v+ 0.1)./ ( (1i* Omega_v+ 0.1).^2+ 9); % funcion de transferencia de filtro en tiempo continuo (analogico)

T= 0.5;
w_v= -8* pi* T: 0.1: 8* pi* T; % dominio en frecuencia normalizada (aproximacion de dominio continuo)
H02= T* (1 -exp(-0.1* T)*cos(3*T)* exp(-1i* w_v))./ ( 1 -2*exp(-0.1* T)*cos(3* T)* exp(-1i* w_v)+ exp(-0.2* T)* exp(-2i* w_v)); % funcion de transferencia de filtro en tiempo discreto

fig01= figure;
subplot( 3, 1, 1); figure( fig01); plot( Omega_v, 20* log10( abs( H01)));
title( 'Funcion de Transferencia del filtro en tiempo continuo H(j\Omega)'); xlabel( '\Omega'); ylabel( 'Amplitud (dB)');
subplot( 3, 1, 2); plot( w_v, 20* log10( abs( H02)), 'r');
title( 'Funcion de Transferencia del filtro en tiempo discreto H(e^{j\omega})'); xlabel( '\omega'); ylabel( 'Amplitud (dB)');

%%

% IEE239: script 08 - Diseno de filtros IIR por transformacion bilineal

% El script describe graficamente la transformada de Fourier en tiempo
% continuo del filtro analogico de interes. Para ello, se grafica H(s) para
% s igual a j\Omega. Luego, se describe graficamente la transformada de
% Fourier en tiempo discreto de la version digital obtenida a partir del
% metodo de transformacion bilineal. Para ello, se grafica H(z) para z
% igual a e^{j\omega}. Se demuestra que, dada la relacion no lineal entre
% frecuencia angular y frecuencia normalizada de la transformacion
% bilineal, el filtro discreto es libre de aliasing

close all; clear all;

T= 1;
w_c= 0.2* pi;
Omega_c= 2/ T* tan( w_c/ 2);
Omega_v= -16* pi: 0.001: 16* pi;  % dominio en frecuencia angular (aproximacion de dominio continuo)
H01= Omega_c./ (1i* Omega_v+ Omega_c);

w_v= -4* pi: 0.001: 4* pi; % dominio en frecuencia normalizada (aproximacion de dominio continuo)
H02= ( tan(w_c/2)* (1+ exp(-1i* w_v)))./( ( 1+ tan(w_c/2))+ ( tan(w_c/2)-1)* exp( -1i*w_v));

fig02= figure;
subplot( 2, 1, 1); plot( Omega_v, ( 20* log10(abs( H01))));
title( 'Funcion de Transferencia del filtro en tiempo continuo H(j\Omega)'); xlabel( '\Omega'); ylabel( 'Amplitud (dB)');
subplot( 2, 1, 2); plot( w_v, ( 20* log10( abs( H02))), 'r');
title( 'Funcion de Transferencia del filtro en tiempo discreto H(e^{j\omega})'); xlabel( '\omega'); ylabel( 'Amplitud (dB)');

