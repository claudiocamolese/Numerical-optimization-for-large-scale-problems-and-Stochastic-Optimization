function F = problem75(simplex)
    
    [n, m] = size(simplex);
    F = zeros(m, 1); 

    for k = 1:m
        x = simplex(:, k);
        f_k = zeros(1, n);
        f_k(1) = x(1) - 1;
        for i = 2:n
            f_k(i) = 10 * (i - 1) * (x(i) - x(i - 1))^2; 
        end
        F(k) = 0.5 * sum(f_k.^2);
    end
end
