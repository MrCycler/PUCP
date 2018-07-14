function [ ] = espectrodemag( f1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n_size= length(f1);
X02= fftshift( fft( f1, n_size));
w_v= 2*pi* ( 0: ( n_size- 1))/ (n_size);  % puntos discretos en frecuencia (de 0 a 2pi)
w_v= fftshift( w_v);
w_v= unwrap( w_v - 2*pi);   % puntos discretos en frecuencia (de -pi a pi)
plot(w_v,abs(X02))
end

