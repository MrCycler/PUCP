function output=remove_hair(Ie,A)
%par�metros de entrada:
%Ie: imagen donde se muestre solo los cabellos (resultado �tem b)
%A: imagen en escala de grises despu�s de filtrar ruido (resultado �tem a)
se = strel('disk',5);
hairs = imbothat(Ie,se);
BW = hairs > 10;
BW2 = imdilate(BW,strel('disk',2));
BW3 = bwareaopen(BW2, 100);
BW4 = imdilate(BW3,strel('disk',5));
output = roifill(A, BW4);
end