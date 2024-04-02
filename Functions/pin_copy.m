function name_models = pin_copy(model_to_translate, direction, number_of_step, mws)
    % pin_copy - Función para copiar y desplazar pines en una simulación CST.
    %
    % Syntax:  name_models = pin_copy(model_to_translate, direction, number_of_step)
    %
    % Inputs:
    %    model_to_translate - Cell Array - Contiene los parámetros del modelo original.
    %        model_to_translate(1,:) - String - Nombre del modelo original.
    %        model_to_translate(2,:) - String - Componente del modelo original.
    %        model_to_translate(3,:) - String - Material del modelo original.
    %        model_to_translate(4,:) - Array - Rango en X del modelo original.
    %        model_to_translate(5,:) - Array - Rango en Y del modelo original.
    %        model_to_translate(6,:) - Array - Rango en Z del modelo original.
    %    direction - Array - Dirección y magnitud del desplazamiento para las copias.
    %    number_of_step - Integer - Número de copias a realizar.
    %
    % Outputs:
    %    name_models - Cell Array - Contiene los nombres de los nuevos modelos creados.

    % Extrae los parámetros del modelo original
    Name = model_to_translate{1};
    component = model_to_translate{2};
    material = model_to_translate{3};
    Xrange = model_to_translate{4};
    Yrange = model_to_translate{5};
    Zrange = model_to_translate{6};
    
    % Inicializa el arreglo para almacenar los nombres de los modelos
    name_models = cell(1, number_of_step);
    
    % Realiza las copias
    for i = 1:number_of_step
        % Crea un nuevo nombre para el pin
        new_name = strcat(Name, num2str(i));
        
        % Calcula la nueva posición
        new_Xrange = Xrange + direction(1) * i;
        new_Yrange = Yrange + direction(2) * i;
        new_Zrange = Zrange + direction(3) * i;
        
        % Crea el nuevo pin en la nueva posición
        Cstbrick(mws, new_name, component, material, new_Xrange, new_Yrange, new_Zrange);
        
        % Almacena el nombre del nuevo modelo
        name_models{i} = new_name;
    end
end

