function varargout = Roll(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Roll_OpeningFcn, ...
                   'gui_OutputFcn',  @Roll_OutputFcn, ...
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

function Roll_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.d20val,'ForegroundColor',[0.5 0.8 1])
set(handles.d20val,'string','dinosaur');
set(handles.d4val,'string','0');
set(handles.d6val,'string','0');
set(handles.d8val,'string','0');
set(handles.d10val,'string','0');
set(handles.d12val,'string','0');

handles.output = hObject;
guidata(hObject, handles);

function varargout = Roll_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function d4_Callback(hObject, eventdata, handles)

d4val = str2double( get(handles.d4val,'string') );
d4val = d4val + 1;
set(handles.d4val,'string',d4val);

function d6_Callback(hObject, eventdata, handles)

d6val = str2double( get(handles.d6val,'string') );
d6val = d6val + 1;
set(handles.d6val,'string',d6val);

function d8_Callback(hObject, eventdata, handles)

d8val = str2double( get(handles.d8val,'string') );
d8val = d8val + 1;
set(handles.d8val,'string',d8val);

function d10_Callback(hObject, eventdata, handles)

d10val = str2double( get(handles.d10val,'string') );
d10val = d10val + 1;
set(handles.d10val,'string',d10val);

function d12_Callback(hObject, eventdata, handles)

d12val = str2double( get(handles.d12val,'string') );
d12val = d12val + 1;
set(handles.d12val,'string',d12val);


function d20_Callback(hObject, eventdata, handles)

d20val = num2str( randi(20) );
set(handles.d20val,'string',d20val);

function HitDmg_Callback(hObject, eventdata, handles)

d20hitval = randi(20);
if d20hitval == 20
    d20hitval = num2str(d20hitval);
    set(handles.d20hitval,'string',d20hitval, ...
        'BackgroundColor',[1 0 0],'fontweight','bold');
else
    d20hitval = num2str(d20hitval);
    set(handles.d20hitval,'string',d20hitval, ...
        'BackgroundColor',[0.941 0.941 0.941],'fontweight','normal');
end

d4val  = str2double( get(handles.d4val,'string') );
d6val  = str2double( get(handles.d6val,'string') );
d8val  = str2double( get(handles.d8val,'string') );
d10val = str2double( get(handles.d10val,'string') );
d12val = str2double( get(handles.d12val,'string') );
modifier = str2double( get(handles.modifier,'string') );

damage = sum( randi(4,1,d4val) ) + sum( randi(6,1,d6val) ) ...
    + sum( randi(8,1,d8val) ) + sum( randi(10,1,d10val) ) ...
    + sum( randi(12,1,d12val) ) + modifier;
damage = num2str(damage);
set(handles.damage,'string',damage);

set(handles.d20val,'string','0');
set(handles.d4val,'string','0');
set(handles.d6val,'string','0');
set(handles.d8val,'string','0');
set(handles.d10val,'string','0');
set(handles.d12val,'string','0');

function plus_Callback(hObject, eventdata, handles)

plus = str2double( get(handles.modifier,'string') );
plus = plus + 1;
set(handles.modifier,'string',plus);

function minus_Callback(hObject, eventdata, handles)

minus = str2double( get(handles.modifier,'string') );
minus = minus - 1;
set(handles.modifier,'string',minus);
