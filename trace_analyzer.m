function varargout = trace_analyzer(varargin)
% TRACE_ANALYZER MATLAB code for trace_analyzer.fig
%      TRACE_ANALYZER, by itself, creates a new TRACE_ANALYZER or raises the existing
%      singleton*.
%
%      H = TRACE_ANALYZER returns the handle to a new TRACE_ANALYZER or the handle to
%      the existing singleton*.
%
%      TRACE_ANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACE_ANALYZER.M with the given input arguments.
%
%      TRACE_ANALYZER('Property','Value',...) creates a new TRACE_ANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trace_analyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trace_analyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trace_analyzer

% Last Modified by GUIDE v2.5 29-Sep-2018 19:00:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trace_analyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @trace_analyzer_OutputFcn, ...
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


% --- Executes just before trace_analyzer is made visible.
function trace_analyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trace_analyzer (see VARARGIN)

% Choose default command line output for trace_analyzer
handles.output = hObject;
global cameraType
global peakFinder
cameraType = "emCCD";
peakFinder = "ThunderSTORM";







% Update handles structure
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trace_analyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trace_analyzer_OutputFcn(hObject, eventdata, handles) 
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
global which_spot
global peak_image
frame_no = floor(get(handles.slider1, 'Value'));
axes(handles.axes6);
imagesc(squeeze(peak_image(which_spot,frame_no,:,:)));

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cur = str2double(get(handles.edit2, 'String'));
set(handles.edit2, 'String', num2str(cur + 1));
pushbutton4_Callback(hObject, eventdata, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cur = str2double(get(handles.edit2, 'String'));
set(handles.edit2, 'String', num2str(cur - 1));
pushbutton4_Callback(hObject, eventdata, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global trace
global peak_image
global which_spot
which_spot = str2double(get(handles.edit2, 'String'));
axes(handles.axes1);
plot(trace(which_spot, :));

axes(handles.axes6);
imagesc(squeeze(peak_image(which_spot,1,:,:)));




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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name
global dirr
global peakFinder
addpath(cd);
cd('/media/ghkim/HDD1/smb/fret-tracking')

if peakFinder == "ThunderSTORM"
    [file_name,dirr] = uigetfile('*.csv');
    set(handles.edit4, 'String', strcat(dirr, file_name));
    addpath(dirr);
    data_table = readtable(file_name);
    x_data = floor(data_table.x_nm_/104);
    y_data = floor(data_table.y_nm_/104);
    handles.stacked_image = zeros(512);
    for i = 1:length(x_data)
        if (x_data(i) < 512) && (x_data(i) > 1)
            if (y_data(i) < 512) && (y_data(i) > 1)
                handles.stacked_image(x_data(i), y_data(i)) = handles.stacked_image(x_data(i), y_data(i)) + 1;  
            end
        end
    end
end
axes(handles.axes4);
imagesc(handles.stacked_image');

global nearfarintensity
global peak_from_stacked_image
temp_peak = FastPeakFind(handles.stacked_image);
peak_from_stacked_image = [temp_peak(1:2:end),temp_peak(2:2:end)];
numspot = length(temp_peak)/2
nearfarintensity = zeros(2, length(temp_peak)/2);
x_data = peak_from_stacked_image(:,1);
y_data = peak_from_stacked_image(:,2);
for i = 1:numspot
    if (x_data(i) < 512 - 3) && (x_data(i) > 1 + 3)
        if (y_data(i) < 512 - 3) && (y_data(i) > 1 + 3)
            near_sum = sum(sum(handles.stacked_image(x_data(i)-1:x_data(i)+1, y_data(i)-1:y_data(i)+1)));
            far_sum = sum(sum(handles.stacked_image(x_data(i)-3:x_data(i)+3, y_data(i)-3:y_data(i)+3)));
            near_temp = (near_sum)/9;
            far_temp = (far_sum - near_sum)/40;
            nearfarintensity(:,i) = [near_temp, far_temp];
        end
    end
end
axes(handles.axes5);
scatter(nearfarintensity(1,:), nearfarintensity(2,:), 'r.');
xlabel('near_mean');
ylabel('far_mean');
set(handles.edit7, 'String', num2str(numspot));




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nearfarintensity;
global trace_point;
global peak_from_stacked_image
near_crit = str2double(get(handles.edit5, 'String'));
far_crit = str2double(get(handles.edit6, 'String'));
axes(handles.axes5);
hold on
refline([0 far_crit]);
plot([near_crit, near_crit],[0, max(nearfarintensity(2,:))], 'r');
trace_point = zeros(1,2);
for i = 1:length(nearfarintensity)
    if nearfarintensity(1,i) > near_crit && nearfarintensity(2,i) < far_crit
        trace_point = cat(1, trace_point, peak_from_stacked_image(i, :));
    end
end
trace_point = trace_point(2:end, :)
set(handles.edit7, 'String', num2str(length(trace_point)));
axes(handles.axes4);
hold on;
plot(trace_point(:,1), trace_point(:,2), 'ro');




function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global trace
global peak_image
global trace_point
global dirr
global file_name
global cameraType

movie_name = strcat(dirr, file_name);
movie_name = strcat(movie_name(1:end-4), '.pma');
fid_pma = fopen(movie_name,'r');
file_info=dir(movie_name);
if cameraType == 'emCCD'
    ysize=fread(fid_pma,1,'int16')
    xsize=fread(fid_pma,1,'int16')
    
    film_length = (file_info.bytes-4)/xsize/ysize
else
    xsize = 512;
    ysize = 512;
    film_length = (file_info.bytes)/xsize/ysize;
end
number_spot = length(trace_point);
trace = zeros(number_spot, film_length);
peak_image = zeros(number_spot, film_length, 7,7);


if cameraType == "emCCD"
    for i=1:film_length
        one_frame = fread(fid_pma,[ysize,xsize], 'uint8');
        for j = 1:number_spot
            x_point = trace_point(j, 1);
            y_point = trace_point(j, 2);
            trace(j, i) = sum(sum(one_frame(x_point - 2:x_point + 2, y_point - 2: y_point + 2)));
            peak_image(j, i, :, :) = one_frame(x_point - 3:x_point + 3, y_point - 3: y_point + 3);
        end
    end
else
    disp("sCMOS version not ready. It will upgrade soon:)");
end
axes(handles.axes1);
plot(trace(1, :));

axes(handles.axes6);
imagesc(squeeze(peak_image(1,1,:,:)));

set(handles.slider1, 'min', 1);
set(handles.slider1, 'max', film_length);
set(handles.slider1, 'SliderStep', [1/(film_length-1) , 1/(film_length-1) ]);

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cameraType
switch hObject
    case handles.radiobutton2
        cameraType = 'emCCD';
    case handles.radiobutton1
        cameraType = 'sCMOS';
end


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
