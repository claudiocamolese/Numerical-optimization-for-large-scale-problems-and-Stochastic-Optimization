function grad = problem76_grad(x)
    n = size(x, 1); % Numero di dimensioni
    grad = zeros(n, 1); % Inizializzazione dell'Hessiana
    x=[x(n); x;x(1)];
    for k = 2:n+1
        grad(k-1)= (x(k)^3)/50 - (x(k)*x(k-1))/5 + x(k) -(x(k+1)^2)/10;
    end
end

