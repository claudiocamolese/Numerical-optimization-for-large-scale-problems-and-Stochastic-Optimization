function H = extended_rosenbrock_hessian(x)
    n = size(x, 1); % Numero di dimensioni
    vectDiag0 = zeros(1, n);
    vectDiag1 = zeros(1, n-1);
    
    for k = 1:n
        if mod(k, 2) == 1
            vectDiag0(k)= 600*x(k)^2-200*x(k+1);
            if k < n
                vectDiag1(k)=-200*x(k);
            end
        else 
            vectDiag0(k)= 100;
        end
    end
    H = sparse(1:n,1:n,vectDiag0,n,n) + sparse(2:n,1:n-1,vectDiag1,n,n) + sparse(1:n-1,2:n,vectDiag1,n,n);
end

