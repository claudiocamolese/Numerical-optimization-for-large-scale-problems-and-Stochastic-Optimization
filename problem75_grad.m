function grad = problem75_grad(x)
    n = size(x, 1); % Numero di dimensioni
    grad = zeros(n, 1); % Inizializzazione dell'Hessiana
    
    for k = 1:n
        if k == 1
            grad(k) = x(k)-1 - 10 * (x(k+1)-x(k));
        elseif k == n
            grad(k) = 10 * (k-1) * (x(k)-x(k-1));
        else
            grad(k) = 10 * (k-1) * (x(k)-x(k-1)) - 10 * k *(x(k+1)-x(k));
        end
    end
end
