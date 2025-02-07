function F = extendedFreudensteinRoth(x)
    % La matrice simplex ha dimensione (m x n)
    [m, n] = size(x);

    % Inizializzazione del vettore dei risultati
    F = zeros(1,n);

        for k = 1:m
            if mod(k, 2) == 1  % Indice dispari
                if k == m
                    fk = x(k) - 13;
                else
                    fk = x(k) + ((5 - x(k+1)) * x(k+1) - 2) * x(k+1) - 13;
                end
            else               % Indice pari
                fk = x(k-1) + ((x(k) + 1) * x(k) - 14) * x(k) - 29;
            end
             F = 0.5 * sum(fk.^2);
        end

end