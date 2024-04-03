% Creación de filtros GGW en CST
clc
clear

addpath('Functions');
addpath(genpath('Lib/CST-MATLAB-API-master'));
cst = actxserver('CSTStudio.application');

for IdFilter=41:500
    % Control de CST
    mws = cst.invoke('NewMWS');
    CstDefaultUnits(mws)
    
    min_frec = 8.0;
    max_frec = 20.0;
    CstDefineFrequencyRange(mws, min_frec, max_frec)
    
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
    
    CreateGgwWaveguide(mws, a, p, w, h, d);
    
    % Puertos ---------------
    PortNumber = 1;
    Xrange = [3*p+a 3*p+a+w];
    Yrange = [0 0];
    Zrange = [z1 z2];
    XrangeAdd = [0 0];
    YrangeAdd = [0 0];
    ZrangeAdd = [0 0];
    CstWaveguidePort2(mws,PortNumber, Xrange, Yrange, Zrange, XrangeAdd, YrangeAdd, ZrangeAdd, 'Free', 'positive', 'Y')
    
    PortNumber = 2;
    Xrange = [3*p+a 3*p+a+w];
    Yrange = [l l];
    Zrange = [z1 z2];
    XrangeAdd = [0 0];
    YrangeAdd = [0 0];
    ZrangeAdd = [0 0];
    CstWaveguidePort2(mws,PortNumber, Xrange, Yrange, Zrange, XrangeAdd, YrangeAdd, ZrangeAdd, 'Free', 'xmax', 'Y')
    
    % Boundary
    Xmin='open';
    Xmax='open';
    Ymin='electric';
    Ymax='electric';
    Zmin='electric';
    Zmax='electric';
    CstDefineOpenBoundary(mws,min_frec,Xmin,Xmax,Ymin,Ymax,Zmin,Zmax)
    
    % Parámetros del filtro
    w_div = 8; % divisiones del ancho  8, 16
    l_div = 24; % divisiones del largo  24, 48
    PeriodicParameters = 6; % 2, 4, 6, 8
    PeriodicPin = 2;
    PinFilter = PeriodicPin * l_div/PeriodicParameters;  % Max w_div/2*l_div (96)
    MaxHeight = d*2/3; % Altura máxima de los pines del filtro
    
    MatrixFilter = GenerateFilterMatriz(w_div, l_div, PeriodicParameters, PeriodicPin, MaxHeight);
    
    CreateFilter(mws, w_div, l_div, MatrixFilter, w, l, p, a, z1 )
    
    % Solucionador ---------------
    %Saves the project
    CstSaveProject(mws)
    CstDefineTimedomainSolver(mws,-40)
%     
% %     IdFilter = 1;
    TxtName = strcat('Filter_', num2str(PeriodicParameters), '_', num2str(PeriodicPin), '_', num2str(IdFilter));
    exportpath_b = fileparts(mfilename('fullpath'));
    exportpath = strcat(exportpath_b, '\Dataset\', TxtName, '.txt'); 
    CstExportSparametersTXT2(mws, exportpath)
    TxtName = strcat('Matriz_', num2str(PeriodicParameters), '_', num2str(PeriodicPin), '_', num2str(IdFilter));
    exportpath = strcat(exportpath_b, '\Dataset\', TxtName, '.mat'); 
    save(exportpath,'MatrixFilter')
    CstQuitProject(mws)

    IdFilter
end




