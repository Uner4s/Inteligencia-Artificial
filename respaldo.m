function varargout = Final(varargin)
% FINAL MATLAB code for Final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Final_OpeningFcn via var argin. 
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Final

% Last Modified by GUIDE v2.5 01-Dec-2014 20:08:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Final_OpeningFcn, ...
                   'gui_OutputFcn',  @Final_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Final is made visible.
function Final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Final (see VARARGIN)

% Choose default command line output for Final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Abrir_Imagen.
function Abrir_Imagen_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir_Imagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NombreArchivo,path]=uigetfile({'*.jpg';'*.png';'*.gif';'*.jpeg'},'Abrir Imagen');
Foto_Principal=imread([path,NombreArchivo]);
axes(handles.Imagen2); %funcion para utilizar axes1(cuadro para mostrar imagen)
imshow(Foto_Principal); %imshow(imblanco_negro);%muestra en axes1 la imagen que queremos segmentar
imagen=rgb2gray(Foto_Principal);
Foto_Umbral = graythresh(imagen);%Calcular Umbral
imagen =~im2bw(imagen,Foto_Umbral);%transform la imagen a binaria segun el umbral anterior
axes(handles.Imagen1);
imshow(~imagen);%muestra imagen en axes2
% Etiqueta de componentes conectados
[Largo Numero_Elementos]= bwlabel(imagen);%[Largo Numero_Elementos] el largo  y el numero de elementos que tiene la imagen

imagen_Final = ismember(Largo,1); % Segmenta la imagen
imagen_Final2 = ismember(Largo,2); % Segmenta la imagen
imagen_Final3 = ismember(Largo,3); % Segmenta la imagen
imagen_Final4 = ismember(Largo,4); % Segmenta la imagen
imagen_Final5 = ismember(Largo,5); % Segmenta la imagen
imagen_Final6 = ismember(Largo,6); % Segmenta la imagen
imagen_Final7 = ismember(Largo,7); % Segmenta la imagen
imagen_Final8 = ismember(Largo,8); % Segmenta la imagen

propied = regionprops(Largo,'BoundingBox');%cada elemento reconocido lo guardo en un rectangulo
hold on
% Plot Bounding Box - plot coordenadas de la caja
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','r','LineWidth',2)
end

hold off
handles.imagen_Final=imagen_Final;
handles.imagen_Final2=imagen_Final2;
handles.imagen_Final3=imagen_Final3;
handles.imagen_Final4=imagen_Final4;
handles.imagen_Final5=imagen_Final5;
handles.imagen_Final6=imagen_Final6;
handles.imagen_Final7=imagen_Final7;
handles.imagen_Final8=imagen_Final8;
guidata(hObject,handles);


% --- Executes on button press in Entrenar_Network.
function Entrenar_Network_Callback(hObject, eventdata, handles)
% hObject    handle to Entrenar_Network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Target=[];
%La k se representa por un 10
%hacemos el target dependiendo del orden de las fotos de entrada

for j=1:1:12
    for i=1:1:4
        switch j
            case 1
                Target=[Target ; 1 0 0 0 0 0 0 0 0 0 0 0];
            case 2
                Target=[Target ; 0 1 0 0 0 0 0 0 0 0 0 0];
            case 3
                Target=[Target ; 0 0 1 0 0 0 0 0 0 0 0 0];
            case 4
                Target=[Target ; 0 0 0 1 0 0 0 0 0 0 0 0];
            case 5
                Target=[Target ; 0 0 0 0 1 0 0 0 0 0 0 0];
            case 6
                Target=[Target ; 0 0 0 0 0 1 0 0 0 0 0 0];
            case 7
                Target=[Target ; 0 0 0 0 0 0 1 0 0 0 0 0];
            case 8
                Target=[Target ; 0 0 0 0 0 0 0 1 0 0 0 0];
            case 9
                Target=[Target ; 0 0 0 0 0 0 0 0 1 0 0 0];
            case 10
                Target=[Target ; 0 0 0 0 0 0 0 0 0 1 0 0];
            case 11
                Target=[Target ; 0 0 0 0 0 0 0 0 0 0 1 0];
            case 12
                Target=[Target ; 0 0 0 0 0 0 0 0 0 0 0 1];
        end
    end
end
    
Entradas_Network=[];

