% IEE239: Procesamiento de senales y imagenes digitales
% Ejercicios propuestos 2 - Semestre 2016-2

%% --- Pregunta 1 --- %

% x = cos(2*pi*f*t)

ti = 0; tf = 2; f = 100;

%% a. Discretizacion de x

%   i. 4000 muestras --> fs1 = 2KHz > 2*f (Cumple Nyquist)

    fs0 = 2000;
    n0 = 0:(tf-ti)/3999:(4000*tf-1)/3999;
    x0 = cos(2*pi*f*n0);

%   ii. fs2 = 1KHz > 2*f (Cumple Nyquist) --> 2000 muestras

    fs1 = 1000;
    n1 = 0:(tf-ti)/1999:(2000*tf-1)/1999;
    x1 = cos(2*pi*f*n1);

%   iii. Muestras espaciadas 10 ms --> fs = 100 Hz < 2*f (No cumple
%   Nyquist)

% Solo se pueden digitalizar los casos i. y ii.

    figure(1);
    subplot(2,1,1); stem(n0, x0, 'r'); legend('x_{0}[n]');
    ylabel('x0'); xlabel('t');
    subplot(2,1,2); stem(n1, x1, 'b'); legend('x_{1}[n]');
    ylabel('x1'); xlabel('t');

%% b. Grafica de espectros de magnitud

    Xjw0 = abs(fftshift(fft(x0)));  % Espectro de magnitud de x0
    w0 = unwrap(fftshift(2*pi*(0:length(x0)-1)/(length(x0))) - 2*pi);

    Xjw1 = abs(fftshift(fft(x1)));  % Espectro de magnitud de x1
    w1 = unwrap(fftshift(2*pi*(0:length(x1)-1)/(length(x1))) - 2*pi);

    % Grafica los espectros de magnitud respecto a frecuencia normalizada

    figure(2);
    subplot(2,1,1); stem(w0, Xjw0); legend('X_{0}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');
    subplot(2,1,2); stem(w1, Xjw1); legend('X_{1}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');

%% c. Cambio de tasa (x 4/5)

    i = 4; j = 5;

%   i. Cambio de tasa: Interp 4, Decimate 5

%   Senal x0

    xa0_id = interp(x0, i);         % Primero interpolacion
    y0_id = decimate(xa0_id, j);    % Luego decimacion

    Yjw0_id = abs(fftshift(fft(y0_id))); % Espectro de magnitud

    n0_id = decimate(interp(n0, i), j);  % Espacio de muestras y frecuencia
    w0_id = decimate(interp(w0, i), j);  % adecuados

%   Senal x1

    xa1_id = interp(x1, i);         % Primero interpolacion
    y1_id = decimate(xa1_id, j);    % Luego decimacion

    Yjw1_id = abs(fftshift(fft(y1_id))); % Espectro de magnitud

    n1_id = decimate(interp(n1, i), j);  % Espacio de muestras y frecuencia
    w1_id = decimate(interp(w1, i), j);  % adecuados

%   Grafico de las senales de salida del sistema

    figure(3);
    subplot(2,1,1); stem(n0_id, y0_id, 'r'); legend('y_{0A}[n]');
    ylabel('y0A'); xlabel('t');
    subplot(2,1,2); stem(n1_id, y1_id, 'b'); legend('y_{1A}[n]');
    ylabel('y1A'); xlabel('t');

%   Grafica los espectros de magnitud respecto a frecuencia normalizada

    figure(4);
    subplot(2,1,1); stem(w0_id, Yjw0_id); legend('Y_{0A}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');
    subplot(2,1,2); stem(w1_id, Yjw1_id);  legend('Y_{1A}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');

%   ii. Cambio de tasa: Decimate 5, Interp 4

%   Senal x0

    xa0_id = decimate(x0, j);   % Primero decimacion
    y0_id = interp(xa0_id, i);  % Luego interpolacion

    Yjw0_id = abs(fftshift(fft(y0_id)));    % Espectro de magnitud

    n0_id = interp(decimate(n0, j), i);  % Espacio de muestras y frecuencia
    w0_id = interp(decimate(w0, j), i);  % adecuados

%   Senal x1

    xa1_id = decimate(x1, j);   % Primero decimacion
    y1_id = interp(xa1_id, i);  % Luego interpolacion

    Yjw1_id = abs(fftshift(fft(y1_id)));    % Espectro de magnitud

    n1_id = interp(decimate(n1, j), i);  % Espacio de muestras y frecuencia
    w1_id = interp(decimate(w1, j), i);  % adecuados

%   Grafico de las senales de salida del sistema

    figure(5);
    subplot(2,1,1); plot(n0_id, y0_id, 'r'); legend('y_{0B}[n]');
    ylabel('y0B'); xlabel('t');
    subplot(2,1,2); plot(n1_id, y1_id, 'b'); legend('y_{1B}[n]');
    ylabel('y1B'); xlabel('t');

%   Grafica los espectros de magnitud respecto a frecuencia normalizada

    figure(6);
    subplot(2,1,1); stem(w0_id, Yjw0_id); legend('Y_{0B}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');
    subplot(2,1,2); stem(w1_id, Yjw1_id); legend('Y_{1B}(\omega)');
    ylabel('Amplitud'); xlabel('frecuencia (\omega)');

    
% --- Pregunta 4 --- %

% Senal
K=10;
N = round(2^K);
sigma=0.5;
T=5;
x = @(t)(4*sin(2*pi*t)+ cos(30*2*pi*t));
wf = @(t)(sigma*randn(size(t)));
h = T/N;
t = (0:N-1)*h;
u = x(t)+wf(t);
%% a
% Analizando fs, para k=5 no se cumple Nyquist
%fs=T/N
u_mag= abs(fftshift( fft( u, N)));
w0=2*pi*(0:N-1)/N;
w0=unwrap(fftshift(w0)-2*pi);
figure(1);
subplot(2,1,2); plot(w0,u_mag); legend('X_{0}(\omega)');
ylabel('Amplitud'); xlabel('frecuencia (\omega)');
subplot(2,1,1); stem(u);
