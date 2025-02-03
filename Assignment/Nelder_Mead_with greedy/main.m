clc
close all
clear

rng(337517)

% Array di dimensioni da testare
dimensions=[10, 25, 50];

rho = [1,1,1];
chi = [1.1,1.1,1.1];
gamma = [0.7,0.7,0.7];
sigma = [0.6,0.6,0.6];

execution_times = zeros(1, length(dimensions));
k=1;

for n=dimensions 

    disp("-----------------")
    fprintf("Dimensione n=%g\n",n)
    disp("-----------------")

    % points = new_points(-1.2,1,n);
    points = new_points(90,60,n);
    % points = new_points(10,10,n);
    
    for j= 1:size(points,1) % da 1 a 10

        point=points(j,:);
      
%         [xk, fk, time] = nelder(point,n);        
%         
%         fprintf("Time: %.4f s, f(x): %.4f\n", time, fk);
%         
        % [xk,execution_time,best_rho, best_chi, best_gamma, best_sigma, best_f] = greedy_search(point, n);
        [xk, fk, execution_time, iter] = nelder(point, n, rho(k), chi(k), gamma(k), sigma(k));
        execution_times(k) = execution_time;
        disp(['Best objective function value: ', num2str(fk)]);
        disp(['Number of iterations: ', num2str(iter)]);
        disp(xk);
    end
    k=k+1;
end

% Grafico dei tempi
% figure;
% hold on;
% grid on;
% plot(dimensions, execution_times, '-o', 'LineWidth', 1.5);
% title('Execution time');
% xlabel('Dimension n');
% ylabel('Time(s)');
% % set(gca, 'XScale', 'log'); % Usa scala logaritmica se necessario
% grid on;
% hold off;
