function F_val = compute_F_ascher(x)
    % Computes the function F(x) for a given column vector x.
    % Input:
    %   x: A column vector representing a point in n-dimensional space.
    % Output:
    %   F_val: A scalar representing the computed F(x).

    n = length(x);   % Number of dimensions
    h = 1 / (n + 1); % Step size

    x = [0; x; 1/2]; % Apply boundary conditions: x_0 = 0, x_(n+1) = 1/2

    f_k = zeros(n, 1); % Initialize f_k values

    for k = 1:n
        term1 = 2 * x(k+1);
        term2 = -2 * h^2 * (x(k+1)^2 + (x(k+2) - x(k)) / (2*h));
        term3 = - x(k) - x(k+2);
        
        f_k(k) = term1 + term2 + term3;
    end
    
    % Compute F(x)
    F_val = 0.5 * sum(f_k .^ 2);
end
