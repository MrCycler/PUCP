%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% Guia 05
%% Problema 1
%% Parte A
imagen=double(imread('alchemist.png'));
tam=size(imagen);

%imagen_r=imagen(:,:,1);
%imagen_g=imagen(:,:,2);
%imagen_b=imagen(:,:,3);

bits=0:255;
max_1=tam(1)*2;
max_2=tam(2)*2;

imagen_fft=fftshift(fft2(imagen,max_1,max_2)); %Centramos la imagen
imagen_fft_abs=abs(imagen_fft); % Espectro de magnitud
imagen_fft_angle=angle(imagen_fft); % Espectro de fase

c_1=unwrap(fftshift(2*pi/max_1*(0:max_1-1)-2*pi)); % u
c_2=unwrap(fftshift(2*pi/max_2*(0:max_2-1)-2*pi)); % v
% u y v en rango fundamental

fig01=figure;
subplot(221),imagesc(imagen),title('Imagen original');
subplot(222),hist(imagen,bits,'c'),title('Histograma');
subplot(223); imagesc( c_1, c_2, log10( abs( imagen_fft_abs))); axis image; title( 'Espectro de Magnitud'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');
subplot(224); imagesc( c_1, c_2, imagen_fft_angle); axis image; colormap gray;title( 'Espectro de Fase'); xlabel( '\omega_{x}'); ylabel( '\omega_{y}');

% Identificar la posicion (u,v) deñ tpmp de interferencia

% u=0.8812 v=0.7465
% u=-0.8812 v=0.7465

%% Parte B

imagen_fft_2=fft2(imagen,tam(1)*2,tam(2)*2);

D=27;
n=21;
P=2*tam(1);
Q=2*tam(2);
% meshgrid
u_auxiliar=0:P-1;
v_auxiliar=0:Q-1;

x=find(u_auxiliar>P/2);
y=find(v_auxiliar>Q/2);

u_auxiliar(x)=u_auxiliar(x)-P;
v_auxiliar(y)=v_auxiliar(y)-Q;

[v,u]=meshgrid(v_auxiliar,u_auxiliar);
% Distancia euclidiana
Dit=sqrt(u.^2+v.^2);

h01=1-(1./(1+(sqrt(u.^2+v.^2)./D).^(2.*n)));

Hf1= circshift(h01 , [-235 -241]);
Hf2= circshift(h01 , [-235 241]);
Hf3= circshift(h01 , [-146 -101]);
Hf4= circshift(h01 , [-146 101]);
Hf5= circshift(h01 , [146 -101]);
Hf6= circshift(h01 , [146 101]);
Hf7= circshift(h01 , [235 -241]);
Hf8= circshift(h01 , [235 241]);

H_Rechaza=(Hf3.*Hf4.*Hf5.*Hf6);

imagen_filtrada = imagen_fft_2.*H_Rechaza;% Filtrado en frec
imagen_filtrada = real(ifft2(imagen_filtrada)); % Transf. inv
imagen_filtrada = imagen_filtrada(1:tam(1), 1:tam(2)); % recorte


fig02=figure;
subplot(141), imshow(log10(abs( fftshift(h01)) ),[]), title('Filtro pasa-altos ');
subplot(142), imshow(log10(abs( fftshift(H_Rechaza)) ),[]), title('Filtro rechaza banda ');
%subplot(141), imshow(angle( fftshift(imagen_fft)) ,[]), title('Fase filtro');
subplot(143), imshow(log10(abs(fftshift(imagen_fft_2))),[]), title('Mag img filtrada')
subplot(144), imshow(imagen_filtrada),title('Imagen filtrada');


%% Parte C

sigma=0.8;
M=3;
[x,y]=meshgrid(-M:M,-M:M);
% Generamos el LOG
Log=1/(pi*sigma^4)*(((x.^2+y.^2)/2*sigma^2)-1)*exp(-(x^2+y^2)/(2*sigma^2));
escala=1/(2*pi*sigma^2);
h_Log=escala*Log;
% recordar que imagen es la variable que tiene el 'png'
imagen_log=conv2(imagen,h_Log,'same');


th = 0.01*max(abs(imagen_log(:)));

figure; 
subplot(131); imshow(imagen_filtrada,[]); title('Logaritmo de Gausiana');
subplot(132); edge(imagen_filtrada, 'zerocross', 0, h_Log); title('Cruce por cero th = 0');
subplot(133); edge(imagen_filtrada, 'zerocross', th, h_Log); title('Cruce por cero a 1%');


% Comentar si el filtro tiene alguna
% preileccion a bordes con cierta
% orientacion

% El filtro tiene predileccion por los bordes 
% verticales
% puesto que son los primeros que aparecen al
% cambiar el valor de th

%% Parte D


figure;
subplot(131),imshow(imagen_log,[]);title('I_L');
subplot(132),imshow(imagen_log,[]);title('I_T');
subplot(133),imshow(imagen_log,[]);title('I Binarizada');



%% Problema 2
clear all;
close all;
clc;
%% Parte A

video=video2frames('bebop.avi');
[x,y,c,n]=size(video);
B=zeros([x y c n]);
for it1=1:x
    for it2=1:y
        for it3=1:c
            B(it1,it2,it3)=median(video(it1,it2,it3,:));
        end
    end
end


%% Parte B
% Diferencia de cada cuadro con la est. de fondo
% para obj móviles

S=zeros([x y c n]);

for i=1:10
S(:,:,:,i)=video(:,:,:,10)-B(:,:,:,i);
end
UltimoFrame=figure;
subplot(221),imshow(video(:,:,:,10)),title('Matriz V Ultimo Frame' );
subplot(223),imshow(B(:,:,:,10)),title('Matriz B Ultimo Frame');
subplot(222),imshow(S(:,:,:,1)),title('Matriz S primer Frame');
subplot(224),imshow(S(:,:,:,10)),title('Matriz S Ultimo Frame');

%% Parte C.1
% sacamos los frames
frame_1=S(:,:,:,1);
%histograma
bits=0:255;
frame_1_r=frame_1(:,:,1);
%normalizamos hist
hist_01=hist(frame_1_r,bits);

figure;
subplot(311),imshow(frame_1_r,[]),title('Canal R frame 1');
subplot(312),bar(bits, hist_01,'r'),title('Histograma canal R frame 1');

%% Parte C.2
Umbral=[0.20 0.18 0.16 0.14 0.12 0.10]; % Umbral

M1=zeros([x,y,n]); % creamos vector M
M2=zeros([x,y,n]); % creamos vector M
M3=zeros([x,y,n]); % creamos vector M
M4=zeros([x,y,n]); % creamos vector M
M5=zeros([x,y,n]); % creamos vector M
M6=zeros([x,y,n]); % creamos vector M

for it1=1:x
   for it2=1:y
       for it3=1:n
           if (S(it1,it2,1,it3)>Umbral(1))
               M1(it1,it2,it3)=1;
           else
               M1(it1,it2,it3)=0;
           end
           if (S(it1,it2,1,it3)>Umbral(2))
               M2(it1,it2,it3)=1;
           else
               M2(it1,it2,it3)=0;
           end
           if (S(it1,it2,1,it3)>Umbral(3))
               M3(it1,it2,it3)=1;
           else
               M3(it1,it2,it3)=0;
           end
           if (S(it1,it2,1,it3)>Umbral(4))
               M4(it1,it2,it3)=1;
           else
               M4(it1,it2,it3)=0;
           end
           if (S(it1,it2,1,it3)>Umbral(5))
               M5(it1,it2,it3)=1;
           else
               M5(it1,it2,it3)=0;
           end
           if (S(it1,it2,1,it3)>Umbral(6))
               M6(it1,it2,it3)=1;
           else
               M6(it1,it2,it3)=0;
           end
       end
   end
end



figure
subplot(231),imshowpair(M1(:,:,3),M1(:,:,8)),title('Umbral 0.20');
subplot(232),imshowpair(M2(:,:,3),M2(:,:,8)),title('0.18');
subplot(233),imshowpair(M3(:,:,3),M3(:,:,8)),title('0.16');
subplot(234),imshowpair(M4(:,:,3),M4(:,:,8)),title('0.14');
subplot(235),imshowpair(M5(:,:,3),M5(:,:,8)),title('0.12');
subplot(236),imshowpair(M6(:,:,3),M6(:,:,8)),title('0.10');

%% Parte D

stats=regionprops(M1(:,:,1));
centroide_1=stats.Centroid;
stats=regionprops(M1(:,:,2));
centroide_2=stats.Centroid;
stats=regionprops(M1(:,:,3));
centroide_3=stats.Centroid;
stats=regionprops(M1(:,:,4));
centroide_4=stats.Centroid;
stats=regionprops(M1(:,:,5));
centroide_5=stats.Centroid;
stats=regionprops(M1(:,:,6));
centroide_6=stats.Centroid;
stats=regionprops(M1(:,:,7));
centroide_7=stats.Centroid;
stats=regionprops(M1(:,:,8));
centroide_8=stats.Centroid;
stats=regionprops(M1(:,:,9));
centroide_9=stats.Centroid;
stats=regionprops(M1(:,:,10));
centroide_10=stats.Centroid;

centroide=[centroide_1 centroide_2 centroide_3 centroide_4 centroide_5 centroide_6 centroide_7 centroide_8 centroide_9 centroide_10];

for i=2:10
   u=centroide-centroide(i-1);
end

ux=1/9*u;

pixel=25*2*ux;

%% Problema 3
%% Parte A
imagen2=imread('yourname.jpeg');

g_x= [1 2 1; 0 0 0; -1 2 -1];
g_y= [1 0 -1; 2 0 -2; 1 0 -1];

imagen2_size=size(imagen2);
fil2=imagen2_size(1)*2;
col2=imagen2_size(2)*2;


%% Parte B

%% Parte C

%% Parte D













