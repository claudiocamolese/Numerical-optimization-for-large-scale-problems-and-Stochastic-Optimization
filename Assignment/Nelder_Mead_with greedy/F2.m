function F = F2(simplex)
    [n, m] = size(simplex); % n è la dimensione dei punti, m è il numero di punti (n+1)
    F = zeros(1, m); % Inizializza il vettore di output

    for j = 1:m % Itera su ogni punto del simplex
        x = simplex(:, j); % Estrai la j-esima colonna, che rappresenta un punto
        f_value = 0;

        for k = 1:n
            if k == 1
                fk = ( (3 - 2*x(k)) * x(k) - 2*x(k+1) + 1 )^2;
            elseif k < n
                fk = ( (3 - 2*x(k)) * x(k) - x(k-1) - 2*x(k+1) + 1 )^2;
            else % k == n
                fk = ( (3 - 2*x(k)) * x(k) - x(k-1) + 1 )^2;
            end
            f_value = f_value + 0.5 * fk;
        end

        F(j) = f_value; % Salva il valore della funzione per il punto j
    end
end