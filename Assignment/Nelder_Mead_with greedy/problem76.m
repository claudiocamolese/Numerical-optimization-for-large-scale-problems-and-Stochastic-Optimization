function F_vals = problem76(X)
    
    [n, m] = size(X); 
    F_vals = zeros(m, 1); 
    
    for i = 1:m
        x = X(:, i);
        fk = zeros(n, 1); 
        
        for k = 1:n-1
            fk(k) = x(k) - (x(k+1)^2) / 10;
        end
        
        fk(n) = x(n) - (x(1)^2) / 10;
        F_vals(i) = 0.5 * sum(fk.^2);
    end
end