for i = 1:1:12
    for j = 1:1:4
        Archivo_Principal=strcat('Figuras_Geometricas\', int2str(i),'-',int2str(j),'.jpg'); % Abre cada imagen de la carpeta
        Imagen_Principal = imread(Archivo_Principal);
        Imagen_Umbral = graythresh(Imagen_Principal);% Calcula el umbral de una imagen. en este caso la imagen extraida de la carpeta.
        Imagen_Principal =~im2bw(Imagen_Principal,Imagen_Umbral);% transform la imagen a binaria con el umbral extraido anteriormente.
        I = recortar(Imagen_Principal);
        HuMoment = HuMom(I);
        %display(HuMoment)
        Entradas_Network = [Entradas_Network HuMoment'];
    end
end %%end for

whos Target
whos Entradas_Network
mm = [-1 1;-1 1;-1 1;-1 1;-1 1;-1 1;-1 1];
display(mm)
red = newff(mm,[32 12], {'tansig', 'purelin'}, 'trainlm', 'learngdm', 'mse');
red.TrainParam.epochs=2000;
red.TrainParam.lr=0.00001;
red = train(red, Entradas_Network, Target'); % network = train(network,inputs,Targets)
handles.red = red;
guidata(hObject,handles);


% --- Executes on button press in Extraer_Datos_Imagen.
function Extraer_Datos_Imagen_Callback(hObject, eventdata, handles)
% hObject    handle to Extraer_Datos_Imagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagen = handles.imagen_Final;
imagen2 = handles.imagen_Final2;
imagen3 = handles.imagen_Final3;
imagen4 = handles.imagen_Final4;
imagen5 = handles.imagen_Final5;
imagen6 = handles.imagen_Final6;
imagen7 = handles.imagen_Final7;
imagen8 = handles.imagen_Final8;

I1 = recortar(imagen);
I2 = recortar(imagen2);
I3 = recortar(imagen3);
I4 = recortar(imagen4);
I5 = recortar(imagen5);
I6 = recortar(imagen6);
I7 = recortar(imagen7);
I8 = recortar(imagen8);

HuMoment = HuMom(I1);
HuMoment2 = HuMom(I2);
HuMoment3 = HuMom(I3);
HuMoment4 = HuMom(I4);
HuMoment5 = HuMom(I5);
HuMoment6 = HuMom(I6);
HuMoment7 = HuMom(I7);
HuMoment8 = HuMom(I8);

handles.HuMoment=HuMoment;
handles.HuMoment2=HuMoment2;
handles.HuMoment3=HuMoment3;
handles.HuMoment4=HuMoment4;
handles.HuMoment5=HuMoment5;
handles.HuMoment6=HuMoment6;
handles.HuMoment7=HuMoment7;
handles.HuMoment8=HuMoment8;
guidata(hObject,handles);


% --- Executes on button press in Respuesta.
function Respuesta_Callback(hObject, eventdata, handles)
% hObject    handle to Respuesta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
red=handles.red;
HuMoment=handles.HuMoment;
HuMoment2=handles.HuMoment2;
HuMoment3=handles.HuMoment3;
HuMoment4=handles.HuMoment4;
HuMoment5=handles.HuMoment5;
HuMoment6=handles.HuMoment6;
HuMoment7=handles.HuMoment7;
HuMoment8=handles.HuMoment8;

simulado1 = sim(red, HuMoment'); % red entrenada, caracteristicas de la imagen.
simulado2 = sim(red, HuMoment2');
simulado3 = sim(red, HuMoment3');
simulado4 = sim(red, HuMoment4');
simulado5 = sim(red, HuMoment5');
simulado6 = sim(red, HuMoment6');
simulado7 = sim(red, HuMoment7');
simulado8 = sim(red, HuMoment8');

display(simulado_1)
for i=1:12
    simulado1(i)=abs(1-abs(simulado1(i)));
    simulado2(i)=abs(1-abs(simulado2(i)));
    simulado3(i)=abs(1-abs(simulado3(i)));
    simulado4(i)=abs(1-abs(simulado4(i)));
    simulado5(i)=abs(1-abs(simulado5(i)));
    simulado6(i)=abs(1-abs(simulado6(i)));
    simulado7(i)=abs(1-abs(simulado7(i)));
    simulado8(i)=abs(1-abs(simulado8(i)));
end
circulo=0;
cuadrado=0;
pentagono=0;
estrella=0;
triangulo=0;
estrellanorte=0;
auto=0;
corazon=0;
rayo=0;
diamante=0;
nube=0;
cruz=0;


[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

[elemento posicion] = min(simulado1);  % guarda el elemento maximo en elemento y su posicion
switch posicion
    case 1
        circulo=circulo + 1;
    case 2
        cuadrado=cuadrado+1;
    case 3
        pentagono=pentagono+1;    
    case 4
        estrella=estrella+1;    
    case 5
        triangulo=triangulo+1;
    case 6
        estrellanorte=estrellanorte+1;
    case 7
        auto=auto+1;
    case 8
        corazon=corazon+1;
    case 9
        rayo=rayo+1;
    case 10
        diamante=diamante+1;
    case 11
        nube=nube+1;
    case 12
        cruz=cruz+1;
end

msgbox(sprintf('circulo =    %2.3g\ncuadrado =    %2.3g\npentagono =    %2.3g\nestrella =    %2.3g\ntriangulo =    %2.3g\nestrellanorte =    %2.3g\nauto =    %2.3g\ncorazon =    %2.3g\nrayo =    %2.3g\ndiamante =    %2.3g\nnube =    %2.3g\ncruz =    %2.3g',circulo,cuadrado,pentagono,estrella,triangulo,estrellanorte,auto,corazon,rayo,diamante,nube,cruz),'Respuesta');