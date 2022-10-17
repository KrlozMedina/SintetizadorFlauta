function varargout = Flauta(varargin)
% FLAUTA MATLAB code for Flauta.fig
%      FLAUTA, by itself, creates a new FLAUTA or raises the existing
%      singleton*.
%
%      H = FLAUTA returns the handle to a new FLAUTA or the handle to
%      the existing singleton*.
%
%      FLAUTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLAUTA.M with the given input arguments.
%
%      FLAUTA('Property','Value',...) creates a new FLAUTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Flauta_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Flauta_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Flauta

% Last Modified by GUIDE v2.5 04-Oct-2016 22:50:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Flauta_OpeningFcn, ...
                   'gui_OutputFcn',  @Flauta_OutputFcn, ...
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


% --- Executes just before Flauta is made visible.
function Flauta_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Flauta (see VARARGIN)


% Choose default command line output for Flauta
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Flauta wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global a Fs tem
a=0;
Fs=8000;
tem=1;

% --- Outputs from this function are returned to the command line.
function varargout = Flauta_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% PLAY---------------------------------------------------------------------
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a Fs tem
a=1;
while (a==1)
    l0=0;   l1=0;   l2=0;   l3=0;   l4=0;
%     p0=0;   p1=0;   p2=0;   p3=0;   p4=0;
    %Obtener la señal del audio
%    [y,Fs]=audioread('Extra/Do5.wav');    set(handles.text1,'String','Leyendo audio');
    set(handles.text1,'Background','w');
    set(handles.text1,'String','Escuchando');
    recObj=audiorecorder(Fs,16,1);
    recordblocking(recObj,tem);
    y=getaudiodata(recObj);
    pause(0.1)
    %FFT de la señal
    L=length(y);
    NFFT = 2^nextpow2(L);
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    e=2*abs(Y(1:NFFT/2+1));
    if (a==0)
        set(handles.text1,'Background','r')
        set(handles.text1,'String','Stop')
        break
    end
    %Encontrar los picos
    [pks,locs]=findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',500);
    findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',500);
    text(locs+.02,pks,num2str((1:numel(pks))'))
    pks=pks';
    %Identificar el tamaño del vector
    if(length(locs)~=0)
        if(length(locs)>=1)
            l0=locs(1);
            if(length(locs)>=2)
                l1=locs(2);
                if(length(locs)>=3)
                    l2=locs(3);
                    if(length(locs)>=4)
                        l3=locs(4);
                        if(length(locs)>=5)
                            l4=locs(5);
                        end
                    end
                end
            end
        end
    else
        set(handles.text1,'string','No hay sonidos')
        pause(0.5)
    end
    freq=[l0 l1]
    %Identificar la nota
%     if(l0>500)
        if(l0>515 && l0<528)
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Do');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif(l0>575 && l0<591)
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Re');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>640 && l0<658))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Mi');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>692 && l0<722))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Fa');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>762 && l0<783))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Sol');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>867 && l0<893))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es La');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif(((l0>973 && l0<1012) && (l1>1935 && l1<2034)) || (l1>973 && l1<1012))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Si');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>1017 && l0<1090) && (l1>2055 && l1<2179))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Do mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>1156 && l0<1185))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Re mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif(((l0>1295 && l0<1390)))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Mi mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>1367 && l0<1450))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Fa mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>1528 && l0<1585))%% || (l1>1528 && l1<1585))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es Sol mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        elseif((l0>1740 && l0<1800))
            set(handles.text1,'Background','g');
            set(handles.text1,'String','Es La mayor');
            if(get(handles.checkbox1,'Value')==1)
                pause(1)
            else
                break
            end
        end
%     end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a
a=0;
set(handles.text1,'Background','r')
set(handles.text1,'String','Stop')


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global a
% if(get(handles.checkbox1,'Value')==1)
%     a=1;
% end
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
