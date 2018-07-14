function dtmf_spectrum(x_v, Fs)

X_v= fft( x_v); % Espectro de frecuencia de x a partir de rutina fft() vista desde 0 a 2 \Omega_{s}, donde \Omega_{s}= 2\pi Fs
X_v= fftshift( X_v);    % Re-expresar espectro en del rango {-\Omega_{s}, +\Omega_{s}}
X_mag_v= abs( X_v); % Espectro de magnitud de X_v
X_phase_v= angle( X_v); % Espectro de fase de X_v
Omega_v= 2* pi* ( 0: length( X_v)- 1)/ length( X_v); % dominio de frecuencia: ubicaciones analizadas del espectro de acuerdo a rutina fft()
Omega_v= Fs/( 2* pi)* unwrap( fftshift( Omega_v)- 2* pi);    % Re-expresar dominio de frecuencia para ser coherente con X_v

plot( Omega_v, X_mag_v/ length( x_v)); ylabel( 'Espectro de magnitud'); xlabel( 'Frecuencia (Hz)');