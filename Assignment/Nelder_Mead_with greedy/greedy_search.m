function [xk,execution_time,best_rho, best_chi, best_gamma, best_sigma, best_f] = greedy_search(x, n)
    % Definizione dei valori da esplorare per ogni parametro
    rho_values = [1.0,1.1,1.2];  % Prova diversi valori per rho
    chi_values = [2,2.1,2.2,2.5];      % Prova diversi valori per chi
    gamma_values = [0.8,0.9]; % Prova diversi valori per gamma
    sigma_values = [1,1.1]; % Prova diversi valori per sigma

    best_f = inf; % Funzione obiettivo iniziale, parte da un valore molto alto
    best_rho = rho_values(1);
    best_chi = chi_values(1);
    best_gamma = gamma_values(1);
    best_sigma = sigma_values(1);


    % Ottimizzazione Greedy
    for rho = rho_values
        for chi = chi_values
            for gamma = gamma_values
                for sigma = sigma_values
                    % Esegui l'algoritmo Nelder-Mead con i parametri correnti
                    [xk, fk, execution_time] = nelder(x, n, rho, chi, gamma, sigma);

                    % Se la funzione obiettivo corrente è migliore, aggiorna i parametri
                    if fk < best_f
                        best_f = fk;
                        best_rho = rho;
                        best_chi = chi;
                        best_gamma = gamma;
                        best_sigma = sigma;
                        xk=xk;
                        execution_time=execution_time;
                       
                    end
                end
            end
        end
    end

    % Restituisci i migliori parametri e la funzione obiettivo corrispondente
    disp(['Best rho: ', num2str(best_rho)]);
    disp(['Best chi: ', num2str(best_chi)]);
    disp(['Best gamma: ', num2str(best_gamma)]);
    disp(['Best sigma: ', num2str(best_sigma)]);
    disp(['Best objective function value: ', num2str(best_f)]);
end
