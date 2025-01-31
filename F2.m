function F = F2(x)
    n = length(x);
    F = 0;
    
    for k = 1:n
        if k == 1
            fk = ( (3 - 2*x(k)) * x(k) - 2*x(k+1) + 1 )^2;
        elseif k < n
            fk = ( (3 - 2*x(k)) * x(k) - x(k-1) - 2*x(k+1) + 1 )^2;
        else % k == n
            fk = ( (3 - 2*x(k)) * x(k) - x(k-1) + 1 )^2;
        end
        F = F + 0.5 * fk;
    end
end