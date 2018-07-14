%% Autor: Pablo Díaz
%% Curso: PSID
%% Codigo: 20145789
%% Ciclo: 08M2
%% Guia 05
%% Problema 1

clear all;
close all;
clc;

%% Parte A
persona=double(imread('persona.jpg')); % leemos la imagen


% Sacamos los tres canales
persona_r=persona(:,:,1);
persona_g=persona(:,:,2);
persona_b=persona(:,:,3);

otsu_persona=graythresh(persona); % aplicamos otsu

[fil_p, col_p]=size(persona); % calculamos dimensiones

g1=size(persona(:,:,1));
g2=size(persona(:,:,1));

umbral_manual=10;

for i=1:fil_p
    for j=1:col_p
        if persona(i,j)<=otsu_persona
            g1(i,j)=1;
        else
            g1(i,j)=0;
        end
        if persona(i,j)<=umbral_manual
            g2(i,j)=0;
        else
            g2(i,j)=1;
        end
    end 
end


figure;
subplot(121),imshow(g1,[]),title('mascara 1');
subplot(122),imshow(g2,[]),title('mascara 2');


% El umbral de otsu definirá mejor
% separar ya que hay ausencia de luz en el fondo

%% Parte B

P=50;
Q=50;
% meshgrid
u_auxiliar=0:P-1;
v_auxiliar=0:Q-1;

x=find(u_auxiliar>P/2);
y=find(v_auxiliar>Q/2);

sigma=2.25;
h_Log=1*fspecial('log');

persona_log=conv2(persona_g,h_Log,'same');

th = 0.04*max(abs(persona_log(:)));

figure; 
subplot(131); imshow(persona_log,[]); title('Logaritmo de Gausiana');
subplot(132); edge(persona_log, 'zerocross', 0, h_Log); title('Cruce por cero th = 0');
subplot(133); edge(persona_log, 'zerocross', th, h_Log); title('Cruce por cero a 0.04');


%% Parte C

h_sobel=fspecial('sobel');
h_prom=[1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
persona_sobel=conv2(persona_log,h_sobel,'same');
persona_prom=conv2(persona_log,h_prom,'same');
B=zeros(size(persona_prom));

for i=1:fil_p
    for j=1:321
       if persona_prom(i,j)>=1
           B(i,j)=0;
       else 
           B(i,j)=1;
       end
    end
end


persona_caricatura=persona_r.*(1-B)-0.25.*B;

figure;
subplot(231),imshow(B,[]),title('Mascara B')
subplot(232),imshow(persona_caricatura,[]),title('Caricatura canal R');


%% Parte D
persona_h=zeros(size(persona));

P=2*492;
Q=2*321;
% meshgrid
u_auxiliar=0:P-1;
v_auxiliar=0:Q-1;

x=find(u_auxiliar>P/2);
y=find(v_auxiliar>Q/2);

u_auxiliar(x)=u_auxiliar(x)-P;
v_auxiliar(y)=v_auxiliar(y)-Q;

[v,u]=meshgrid(v_auxiliar,u_auxiliar);


for z=1:3
    for x=1:fil_p
        for y=1:321
           persona_h(x,y,z)=persona(x,y,z).*cos(0.8.*pi.*x).*cos(0.8.*pi.*y);
        end
    end
end

subplot(233),imshow(persona_h(:,:,2),[]),title('Filtrado canal G');

%% Parte E

paisaje=double(imread('paisaje.jpg'));

%Generamos filtro gaussiano
gaus=fspecial('gaussian',[3 3],2.5);

[x,y]=meshgrid(492,820);

paisaje_fft=fft2(fftshift(paisaje));
paisaje_angle=angle(paisaje_fft);
paisaje_ifft=ifft2(paisaje_fft);

figure;
subplot(131),imshow(paisaje,[]),title('Imagen original');
subplot(132),imshow(log10(abs(paisaje_fft/255)),[]),title('Espectro magnitud');
subplot(133),imshow(paisaje_angle,[]),title('Espectro de fase');



%% Parte F
persona_h=zeros(size(paisaje));
for z=1:3
    for x=1:fil_p
        for y=1:820
          % r(x,y,z)=persona(x,y,z).*cos(0.8.*pi.*x).*cos(0.8.*pi.*y);
        end
    end
end

