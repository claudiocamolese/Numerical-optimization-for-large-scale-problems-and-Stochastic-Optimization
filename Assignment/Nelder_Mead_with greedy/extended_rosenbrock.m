function F = extended_rosenbrock(x)
    n = size(x, 2); % Numero di dimensioni
    F_k = zeros(size(x, 1), n); % Inizializzazione dei valori della funzione
    
    for k = 1:n
        if mod(k, 2) == 1
            % Se k è dispari
            if k < n
                F_k(:, k) = 10 * (x(:, k).^2 - x(:, k+1));
            end
        else
            % Se k è pari
            F_k(:, k) = x(:, k-1) - 1;
        end
    end
    
    F = 0.5 * sum(F_k.^2, 2);
end