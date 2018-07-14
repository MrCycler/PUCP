function varargout = Interfazfiltros2(varargin)
% INTERFAZFILTROS2 MATLAB code for Interfazfiltros2.fig
%      INTERFAZFILTROS2, by itself, creates a new INTERFAZFILTROS2 or raises the existing
%      singleton*.
%
%      H = INTERFAZFILTROS2 returns the handle to a new INTERFAZFILTROS2 or the handle to
%      the existing singleton*.
%
%      INTERFAZFILTROS2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZFILTROS2.M with the given input arguments.
%
%      INTERFAZFILTROS2('Property','Value',...) creates a new INTERFAZFILTROS2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfazfiltros2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfazfiltros2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfazfiltros2

% Last Modified by GUIDE v2.5 14-Sep-2017 10:41:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfazfiltros2_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfazfiltros2_OutputFcn, ...
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


% --- Executes just before Interfazfiltros2 is made visible.
function Interfazfiltros2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfazfiltros2 (see VARARGIN)

% Choose default command line output for Interfazfiltros2
handles.output = hObject;
handles.myImage = []; 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interfazfiltros2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfazfiltros2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cargarimagen.
function cargarimagen_Callback(hObject, eventdata, handles)
% hObject    handle to cargarimagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename1,filepath1]=uigetfile({'*.*','All Files'},...
  'Select Data File 1');
  %cd(filepath1);
  rawdata1=load(filename1);
  
   % handles.myImage = imread('pinguinos.jpg');
   handles.myImage = imread(filename1);
    image(handles.myImage, 'Parent', handles.axes1);

    guidata(hObject, handles);


% --- Executes on selection change in menu1.
function menu1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu1
guidata(hObject, handles);
v=get(handles.menu1,'value');
switch v
    case 1
        imshow(handles.myImage, 'Parent', handles.axes2);
    case 2
        imshow(handles.myImage, 'Parent', handles.axes2);
    case 3
        image4=handles.myImage;
        image41(:,:,1)=image4(:,:,1);
        image41(:,:,2)=0;
        image41(:,:,3)=0;
        image(image41, 'Parent', handles.axes2);
    case 4
        image5=handles.myImage;
        image51(:,:,2)=image5(:,:,2);
        image51(:,:,1)=0;       
        image51(:,:,3)=0;
        image(image51, 'Parent', handles.axes2); 
    case 5
        image6=handles.myImage;
        image61(:,:,3)=image6(:,:,3);
        image61(:,:,1)=0;
        image61(:,:,2)=0;        
        image(image61, 'Parent', handles.axes2);

    case 6   
        imagebw=im2bw(handles.myImage,0.5);
        imshow(imagebw, 'Parent', handles.axes2);
                
    case 7        
        im_gray=rgb2gray(handles.myImage);
        imshow(im_gray, 'Parent', handles.axes2);
    case 8
        im_gray2=rgb2gray(handles.myImage);
        im_edge=edge(im_gray2,'sobel');
        imshow(im_edge, 'Parent', handles.axes2);
    case 9
        im_gray3=imnoise(handles.myImage, 'salt & pepper');
        imshow(im_gray3, 'Parent', handles.axes2);
    otherwise
        im_gray4=rgb2gray(handles.myImage);
        im_gray5=imnoise(im_gray4, 'salt & pepper');
        imshow(im_gray5, 'Parent', handles.axes2);  
end

% --- Executes during object creation, after setting all properties.
function menu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu2.
function menu2_Callback(hObject, eventdata, handles)
% hObject    handle to menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu2
guidata(hObject, handles);
v=get(handles.menu2,'value');
        im_gray7=rgb2gray(handles.myImage);
        im_gray8=imnoise(im_gray7, 'salt & pepper');
        
switch v
    case 1
        imshow(im_gray8, 'Parent', handles.axes4);
    case 2
        im_filt=medfilt2(im_gray8);
        imshow(im_filt, 'Parent', handles.axes4);
    case 3 %-----------------------------------deteccion de bordes
        %filtro_suavizado=1/9*[1 1 1;1 1 1;1 1 1]; %filtro de errores
        filtro_borde=[0 1 0;1 -4 1;0 1 0];
        filtroB=filter2(filtro_borde,double(im_gray7));
        image(filtroB, 'Parent', handles.axes4);
    case 4 %-----------------------------------sobel
        filtro_sobel=[-1 0 1;-2 0 2;-1 0 1];
        filtroS=filter2(filtro_sobel,double(im_gray7));
        image(filtroS, 'Parent', handles.axes4);
    case 5 %-----------------------------------enfoque
        filtro_enfoque=[0 -1 0;-1 5 -1;0 -1 0];
        filtroE=filter2(filtro_enfoque,double(im_gray7));
        image(filtroE, 'Parent', handles.axes4);
        
    case 6 %-----------------------------------desenfoque
        filtro_desenfoque=[1 1 1;1 1 1;1 1 1];
        filtroD=filter2(filtro_desenfoque,double(im_gray7));
        image(filtroD, 'Parent', handles.axes4);
                
    case 7 %-----------------------------------Realce
        filtro_realce=[0 0 0;-1 1 0;0 0 0];
        filtroR=filter2(filtro_realce,double(im_gray7));
        image(filtroR, 'Parent', handles.axes4);
                
    case 8 %-----------------------------------Repujado
        filtro_repujado=[-2 -1 0;-1 1 1;0 1 2];
        filtroRP=filter2(filtro_repujado,double(im_gray7));
        image(filtroRP, 'Parent', handles.axes4);

    case 9 %-----------------------------------Filtro Norte
        filtro_norte=[1 1 1;1 -2 1;1 -1 -1];
        filtroN=filter2(filtro_norte,double(im_gray7));
        image(filtroN, 'Parent', handles.axes4);
    case 10 %-----------------------------------Filtro Este
        filtro_este=[-1 1 1;-1 -2 1;-1 1 1];
        filtroE=filter2(filtro_este,double(im_gray7));
        image(filtroE, 'Parent', handles.axes4);
    case 11
        [a b]=imhist(im_gray8);
        stem(b,a, 'Parent', handles.axes4)
    case 12  
        %como hay nivel de gris desde el 0 hasta el 255 no se puede aplicar
        %ecualizacion
        imshow(im_gray8, 'Parent', handles.axes4);  
        
    otherwise
        im_filt2=medfilt2(im_gray8);
        filtro3=1/9*[1 1 1;1 1 1;1 1 1];
        filtro_suavizado2=filter2(filtro3,double(im_filt2));
        image(filtro_suavizado2, 'Parent', handles.axes4);
        
end


% --- Executes during object creation, after setting all properties.
function menu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function matrizP_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to matrizP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in matrizP.
function matrizP_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to matrizP (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
im_gray7=rgb2gray(handles.myImage);
matrizP= get(handles.matrizP,'data');
set(handles.texto1,'String',num2str(matrizP{1,1}));
filtro_p=[matrizP{1,1} matrizP{1,2} matrizP{1,3};matrizP{2,1} matrizP{2,2} matrizP{2,3};matrizP{3,1} matrizP{3,2} matrizP{3,3}];
filtroRP=filter2(filtro_p,double(im_gray7));
image(filtroRP, 'Parent', handles.axes4);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
