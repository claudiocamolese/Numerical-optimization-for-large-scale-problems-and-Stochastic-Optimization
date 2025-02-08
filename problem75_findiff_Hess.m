function [H] = problem75_findiff_Hess(f, x, h)
    n = length(x);
    Hessf0 = zeros(1, n);   % Inizializza le diagonali
    Hessf1 = zeros(1, n-1); % Inizializza le off-diagonali

    for j = 1:n
        % Calcolo delle derivate seconde sulla diagonale
        x_plus = x;
        x_plus(j) = x_plus(j) + h;
        x_minus = x;
        x_minus(j) = x_minus(j) - h;
        Hessf0(j) = (f(x_plus) - 2*f(x) + f(x_minus)) / h^2;
        
        % Calcolo delle derivate miste per le off-diagonali (solo se j < n)
        if j < n
        i=j+1;
        xh_plus_ij = x;
        xh_plus_ij([i, j]) = xh_plus_ij([i, j]) + h;
        xh_plus_i = x;
        xh_plus_i(i) = xh_plus_i(i) + h;
        xh_plus_j = x;
        xh_plus_j(j) = xh_plus_j(j) + h;
        Hessf1(j) = (f(xh_plus_ij) - ...
            f(xh_plus_i) - f(xh_plus_j) + f(x))/(h^2);
        end
    end

    % Costruzione della matrice sparsa Hessiana
    H = sparse(1:n, 1:n, Hessf0, n, n) + ...
        sparse(2:n, 1:n-1, Hessf1, n, n) + ...
        sparse(1:n-1, 2:n, Hessf1, n, n);
end