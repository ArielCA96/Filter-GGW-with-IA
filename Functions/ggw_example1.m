% GGW 

min_frec = 5.0;
max_frec = 20.0;

% Parámetros de la línea
a = 2; %ancho del pin
p = 6; %separacion entre pin
w = 19.05; %ancho de la pista
h = 1.525; % separacion del pnin con la tapa
d = 8; % altura del pin

l = 9*p + a;
w_T = 6*p +2*a + w;
z0 = -p;
z1 = 0;
z2 = d + h;
z3 = d + h + p;

% Parámetros del filtro
w_div = 8; % divisiones del ancho  8, 16
l_div = 24; % divisiones del largo  24, 48

% 



%------------------
cst = actxserver('CSTStudio.application');
mws = cst.invoke('NewMWS');
CstDefaultUnits(mws) 

CstDefineFrequencyRange(mws, min_frec, max_frec)

% CstMeshInitiator(mws)

% Boundary
%Xmin,Xmax,Ymin,Ymax,Zmin,Zmax = 'expanded open', 'open', 'electric',
%'magnetic', 'periodic', 'conducting wall', 'unit cell'
Xmin='open';
Xmax='open';
Ymin='electric';
Ymax='electric';
Zmin='electric';
Zmax='electric';
CstDefineOpenBoundary(mws,min_frec,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax)


% Guía de onda --------------
Name = 'base';
component = 'component1';
material = 'PEC';
Xrange = [0 w_T];
Yrange = [0 l];
Zrange = [z0 z1];
Cstbrick(mws, Name, component, material, Xrange, Yrange, Zrange)

Name = 'top';
component = 'component2';
material = 'PEC';
Xrange = [0 w_T];
Yrange = [0 l];
Zrange = [z2 z3];
Cstbrick(mws, Name, component, material, Xrange, Yrange, Zrange)


% Pines
Name = 'pin_i';
component = 'component1';
material = 'PEC';
Xrange = [p p+a];
Yrange = [0 a];
Zrange = [z1 d];
Cstbrick(mws, Name, component, material, Xrange, Yrange, Zrange)

model_to_translate = {Name; component; material; Xrange; Yrange; Zrange};
direction = [p, 0, 0];
number_of_step = 2;
name_models = pin_copy( model_to_translate, direction, number_of_step, mws);

models_name = [Name, name_models];

direction = [0, p, 0];
Name = strcat(Name, '0');
number_of_step = 9;
model_to_translate = {Name; component; material; Xrange; Yrange; Zrange};
models_name_1 = pin_copy( model_to_translate, direction, number_of_step, mws);

models_name = [models_name, models_name_1];

for idx = 1:length(name_models)
    Xrange_n = Xrange + p*(idx);
    Name = name_models{idx};
    model_to_translate = {Name; component; material; Xrange_n; Yrange; Zrange};
    direction = [0, p, 0];
    number_of_step = 9;
    models_name_1 = pin_copy( model_to_translate, direction, number_of_step, mws);
    models_name = [models_name, models_name_1];
end


% Pines
Name = 'pin_d';
component = 'component1';
material = 'PEC';
Xrange = [3*p+a+w 3*p+a+w+a];
Yrange = [0 a];
Zrange = [z1 d];
Cstbrick(mws, Name, component, material, Xrange, Yrange, Zrange)

model_to_translate = {Name; component; material; Xrange; Yrange; Zrange};
direction = [p, 0, 0];
number_of_step = 2;
name_models = pin_copy( model_to_translate, direction, number_of_step, mws);

models_name = [models_name, Name, name_models];

direction = [0, p, 0];
Name = strcat(Name, '0');
number_of_step = 9;
model_to_translate = {Name; component; material; Xrange; Yrange; Zrange};
models_name_1 = pin_copy( model_to_translate, direction, number_of_step, mws);

models_name = [models_name, models_name_1];

for idx = 1:length(name_models)
    Xrange_n = Xrange + p*(idx);
    Name = name_models{idx};
    model_to_translate = {Name; component; material; Xrange_n; Yrange; Zrange};
    direction = [0, p, 0];
    number_of_step = 9;
    models_name_1 = pin_copy( model_to_translate, direction, number_of_step, mws);
    models_name = [models_name, models_name_1];
end


for idx = 1:length(models_name)
    Name = models_name{idx};
    component2 = strcat('component1:', Name); 
    component1 = 'component1:base';
    CstAdd(mws,component1,component2)
end

% Puertos ---------------
PortNumber = 1;
Xrange = [3*p+a 3*p+a+w];
Yrange = [0 0];
Zrange = [z1 z2];
XrangeAdd = [0 0];
YrangeAdd = [0 0];
ZrangeAdd = [0 0];
CstWaveguidePort(mws,PortNumber, Xrange, Yrange, Zrange, XrangeAdd, YrangeAdd, ZrangeAdd, 'Free', 'positive', 'Y')

PortNumber = 2;
Xrange = [3*p+a 3*p+a+w];
Yrange = [l l];
Zrange = [z1 z2];
XrangeAdd = [0 0];
YrangeAdd = [0 0];
ZrangeAdd = [0 0];
CstWaveguidePort(mws,PortNumber, Xrange, Yrange, Zrange, XrangeAdd, YrangeAdd, ZrangeAdd, 'Free', 'xmax', 'Y')

% Filtro -----------------

% Solucionador ---------------

%Saves the project
CstSaveProject(mws)

CstDefineTimedomainSolver(mws,-40)

exportpath = 'C:\Users\Ariel\OneDrive\Documents\cst\Data\a2.txt';
CstExportSparametersTXT(mws, exportpath)






