function G = extended_rosenbrock_grad(x)
    n = size(x, 1); % Numero di dimensioni
    G = zeros(n,1); % Inizializzazione del gradiente
    
    for k = 1:n
        if mod(k, 2) == 1
            % Se k è dispari
            if k < n
                G(k) = 0.5*(200*(x(k)^2-x(k+1))*2*x(k)+2*(x(k)-1)); % Derivata rispetto a x_k
            
            else
                G(k)= 0.5*400*x(k)^3;
            end
        else
            G(k)=-0.5*(200*(x(k-1)^2-x(k)));
        end
    end
end
