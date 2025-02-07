function F = boundary_problem(simplex)
    % Assumiamo che simplex sia una matrice (m x n) dove m è il numero di punti (righe)
    % e n è la dimensione del simplex.
    
    [m, n] = size(simplex);
    F = zeros(m, 1); % Inizializza il vettore F

    h = 1 / (n + 1);
    
    % Ciclo su ogni riga del simplex
    for k = 1:m
        x = [0, simplex(k, :), 0]; % Aggiungi le condizioni al contorno x0 = xn+1 = 0
        
        F_k = 0; % Inizializza il valore di F per questa riga
        for i = 1:n
            term = 2 * x(i+1) - x(i) - x(i+2) + (h^2) * ((x(i+1) + i*h*(1 - i*h) + 1)^3 / 2);
            F_k = F_k + term^2;
        end
        
        F(k) = F_k; % Memorizza il risultato per la riga corrente
    end
end
