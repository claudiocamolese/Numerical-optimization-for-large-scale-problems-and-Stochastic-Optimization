function H = problem76_hessian(x)
    n = size(x, 1); % Numero di dimensioni
%     H = sparse(n, n); % Inizializzazione dell'Hessiana
    vectDiag0 = zeros(1, n);
    vectDiag1 = zeros(1, n-1);

    for k = 1:n
        if k > 1
            vectDiag0(k)=3/50*x(k)^2 -x(k-1)/5+1;
        else
            vectDiag0(k)=3/50*x(k)^2 -x(n)/5+1;
        end
        if k < n
            vectDiag1(k) = -x(k+1)/5;
        end
    end
    H = sparse(1:n,1:n,vectDiag0,n,n) + sparse(2:n,1:n-1,vectDiag1,n,n) + sparse(1:n-1,2:n,vectDiag1,n,n);
    H(1,n) = - x(1)/5;
    H(n,1) = -x(1)/5;
end


