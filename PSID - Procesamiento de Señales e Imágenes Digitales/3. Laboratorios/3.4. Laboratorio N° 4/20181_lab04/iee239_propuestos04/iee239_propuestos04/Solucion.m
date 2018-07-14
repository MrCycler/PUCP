%% Pregunta 1
grayImage = imread('sea.jpg'); %leer imagen  
[M, N] = size(grayImage); %tamano de la imagen
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', 12);

% Calculando histograma manualmente:
hmax=255;%maximo bin
y=double(grayImage(:));%vectorizar la matriz
h=zeros(1,hmax+1);%inicializar el vector donde se construira el histograma
%colocar cada punto en el bin correspondiente e ir sumando las coincidencias
for i= 1: 255
h( i)= sum( y(:)== i);
end

% Calculando el histograma usando imhist()
histograma2=imhist(grayImage(:));

subplot(211),plot(h)
subplot(212),plot(histograma2)

intmax=255; %maximo bin
htgt=zeros(1,intmax+1); %inicializar el vector del histograma plano
a=round( M*N/(intmax+1) ); %numero de elementos en cada bin. Es producto de repartir los M*N pixeles equitativamente en cada bin.
htgt(1:(intmax+1))=a;     %construccion del histograma plano
imgeq=histeq(grayImage,htgt); %ecualizacion del histograma usando el histograma plano construido

in = double(grayImage); %hacer cast a tipo double
gamma=2;
transformed=255*((in/255).^(gamma)); %aplicar la transformacion gamma
subplot(121),imshow(in,[])
subplot(122),imshow(transformed,[])

%la transformada inversa
recovery = 255*(transformed/255).^(1/gamma);
subplot(121),imshow(transformed,[])
subplot(122),imshow(recovery,[])

a1=norm(in);
a2=norm(recovery);

A=imgeq; %renombrar imagen
B=zeros(size(A)); %inicializar variable
B=bitset(B,7,bitget(A,7)); %adquirir el bit 7 de A y ubicarlo en el bit 7 de la nueva variable.
B=bitset(B,8,bitget(A,8)); %adquirir el bit 8 de A y ubicarlo en el bit 8 de la nueva variable. Ahora B tiene el bit 7 y 8 de A.
B=uint8(B);
figure,subplot(121),imshow(A);
subplot(122),imshow(B);

B2=zeros(size(A)); %inicializar variable
B2=bitset(B2,5,bitget(A,5));
B2=bitset(B2,6,bitget(A,6));
B2=bitset(B2,7,bitget(A,7));
B2=bitset(B2,8,bitget(A,8));
B2=uint8(B2);
figure(2),subplot(121),imshow(A);
subplot(122),imshow(B2);

I=grayImage;
If=medfilt2(I,[7 7]);
difference=I-If;
k=2;
G=I+k*difference;
subplot(221),imshow(I)
subplot(222),imshow(If)
subplot(223),imshow(difference)
subplot(224),imshow(G)

%% Pregunta 3

% Carga de imagen
Image = double(rgb2gray(imread('Cuadro.jpg')))/255;
Gamma = 4;
%Transformacion Gamma y graficas correspondientes
I2 = Image.^Gamma; %Cabe recalcar que debido a que los pixeles de la imagen original se encuentran el el rango [0, 1], no es necesario un factor de escalamiento en la transformacion, pues el resultado seguira teniendo el mismo rango de valores
figure; hold on;
subplot(221); imshow(Image); title('Original');
subplot(222); imshow(I2); title('Imagen resultante');
subplot(223); imhist(Image); title('Histograma original');
subplot(224); imhist(I2); title('Histograma imagen resultante');

%Factor inverso y transformacion respectiva
Gamma_inv = 1/Gamma;
Irec = I2.^Gamma_inv;
%Verificacion de la imagen recuperada
dif = norm(Image(:)-Irec(:));

%Cargando imagen en cuestion
backgd_img = double(rgb2gray(imread('fondo.jpg')))/255;
Calculando diferencia y graficado resultado
moving = abs(Image - backgd_img);
figure; hold on
subplot(121); imshow(moving); title('Imagen diferencia');
subplot(122); imhist(moving); title('Histograma');

H=ones(3,3)/9;
B=conv2(moving, H, 'valid'); %Permite uniformizar las regiones con valores cercanos en la imagen
subplot(121); imshow(B); title('Imagen filtrada');
subplot(122); imhist(B); title('Histograma');

%Declaracion del umbral (a partir de inspeccion del histograma mediante el Data cursor) y binarizacion de las imagenes
x_umbral = 0.0392;
mask = (B > x_umbral);
mask2 = (moving > x_umbral);
%Graficando resultados
figure; hold on;
subplot(121); imshow(mask2); title('Umbralizacion, sin filtro');
subplot(122); imshow(mask); title('Umbralizacion, con filtro');


%Analisis de componentes conectados
CC = bwconncomp(mask);
ST=regionprops(mask,'basic');
%Almacenamiento de valores de area de cada objeto
Area = zeros(CC.NumObjects,1);
for l=1:CC.NumObjects
    Area(l)=ST(l).Area;
end 
%Conteo de autos
numAutos = sum(Area > 200)


%Imagen a color
imrgb = double((imread(img_name)))/255;
%Imagen 'bounding box' de referencia
boxref = double((imread('imref.jpg')))/255;
%Histogramas RGB de referencia para el calculo de la distancia
cref=zeros(3,255);
[cref(1,:) ~] = imhist(boxref(:,:,1));
[cref(2,:) ~] = imhist(boxref(:,:,2));
[cref(3,:) ~] = imhist(boxref(:,:,3));
%Inicializando distancia minima
min_dist=inf;
for i=1:28
	%Convirtiendo las coordenadas y dimensiones del 'bounding box' a valores enteros 
    BB = fix(ST(i).BoundingBox);
    box = imrgb(BB(2)+1:BB(2)+BB(4),BB(1)+1:BB(1)+BB(3),:);
    %Calculando la distancia euclidiana en cada capa RGB, y evaluando la distancia total
    for k =1:3
        [c,x] = imhist(box(:,:,k));
        d(k) = norm(c-cref(i,:));
    end
    dist=norm(d);
    %Evaluando si la distancia obtenida es la menor. De ser asi, se almacena el indice actual
    if dist < min_dist
        min_dist = dist;
        idx = i;
    end
end
%Mostrando objeto obtenido
BB = fix(ST(idx).BoundingBox);
box = imrgb(BB(2)+1:BB(2)+BB(4),BB(1)+1:BB(1)+BB(3),:);
figure;imshow(box)
