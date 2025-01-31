function hess = Hess_f2(x)
    n = length(x);
    hess = zeros(n, n);
    
    for k = 1:n
        if k == 1
            fk = (3 - 2*x(k)) * x(k) - 2*x(k+1) + 1;
            dfkdxk = 6 - 12*x(k);
            dfkdxkp1 = -4;
            hess(k, k) = hess(k, k) + 2 * dfkdxk;
            hess(k, k+1) = hess(k, k+1) + 2 * dfkdxkp1;
            hess(k+1, k) = hess(k+1, k) + 2 * dfkdxkp1;
        elseif k < n
            fk = (3 - 2*x(k)) * x(k) - x(k-1) - 2*x(k+1) + 1;
            dfkdxk = 6 - 12*x(k);
            dfkdxkm1 = -2;
            dfkdxkp1 = -4;
            hess(k, k) = hess(k, k) + 2 * dfkdxk;
            hess(k, k-1) = hess(k, k-1) + 2 * dfkdxkm1;
            hess(k, k+1) = hess(k, k+1) + 2 * dfkdxkp1;
            hess(k-1, k) = hess(k-1, k) + 2 * dfkdxkm1;
            hess(k+1, k) = hess(k+1, k) + 2 * dfkdxkp1;
        else % k == n
            fk = (3 - 2*x(k)) * x(k) - x(k-1) + 1;
            dfkdxk = 6 - 12*x(k);
            dfkdxkm1 = -2;
            hess(k, k) = hess(k, k) + 2 * dfkdxk;
            hess(k, k-1) = hess(k, k-1) + 2 * dfkdxkm1;
            hess(k-1, k) = hess(k-1, k) + 2 * dfkdxkm1;
        end
    end
end