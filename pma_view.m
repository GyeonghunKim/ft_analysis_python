function varargout = pma_view(varargin)
% PMA_VIEW MATLAB code for pma_view.fig
%      PMA_VIEW, by itself, creates a new PMA_VIEW or raises the existing
%      singleton*.
%
%      H = PMA_VIEW returns the handle to a new PMA_VIEW or the handle to
%      the existing singleton*.
%
%      PMA_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PMA_VIEW.M with the given input arguments.
%
%      PMA_VIEW('Property','Value',...) creates a new PMA_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pma_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pma_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pma_view

% Last Modified by GUIDE v2.5 28-Sep-2018 15:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pma_view_OpeningFcn, ...
                   'gui_OutputFcn',  @pma_view_OutputFcn, ...
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


% --- Executes just before pma_view is made visible.
function pma_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pma_view (see VARARGIN)

% Choose default command line output for pma_view
handles.output = hObject;
global cameraType
global isStop
global start_frame
cameraType = 'emCCD';
isStop = false;
start_frame = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pma_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pma_view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cameraType
global fid_pma
global xsize
global ysize
global film_length
global file_name
global dirr
addpath(cd);
cd('/media/ghkim/HDD1/smb/fret-tracking')
[file_name,dirr] = uigetfile('*.pma');
addpath(dirr);
set(handles.edit2, 'String', strcat(dirr, file_name));
fid_pma = fopen(file_name,'r');
file_info=dir(strcat(dirr, file_name));

if cameraType == 'emCCD'
    ysize=fread(fid_pma,1,'int16'); 
    xsize=fread(fid_pma,1,'int16');
    film_length=(file_info.bytes-4)/xsize/ysize;
else
    xsize = 512;
    ysize = 512;
    film_length=(file_info.bytes)/xsize/ysize;
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global film_length
global xsize
global ysize
set(handles.slider1, 'min', 1);
set(handles.slider1, 'max', film_length);
set(handles.slider1, 'Value', 1);
set(handles.slider1, 'SliderStep', [1/(film_length-1) 1]);global cameraType
global fid_pma
global isStop
global start_frame
global one_frame

axes(handles.axes1)
if cameraType == "emCCD"
    for i=start_frame:film_length
        one_frame = fread(fid_pma,[ysize,xsize], 'uint8');
        image(one_frame')
        colormap(hot);
        drawnow
        set(handles.edit3, 'String', sprintf("%d / %d",i, film_length))
        if isStop
            isStop = false;
            start_frame = i+1;
            break;
        end
    end
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isStop
isStop = true;

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cameraType
switch hObject
    case handles.radiobutton1
        cameraType = 'sCMOS';
    case handles.radiobutton2
        cameraType = 'emCCD';
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global one_frame
global file_name
global start_frame
global dirr
cd(dirr)
tif_name = strcat(file_name(1:end-4), sprintf('_%05d.tif', start_frame-1));
imwrite(one_frame, hot, tif_name);

