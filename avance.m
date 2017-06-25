[NombreArchivo,path]=uigetfile({'*.jpg';'*.png';'*.gif';'*.jpeg'},'Abrir Imagen');
Foto_Principal=imread([path,NombreArchivo]);
imagen=rgb2gray(Foto_Principal);
Foto_Umbral = graythresh(imagen);%Calcular Umbral
imagen =~im2bw(imagen,Foto_Umbral);%transform la imagen a binaria segun el umbral anterior
% Etiqueta de componentes conectados
[Largo Numero_Elementos]= bwlabel(imagen);%[Largo Numero_Elementos] el largo  y el numero de elementos que tiene la imagen

imagen_Final1 = ismember(Largo,1); % Segmenta la imagen
imagen_Final2 = ismember(Largo,2); % Segmenta la imagen

% cuenta la cantidad de cosas en la imagen
a_bin=im2bw(Foto_Principal,0.5)
a_bin=not(a_bin);
a_label=bwlabel(a_bin,8);
n=max(max(a_label))
msgbox(sprintf('Numero de elementos en la imagen = %2.3g',n),'Imagen');

I1 = recortar(imagen_Final1);
HuMoment_1 = HuMom(I1);
I2 = recortar(imagen_Final2);
HuMoment_2 = HuMom(I2);

display(HuMoment_1)
display(HuMoment_2)

% Si es cuadrado salida 0;
% Si es triangulo Salida 1;

Target=[1 0; 0 1; 1 0; 0 1; 1 0; 0 1; 1 0; 0 1; 1 0; 0 1; 1 0; 1 0; 1 0];
% 1 0 -> Cuadrado
% 0 1 -> Triagunlo
Entradas_Network=[];
for i = 1:13
        Archivo_Principal=strcat('Figuras_Geometricas\', int2str(i), '.jpg'); % Abre cada imagen de la carpeta
        Imagen_Principal = imread(Archivo_Principal);
        Imagen_Umbral = graythresh(Imagen_Principal);% Calcula el umbral de una imagen. en este caso la imagen extraida de la carpeta.
        Imagen_Principal =~im2bw(Imagen_Principal,Imagen_Umbral);% transform la imagen a binaria con el umbral extraido anteriormente.
        I = recortar(Imagen_Principal);
        HuMoment = HuMom(I);
        display(HuMoment)
        Entradas_Network = [Entradas_Network HuMoment'];
end %%end for
mm = [-1 1;-1 1;-1 1;-1 1;-1 1;-1 1;-1 1];
red = newff(mm,[16 2], {'tansig', 'purelin'}, 'trainlm', 'learngdm', 'mse');
red.TrainParam.epochs=1000;
red.TrainParam.lr=0.00001;
red = train(red, Entradas_Network, Target'); % network = train(network,inputs,Targets)

simulado_1 = sim(red, HuMoment_1'); % red entrenada, caracteristicas de la imagen.
simulado_2 = sim(red, HuMoment_2');

display(simulado_1)
display(simulado_2)

[elemento posiciones1] = max(simulado_1);  % guarda el elemento maximo en elemento y su posicion
[elemento2 posiciones2] = max(simulado_2); %

cuadrado=0;
triangulo=0;
display(posiciones1)
display(posiciones2)

switch posiciones1
    case 1
        cuadrado=cuadrado+1;
    case 2
        triangulo=triangulo+1;
end

switch posiciones2
    case 1
        cuadrado=cuadrado+1;
    case 2
        triangulo=triangulo+1;
end

msgbox(sprintf('triangulos =    %2.3g\ncuadrados =    %2.3g',triangulo,cuadrado),'Respuesta');