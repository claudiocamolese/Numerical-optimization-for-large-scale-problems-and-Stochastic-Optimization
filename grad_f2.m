function grad = grad_f2(x)
    n = length(x);
    grad = zeros(n, 1);
    
    for k = 1:n
        if k == 1
            fk = (3 - 2*x(k)) * x(k) - 2*x(k+1) + 1;
            dfkdxk = 2 * fk * (3 - 4*x(k));
            dfkdxkp1 = -4 * fk;
            grad(k) = grad(k) + dfkdxk;
            grad(k+1) = grad(k+1) + dfkdxkp1;
        elseif k < n
            fk = (3 - 2*x(k)) * x(k) - x(k-1) - 2*x(k+1) + 1;
            dfkdxk = 2 * fk * (3 - 4*x(k));
            dfkdxkm1 = -2 * fk;
            dfkdxkp1 = -4 * fk;
            grad(k) = grad(k) + dfkdxk;
            grad(k-1) = grad(k-1) + dfkdxkm1;
            grad(k+1) = grad(k+1) + dfkdxkp1;
        else % k == n
            fk = (3 - 2*x(k)) * x(k) - x(k-1) + 1;
            dfkdxk = 2 * fk * (3 - 4*x(k));
            dfkdxkm1 = -2 * fk;
            grad(k) = grad(k) + dfkdxk;
            grad(k-1) = grad(k-1) + dfkdxkm1;
        end
    end
end