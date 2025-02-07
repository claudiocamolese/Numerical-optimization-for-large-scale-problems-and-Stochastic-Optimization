function F_val = problem76_newton(x)
    % x: vettore colonna di dimensione (n x 1)
    % Restituisce il valore scalare di F(x)

    n = length(x); % Dimensione del vettore
    fk = zeros(n, 1); % Preallocazione del vettore fk
    
    for k = 1:n-1
        fk(k) = x(k) - (x(k+1)^2) / 10;
    end
    fk(n) = x(n) - (x(1)^2) / 10;
    
    % Calcolo F(x) = 1/2 * sum(fk.^2)
    F_val = 0.5 * sum(fk.^2);
end
