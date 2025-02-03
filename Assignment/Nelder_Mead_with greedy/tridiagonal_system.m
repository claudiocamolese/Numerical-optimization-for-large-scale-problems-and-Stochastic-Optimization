function F = tridiagonal_system(x)
    [n, m] = size(x);  % n = dimensione, m = numero di punti nel simplex

    if n == 1 || m == 1
        % Caso di un singolo vettore
        F = compute_tridiagonal(x(:));
    else
        % Caso di un simplex: calcolo F per ogni colonna
        F = zeros(1, m);
        for j = 1:m
            F(j) = compute_tridiagonal(x(:, j));
        end
    end
end

function F = compute_tridiagonal(x)
    n = length(x);       % Definiamo n
    F = 0;               % Inizializziamo F

    % Calcolo di F(x)
    for k = 1:n
        if k == 1
            fk = 4 * (x(k) - x(k)^2 - x(k + 1));
        elseif k == n
            fk = 8 * x(k) * (x(k)^2 - x(k - 1)) - 2 * (1 - x(k));
        else
            fk = 8 * x(k) * (x(k)^2 - x(k - 1)) - 2 * (1 - x(k)) + 4 * (x(k) - x(k)^2 - x(k + 1));
        end
        F = F + 0.5 * fk^2;
    end
end
