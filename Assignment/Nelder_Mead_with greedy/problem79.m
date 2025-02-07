function F_vals = problem79(simplex)
    % Computes the function F(x) for each row in the simplex.
    % Input:
    %   simplex: A matrix where each row represents a point in n-dimensional space.
    % Output:
    %   F_vals: A column vector containing F(x) values for each row.

    [m, n] = size(simplex); % Number of points (m) and dimensions (n)
    F_vals = zeros(m, 1);   % Initialize output vector
    
    for i = 1:m
        x = simplex(i, :);  % Current point
        x = [0, x, 0];      % Apply boundary conditions: x_0 = x_(n+1) = 0

        % Compute f_k(x) for k = 1 to n
        f_k = (3 - x(2:n+1) / 10) .* x(2:n+1) + 1 - x(1:n) - 2 * x(3:n+2);

        % Compute F(x)
        F_vals(i) = 0.5 * sum(f_k .^ 2);
    end
end