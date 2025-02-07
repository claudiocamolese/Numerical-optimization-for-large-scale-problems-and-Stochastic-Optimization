function H = compute_F_ascher_hessian(x)
    % Computes the function F(x) for a given column vector x.
    % Input:
    %   x: A column vector representing a point in n-dimensional space.
    % Output:
    %   F_val: A scalar representing the computed F(x).

    n = size(x, 1); % Numero di dimensioni
    h = 1 / (n + 1); % Step size
    H = spdiags(-2*h^(2)*ones(n,1),0,n,n); % Inizializzazione dell'Hessiana
    
end
