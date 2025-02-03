function F = brent_function(X)
    % X è un simplex di n dimensioni con ogni riga orizzontale come un vettore
    [m, n] = size(X);  % m è il numero di punti nel simplex, n è la dimensione
    
    F = zeros(m, 1);  % Inizializza il vettore F
    
    for i = 1:m  % Per ogni riga del simplex
        x = X(i, :);  % Ottieni il vettore x per il punto corrente
        
        f_sum = 0;  % Somma dei quadrati di f_k(x)
        
        % Calcola la somma di f_k^2(x)
        for k = 1:n
            if k == 1
                fk = 3*x(k)*(x(k+1) - 2*x(k)) + x(k)^2 + 1/4;
            elseif k == n
                fk = 3*x(k)*(20 - 2*x(k) + x(k-1)) + (20 - x(k-1))^2 / 4;
            else
                fk = 3*x(k)*(x(k+1) - 2*x(k) + x(k-1)) + (x(k+1) - x(k-1))^2 / 4;
            end
            
            f_sum = f_sum + fk^2;  % Aggiungi il quadrato di f_k(x) alla somma
        end
        
        % Calcola F(x) per il punto corrente
        F(i) = 0.5 * f_sum;
    end
end
