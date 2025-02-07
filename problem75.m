function F = problem75(x)
    % Assumiamo che x sia un vettore colonna di dimensione (n x 1)
    n = length(x);
    
    f_k = zeros(n, 1); % Inizializza f_k come vettore colonna
    
    % Definizione di f_k secondo il problema
    f_k(1) = x(1) - 1; % Caso k = 1
    for i = 2:n
        f_k(i) = 10 * (i - 1) * (x(i) - x(i - 1))^2; % Caso 1 < k ≤ n
    end
    
    % Calcola F(x) come scalare
    F = 0.5 * sum(f_k.^2);
end
