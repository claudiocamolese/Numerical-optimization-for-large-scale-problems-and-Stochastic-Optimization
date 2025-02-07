function F_vals = compute_F_ascher(simplex)
    % Computes the function F(x) for each row in the simplex.
    % Input:
    %   simplex: A matrix where each row represents a point in n-dimensional space.
    % Output:
    %   F_vals: A column vector containing F(x) values for each row.

    [m, n] = size(simplex); % Number of points (m) and dimensions (n)
    F_vals = zeros(m, 1);   % Initialize output vector
    h = 1 / (n + 1);        % Step size

    for t = 1:m
        x = simplex(t, :);  
        x = [0, x, 1/2]; % Apply boundary conditions: x_0 = 0, x_(n+1) = 1/2

        f_k = zeros(n, 1); % Initialize f_k values

        for k = 1:n
            term1 = 2 * x(k+1);
            term2 = -2 * h^2 * (x(k+1)^2 + (x(k+2) - x(k)) / (2*h));
            term3 = - x(k) - x(k+2);
            
            f_k(k) = term1 + term2 + term3;
        end
        
        % Compute F(x)
        F_vals(t) = 0.5 * sum(f_k .^ 2);
    end
end