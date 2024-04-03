function CreateGgwWaveguide(mws, a, p, w, h, d)

    % Parámetros de la línea
    % a = 2; %ancho del pin
    % p = 6; %separacion entre pin
    % w = 19.05; %ancho de la pista
    % h = 1.525; % separacion del pnin con la tapa
    % d = 8; % altura del pin
    
    l = 9*p + a;
    w_T = 6*p +2*a + w;
    z0 = -p;
    z1 = 0;
    z2 = d + h;
    z3 = d + h + p;
    
    % Guía de onda --------------
    Name = 'base';
    component = 'component1';
    material = 'PEC';
    Xrange = [0 w_T];
    Yrange = [0 l];
    Zrange = [z0 z1];
    Cstbrick2(mws, Name, component, material, Xrange, Yrange, Zrange)
    
    Name = 'top';
    component = 'component2';
    material = 'PEC';
    Xrange = [0 w_T];
    Yrange = [0 l];
    Zrange = [z2 z3];
    Cstbrick2(mws, Name, component, material, Xrange, Yrange, Zrange)
    
    NamePinLefth = 'pin_i';
    for i=1:3
        for j=1:10
            Name = strcat(NamePinLefth, num2str(i), num2str(j));
            component = 'component1';
            material = 'PEC';
            Xrange = [i*p, i*p+a];
            Yrange = [(j-1)*p, (j-1)*p+a];
            Zrange = [z1, d];
            Cstbrick2(mws, Name, component, material, Xrange, Yrange, Zrange)
    
            component2 = strcat('component1:', Name); 
            component1 = 'component1:base';
            CstAdd(mws,component1,component2)
        end
    end
    NamePinRight = 'pin_r';
    for i=1:3
        for j=1:10
            Name = strcat(NamePinRight, num2str(i), num2str(j));
            component = 'component1';
            material = 'PEC';
            Xrange = [(i+2)*p+a+w, (i+2)*p+a+w+a];
            Yrange = [(j-1)*p, (j-1)*p+a];
            Zrange = [z1, d];
            Cstbrick2(mws, Name, component, material, Xrange, Yrange, Zrange)
    
            component2 = strcat('component1:', Name); 
            component1 = 'component1:base';
            CstAdd(mws,component1,component2)
        end
    end

end