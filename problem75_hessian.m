function H = problem75_hessian(x)
    n = size(x, 1); % Numero di dimensioni
%     h = 1 / (n + 1); % Step size
    vectDiag0 = zeros(1,n);
    vectDiag1 = zeros(1,n-1);
    
    for k = 1:n
        if k == 1
            vectDiag0(k) = (10*k)+1;
            vectDiag1(k) = -10*k;
        elseif k == n
            vectDiag0(k) = 10*k;
        else
            vectDiag0(k) = 10*(k-1) + 10*k;
            vectDiag1(k) = -10*k;
        end
    end
    H = sparse(1:n,1:n,vectDiag0,n,n) + sparse(2:n,1:n-1,vectDiag1,n,n) + sparse(1:n-1,2:n,vectDiag1,n,n);
end
