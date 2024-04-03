function MatrixFilter = GenerateFilterMatriz(w_div, l_div, PeriodicParameters, PariodicPin, MaxHeight)
    % Parámetros del filtro
    %w_div = 8;  divisiones del ancho  8, 16
    %l_div = 24;  divisiones del largo  24, 48
    
    % Matriz 8 X 24 con el parámetro Z de los pines internos
    % Simétrico respecto al ancho por lo que se define solamente 4 X 24
    % PeriodicParameters = 8; % 2, 4, 6, 8
    % PariodicPin = 2;   
    % MaxHeight = d; % Altura máxima de los pines del filtro
    
    RandomPin = rand(PariodicPin) * MaxHeight;
    
    if PeriodicParameters ~= 1
        MatrixPeriodic = zeros(w_div/2, PeriodicParameters);
        value = randperm(w_div/2*PeriodicParameters, PariodicPin);
        for i=1:PariodicPin
            MatrixPeriodic(value(i)) = RandomPin(i);
        end
    
        MatrixFilter = cat(2, MatrixPeriodic, MatrixPeriodic);
        for i=3:l_div/PeriodicParameters
            MatrixFilter = cat(2, MatrixFilter, MatrixPeriodic);
        end
        MatrixFilter = cat(1, MatrixFilter, MatrixFilter(end:-1:1, :));
    end
end