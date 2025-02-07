function F = broyden_tridiagonal(x)
    [n, m] = size(x);  % n = dimensione, m = numero di punti nel simplex

    if n == 1 || m == 1
        % Caso di un singolo vettore
        F = compute_broyden(x(:));
    else
        % Caso di un simplex: calcolo F per ogni colonna
        F = zeros(1, m);
        for j = 1:n
            F(j) = compute_broyden(x(j, :));
        end
    end
end

function F = compute_broyden(x)
    n = length(x);       % Definiamo m = n
    F = 0;               % Inizializziamo F

    % Aggiungiamo x0 e xn+1 come da definizione
    x_ext = [0; x(:); 0];  % x0 = 0, xn+1 = 0

    % Calcolo di F(x)
    for k = 1:n
        fk = (3 - 2 * x_ext(k + 1)) * x_ext(k + 1) - x_ext(k) - 2 * x_ext(k + 2) + 1;
        F = F + 0.5 * fk^2;
    end
end
