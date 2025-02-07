function F = boundary_problem(x)
    % Assumiamo che x sia un vettore colonna di dimensione (n x 1)
    n = length(x);
    h = 1 / (n + 1);

    x = [0; x; 0]; % Aggiungi le condizioni al contorno x0 = xn+1 = 0

    F = 0; % Inizializza il valore di F

    for i = 1:n
        term = 2 * x(i+1) - x(i) - x(i+2) + (h^2) * ((x(i+1) + i*h*(1 - i*h) + 1)^3 / 2);
        F = F + term^2;
    end
end
