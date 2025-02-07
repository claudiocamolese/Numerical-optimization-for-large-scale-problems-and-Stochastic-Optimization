function grad = compute_F_ascher_grad(x)
    % Computes the function F(x) for a given column vector x.
    % Input:
    %   x: A column vector representing a point in n-dimensional space.
    % Output:
    %   F_val: A scalar representing the computed F(x).

    n = size(x, 1); % Numero di dimensioni
    h = 1 / (n + 1); % Step size
    grad = zeros(n, 1); % Inizializzazione dell'Hessiana
    
    for k = 1:n
        if k == 1
            grad(k) = 0.5*(1 + h - 4*h^2*x(k));
        elseif k == n
            grad(k) = 0.5*(1 - h - 4*h^2*x(k));
        else
            grad(k) = - 2*h^2 *x(k);
        end
    end
end
