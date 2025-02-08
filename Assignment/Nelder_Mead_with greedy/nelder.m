function [xk, fk, execution_time, k] = nelder(f, x, n, rho, chi, gamma, sigma)
       
    if length(x) ~= n
        error("The dimension of the array and the number of dimensions n must coincide")
    end
    
    if n==2
        figure
        hold on
        fcontour(@(x, y) (1 - x).^2 + 100 * (y - x.^2).^2, [-2, 2, -1, 3], 'LineWidth', 1.2); % Plotta le linee di livello
        colormap jet;
        title('Nelder-Mead Method');
        xlabel('x_1');
        ylabel('x_2');
    end

    simplex = rand(n, n+1); % Matrice n x (n+1), ogni colonna è un punto

    if ~isempty(x)
        simplex(:, 1) = x;
    end

    max_iter = 500000; 
    tol = 1e-6;     
    
    k = 1;
    
    f_values_history = zeros(1,max_iter);   

    tic 

    while k <= max_iter && max(vecnorm(simplex - mean(simplex, 2), 2, 1)) >= tol
       
        f_values = f(simplex);
        [~, idx] = sort(f_values);
        simplex = simplex(:, idx);

        f_values_history(k)=f_values(1);

        centroid = mean(simplex(:, 1:end-1), 2);

        x_r = centroid + rho * (centroid - simplex(:, end));
        f_r = f(x_r);

        if f_r < f_values(end-1) && f_r >= f_values(1)
            simplex(:, end) = x_r;

        elseif f_r < f_values(1)
            % Espansione
            x_e = centroid + chi * (x_r - centroid);
            if f(x_e) < f_r
                simplex(:, end) = x_e;
            else
                simplex(:, end) = x_r;
            end

        else
          
            if f_r < f_values(end)
                x_c = centroid + gamma * (x_r - centroid); 
            else
                x_c = centroid + gamma * (simplex(:, end) - centroid);
            end

            if f(x_c) < f_values(end)
                simplex(:, end) = x_c;
            else
                
                simplex(:, 2:end) = simplex(:, 1) + sigma * (simplex(:, 2:end) - simplex(:, 1));
            end
        end

        if n == 2
            plot([simplex(1, :), simplex(1, 1)], [simplex(2, :), simplex(2, 1)], '-o');
            pause(0.1)
        end

        k = k + 1;
    end

    xk = simplex(:, 1);
    fk = f(xk);
    execution_time=toc;
    f_values_history= f_values_history(:,1:k);


    figure;
    plot(1:k, f_values_history, '-o', 'LineWidth', 1.2);
    title(sprintf("Objective function value with n=%g", n));
    xlabel('Iterazioni');
    ylabel('f(x)');
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
    grid on;
end

