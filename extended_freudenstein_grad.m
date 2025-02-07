function grad = extended_freudenstein_grad(x)
    n = size(x, 1); % Numero di dimensioni
    grad = zeros(n, 1); % Inizializzazione dell'Hessiana
    
    for k = 1:n
        if mod(k, 2) == 1
            
            if k < n
                grad(k)= x(k)+((5-x(k+1))*x(k+1)-2)*x(k+1)-13 + x(k)+((x(k+1)+1)*x(k+1)-14)*x(k+1)-29;
            else
                grad(k)= x(k)-13 + x(k)-29;
            end
        else 
            grad(k)=6*x(k)^5 -20*x(k)^4 +  4 *x(k)^3 -120*x(k)^2 +12*x(k) +12*x(k)*x(k-1) -16*x(k-1) +432;
        end
    end
end

