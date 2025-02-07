function F_vals = problem76(X)
    % X: matrice m x n, dove ogni riga è un punto del simplex in R^n
    % Restituisce un vettore colonna con il valore F(x) per ogni riga del simplex
    
    [m, n] = size(X); % m: numero di punti, n: dimensione dello spazio
    F_vals = zeros(m, 1); % Preallocazione del vettore risultato
    
    for i = 1:m
        x = X(i, :); % Prendo la i-esima riga del simplex
        fk = zeros(n, 1); % Preallocazione di f_k
        
        for k = 1:n-1
            fk(k) = x(k) - (x(k+1)^2) / 10;
        end
        fk(n) = x(n) - (x(1)^2) / 10;
        
        % Calcolo F(x) = 1/2 * sum(fk.^2)
        F_vals(i) = 0.5 * sum(fk.^2);
    end
end
