function CreateFilter(mws, w_div, l_div, MatrixFilter, w, l, p, a, z1 )
    % Filtro -----------------
    NameFilter = 'pin_f';
    for i=1:w_div
        for j=1:l_div
            if MatrixFilter(i,j) == 0
                continue
            end
            stepX = w/w_div;
            stepY = l/l_div;
            Name = strcat(NameFilter, num2str(i), num2str(j));
            component = 'component1';
            material = 'PEC';
            Xrange = [3*p+a + (i-1)*stepX, 3*p+a + i*stepX];
            Yrange = [(j-1)*stepY, j*stepY];
            Zrange = [z1 MatrixFilter(i,j)];
            Cstbrick2(mws, Name, component, material, Xrange, Yrange, Zrange)
    
            component2 = strcat('component1:', Name); 
            component1 = 'component1:base';
            CstAdd(mws,component1,component2)
        end
    end
end