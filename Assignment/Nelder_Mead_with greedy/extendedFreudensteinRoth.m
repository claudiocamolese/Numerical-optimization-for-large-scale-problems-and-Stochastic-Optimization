function F = extendedFreudensteinRoth(simplex)
    [n, m] = size(simplex);
    F = zeros(m, 1);
    
    for i = 1:m
        x = simplex(:, i); 
        Fi = 0;

        for k = 1:n
            if mod(k, 2) == 1 
                if k == n
                    fk = x(k) - 13;
                else
                    fk = x(k) + ((5 - x(k+1)) * x(k+1) - 2) * x(k+1) - 13;
                end
            else 
                fk = x(k-1) + ((x(k) + 1) * x(k) - 14) * x(k) - 29;
            end
            Fi = Fi + 0.5 * fk^2;
        end

        F(i) = Fi;
    end
end