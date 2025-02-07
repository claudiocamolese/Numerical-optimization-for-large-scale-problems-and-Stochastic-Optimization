function [xk, fk, execution_time, k] = nelder(x, n, rho, chi, gamma, sigma)
    
  % Funzione obiettivo da minimizzare (modificabile a piacere)
    % f = @(x) sum(100 * (x(:, 2:end) - x(:, 1:end-1).^2).^2 + (1 - x(:, 1:end-1)).^2, 2); % Rosenbrock
%      f = @(x) extended_rosenbrock(x);
    %f = @(x) extendedFreudensteinRoth(x);
    % f = @(x) brent_function(x);
%     f = @(x) compute_F_ascher(x);
    f = @(x) problem75(x);

    if n==2
        figure
        hold on
        fcontour(@(x, y) (3 - 2 * x) * x - 2 * y + 1, [-6, 6, -5, 5], 'LineWidth', 1.2); % Plotta le linee di livello
        colormap jet;
        title('Nelder-Mead Method');
        xlabel('x_1');
        ylabel('x_2');
        hold off
    end
    
    % Controllo della dimensione
    if nargin == 2 && length(x) ~= n
        error("The dimension of the x array and the number of dimensions n must coincide")
    end

  

    % Parametri
    max_iter = 1000000; % Numero massimo di iterazioni
    tol = 1e-8;      % Tolleranza
%     rho = 1;         % Coefficiente di riflessione
%     chi = 2;         % Coefficiente di espansione
%     gamma = 0.5;     % Coefficiente di contrazione
%     sigma = 0.5;     % Coefficiente di riduzione
%     

    % Contatore delle iterazioni
    k = 0;
    iteration_values = [];
    f_values_history = [];    

    tic 

    % Simplex iniziale
    if nargin < 2 || isempty(x)
        % Simplex iniziale casuale se 'x' non è fornito
        simplex = rand(n + 1, n);
    else
        % Creazione del simplex partendo da 'x'
        simplex = zeros(n + 1, n);
        simplex(1, :) = x;
        for i = 2:n + 1
            simplex(i, :) = rand(1, n);
        end
    end

    

    % Algoritmo principale
    while k <= max_iter && max(vecnorm(simplex - mean(simplex), 2, 2)) >= tol
        % Ordina i vertici in base al valore della funzione
        f_values = f(simplex);
        [~, idx] = sort(f_values);
        simplex = simplex(idx, :);

        % Aggiorna i valori di iterazione e funzione obiettivo
        iteration_values = [iteration_values, k];
        f_values_history = [f_values_history, f_values(1)];

        % Centroid del simplex senza il punto peggiore
        centroid = mean(simplex(1:end-1, :), 1);

        % Riflessione
        x_r = centroid + rho * (centroid - simplex(end, :));
        f_r = f(x_r);

        if f_r < f_values(end-1) && f_r >= f_values(1)
            simplex(end, :) = x_r;

        elseif f_r < f_values(1)
            % Espansione
            x_e = centroid + chi * (x_r - centroid);
            if f(x_e) < f_r
                simplex(end, :) = x_e;
            else
                simplex(end, :) = x_r;
            end

        else
            % Contrazione
            if f_r < f_values(end)
                x_c = centroid + gamma * (x_r - centroid); % Contrazione esterna
            else
                x_c = centroid + gamma * (simplex(end, :) - centroid); % Contrazione interna
            end

            if f(x_c) < f_values(end)
                simplex(end, :) = x_c;
            else
                % Riduzione
                simplex(2:end, :) = simplex(1, :) + sigma * (simplex(2:end, :) - simplex(1, :));
            end
        end

        % Plot del simplex (solo per 2D)
        if n == 2
          
            plot([simplex(:, 1); simplex(1, 1)], [simplex(:, 2); simplex(1, 2)], '-o');
        end

        % Incrementa il contatore delle iterazioni
        k = k + 1;
    end

    % Restituisci il risultato
    xk = simplex(1, :);
    fk = f(xk);
    execution_time=toc;
    %Grafico della funzione obiettivo rispetto alle iterazioni
%     figure;
%     plot(iteration_values, f_values_history, '-o', 'LineWidth', 1.2);
%     title(sprintf("Objective function value with n=%g", n));
%     xlabel('Iterazioni');
%     ylabel('f(x)');
%     set(gca, 'XScale', 'log')
%     grid on;
end
