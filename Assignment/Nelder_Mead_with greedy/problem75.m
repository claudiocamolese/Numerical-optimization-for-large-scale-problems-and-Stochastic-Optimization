function F = problem75(simplex)
    % Assumiamo che simplex sia una matrice (m x n) dove m è il numero di punti (righe)
    % e n è la dimensione del simplex.
    
    [m, n] = size(simplex);
    F = zeros(m, 1); % Inizializza il vettore F

    for k = 1:m
        x = simplex(k, :); % Estrai la k-esima riga del simplex
        f_k = zeros(1, n); % Inizializza f_k per la riga corrente
        
        % Definizione di f_k secondo il problema
        f_k(1) = x(1) - 1; % Caso k = 1
        for i = 2:n
            f_k(i) = 10 * (i - 1) * (x(i) - x(i - 1))^2; % Caso 1 < k ≤ n
        end
        
        % Calcola F(x) per la riga corrente
        F(k) = 0.5 * sum(f_k.^2);
    end
end
