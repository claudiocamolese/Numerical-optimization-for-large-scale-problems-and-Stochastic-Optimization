function F = extendedFreudensteinRoth(simplex)
    % La matrice simplex ha dimensione (m x n)
    [m, n] = size(simplex);

    % Inizializzazione del vettore dei risultati
    F = zeros(m, 1);

    % Calcolo per ogni punto del simplex
    for i = 1:m
        x = simplex(i, :); % Estrai il vettore della riga i
        Fi = 0;            % Inizializza il valore della funzione per il punto corrente

        for k = 1:n
            if mod(k, 2) == 1  % Indice dispari
                if k == n
                    fk = x(k) - 13;
                else
                    fk = x(k) + ((5 - x(k+1)) * x(k+1) - 2) * x(k+1) - 13;
                end
            else               % Indice pari
                fk = x(k-1) + ((x(k) + 1) * x(k) - 14) * x(k) - 29;
            end
            Fi = Fi + 0.5 * fk^2;
        end

        F(i) = Fi; % Assegna il risultato al vettore F
    end
end