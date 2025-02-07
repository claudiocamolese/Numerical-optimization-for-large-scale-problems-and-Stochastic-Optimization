function F = extended_rosenbrock(x)
    % x è un vettore riga di dimensione n
    [m,n] = size(x);
    F_k = zeros(1, n); % Inizializzazione dei valori della funzione
    
    for k = 1:m
        if mod(k, 2) == 1
            % Se k è dispari
            if k < m
                F_k(k) = 10 * (x(k)^2 - x(k+1));
            else
                F_k(k)= 10*(x(k)^2);
            end
        else
            % Se k è pari
            F_k(k) = x(k-1) - 1;
        end
    end
    
    F = 0.5 * sum(F_k.^2); % Calcolo del valore scalare della funzione
end