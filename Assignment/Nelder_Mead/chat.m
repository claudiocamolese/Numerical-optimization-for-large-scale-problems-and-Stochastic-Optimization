function chat()
    % Funzione obiettivo da minimizzare
    f = @(x) (1 - x(:, 1)).^2 + 100 * (x(:, 2) - x(:, 1).^2).^2; % Funzione di Rosenbrock
    %f=@(x) (x(:,1).^2+x(:,2)-11).^2+(x(:,1)+x(:,2).^2-7).^2;
    close all;

    % Inizializzazione del simplex
    simplex = [0 0; 1 0; 0 1]; % Tre vertici iniziali
    max_iter = 20; % Numero massimo di iterazioni
    tol = 1e-4; % Tolleranza
    k = 0; % Contatore delle iterazioni

    rho = 1; % Coefficiente di riflessione
    chi = 2; % Coefficiente di espansione

    % Array per tracciare il numero di iterazioni e i valori di f
    iteration_values = []; % Iterazioni
    f_values_history = []; % Valori della funzione obiettivo

    % Inizializza il grafico delle linee di livello
    figure;
     % Suddivide la finestra in due grafici
    hold on;
    fcontour(@(x, y) (1 - x).^2 + 100 * (y - x.^2).^2, [-2, 2, -1, 3], 'LineWidth', 1.2); % Plotta le linee di livello
    colormap jet;
    title('Nelder-Mead Method');
    xlabel('x_1');
    ylabel('x_2');

    while k <= max_iter && max(vecnorm(simplex - mean(simplex), 2, 2)) >= tol
        % Ordina i vertici in base al valore della funzione
        f_values = f(simplex); % Calcola f sui vertici del simplex
        [~, idx] = sort(f_values); % Ordina i valori della funzione e ottieni gli indici
        simplex = simplex(idx, :); % Riordina il simplex (dal migliore al peggiore)

        % Aggiorna i valori di iterazione e funzione obiettivo
        iteration_values = [iteration_values, k]; % Salva l'iterazione corrente
        f_values_history = [f_values_history, f_values(1)]; % Salva il valore minimo della funzione
       
        % Centroid del simplex senza il punto peggiore
        centroid = mean(simplex(1:end-1, :), 1);

        % Punti del Nelder-Mead
        x_r = centroid + rho * (centroid - simplex(end, :)); % Riflessione
        f_r = f(x_r);

        if f_r < f_values(end-1) && f_values(1) <= f_r
            simplex(end, :) = x_r;
            
        elseif f_r < f_values(1) % Miglioramento
            x_e = centroid + chi * (x_r - centroid); % Espansione
            if f(x_e) < f_r
                simplex(end, :) = x_e;
            else
                simplex(end, :) = x_r;
            end
        elseif f_r < f(simplex(end-1, :)) % Accettazione
            simplex(end, :) = x_r;
        else % Contrazione
            if f_r < f(simplex(end, :))
                x_c = centroid + 0.5 * (x_r - centroid); % Contrazione fuori
            else
                x_c = centroid + 0.5 * (simplex(end, :) - centroid); % Contrazione dentro
            end

            if f(x_c) < f(simplex(end, :))
                simplex(end, :) = x_c;
            else % Riduzione
                simplex(2:end, :) = simplex(1, :) + 0.5 * (simplex(2:end, :) - simplex(1, :));
            end
        end

        % Plotta il simplex corrente
        plot([simplex(:, 1); simplex(1, 1)], [simplex(:, 2); simplex(1, 2)], '-o');
        pause(0.1);

        % Incrementa il contatore delle iterazioni
        k = k + 1; 
    end

    
    % Grafico di f rispetto al numero di iterazioni
    figure % Secondo grafico
    hold on
    plot(iteration_values, f_values_history*100, '-o', 'LineWidth', 1.2);
    title('f obj');
    xlabel('');
    ylabel('f(x)');
    grid on;

end

% "if fr<f(simplex(end-1,:)) && fr>=f(simplex(1,:))
%             simplex(end,:)=xr;
%         
% 
%         elseif  fr<f(simplex(1,:))
%             xe=centroid+ chi(xr-centroid);
%             if f(xe)<f(xr)
%                 simplex(end,:)=xe;
%             
%             else 
%                 simplex(end,:)=xr;
%             end
%          
%         elseif f(xr)<f(simplex(end,:))
%             xc=centroid + gamma(xr-centroid);
%             if f(xc)<f(xr)
%                 simplex(end,:)=xc;
%             else
%                 simplex(2:end, :) = simplex(1, :) + theta * (simplex(2:end, :) - simplex(1, :));
%                
%             end
%         end"
