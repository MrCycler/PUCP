function [w_v,abs_Xjw,ang_Xjw] = espectros(x)
n = length(x);
abs_Xjw = abs(fftshift(fft(x,n)));
ang_Xjw = angle(fftshift(fft(x,n)));
w_v = unwrap(fftshift(2*pi*(0:(n-1))/n) - 2*pi);
end
