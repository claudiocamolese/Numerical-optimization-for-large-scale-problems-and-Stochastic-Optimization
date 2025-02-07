function H = extended_freudenstein_hessian(x)
    n = size(x, 1); % Numero di dimensioni
%     H = sparse(n, n); % Inizializzazione dell'Hessiana
    vectDiag0 = zeros(1, n);
    vectDiag1 = zeros(1, n-1);

    for k = 1:n
        if mod(k, 2) == 1
%             H(k,k)= 2;
                vectDiag0(k) = 2;
            if k < n
%                 H(k,k+1)=12*x(k+1)-16;
%                 H(k+1,k)=H(k,k+1);
                vectDiag1(k) = 12*x(k+1)-16;
            end
        else 
%             H(k,k)= 30*x(k)^4 -80*x(k)^3 +12*x(k)^2 -240*x(k) +12*x(k-1) +12;
            vectDiag0(k) = 30*x(k)^4 -80*x(k)^3 +12*x(k)^2 -240*x(k) +12*x(k-1) +12;
        end
    end
    H = sparse(1:n,1:n,vectDiag0,n,n) + sparse(2:n,1:n-1,vectDiag1,n,n) + sparse(1:n-1,2:n,vectDiag1,n,n);
    
end


