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

propied = regionprops(Largo,'BoundingBox');%cada elemento reconocido lo guardo en un rectangulo
hold on
% Plot Bounding Box - plot coordenadas de la caja
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','r','LineWidth',2)
end

hold off
handles.imagen_Final=imagen_Final;
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
I1 = recortar(imagen);
HuMoment_1 = HuMom(I1);
display(HuMoment_1)
handles.HuMoment_1=HuMoment_1;
guidata(hObject,handles);


% --- Executes on button press in Respuesta.
function Respuesta_Callback(hObject, eventdata, handles)
% hObject    handle to Respuesta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
red=handles.red;
HuMoment_1=handles.HuMoment_1;
simulado_1 = sim(red, HuMoment_1'); % red entrenada, caracteristicas de la imagen.

display(simulado_1)
for i=1:12
    simulado_1(i)=abs(1-abs(simulado_1(i)));
end

display(simulado_1)

[elemento posicion] = min(simulado_1);  % guarda el elemento maximo en elemento y su posicion


display(posicion)

switch posicion
    case 1
        msgbox('La Figura de la Imagen es un Circulo');
    case 2
        msgbox('La Figura de la Imagen es un Cuadrado');
    case 3
        msgbox('La Figura de la Imagen es un Pentagono');    
    case 4
        msgbox('La Figura de la Imagen es una Estrella Comun');    
    case 5
        msgbox('La Figura de la Imagen es un Triangulo');
    case 6
        msgbox('La Figura de la Imagen es una Estrella del Norte');
    case 7
        msgbox('La Figura de la Imagen es un Auto');
    case 8
        msgbox('La Figura de la Imagen es un Corazon');
    case 9
        msgbox('La Figura de la Imagen es un Rayo');
    case 10
        msgbox('La Figura de la Imagen es un Diamante');
    case 11
        msgbox('La Figura de la Imagen es una nube de Dialogo');
    case 12
        msgbox('La Figura de la Imagen es una Cruz');
end

%msgbox(sprintf('triangulos =    %2.3g\ncuadrados =    %2.3g',triangulo,cuadrado),'Respuesta');
