function F = singular_broyden(X)
    [num_points, n] = size(X); % num_points = n+1 nel Simplex
    
    F = zeros(num_points, 1); % Inizializza il vettore dei valori della funzione
    
    for j = 1:num_points % Ciclo sui punti del simplex
        x = X(j, :); % Estrai il punto j-esimo
        
        F_j = 0; % Inizializza il valore della funzione per questo punto
        
        for k = 1:n
            if k == 1
                fk = ( (3 - 2*x(k)) * x(k) - 2*x(k+1) + 1 )^2;
            elseif k < n
                fk = ( (3 - 2*x(k)) * x(k) - x(k-1) - 2*x(k+1) + 1 )^2;
            else % k == n
                fk = ( (3 - 2*x(k)) * x(k) - x(k-1) + 1 )^2;
            end
            F_j = F_j + fk; % Somma i termini
        end
        
        F(j) = 0.5 * F_j; % Salva il valore calcolato per il punto j
    end
end