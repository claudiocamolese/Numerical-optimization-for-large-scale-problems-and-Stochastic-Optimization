clc
close all
clear

rng(337517)

% Array di dimensioni da testare
dimensions=[50];
execution_times = zeros(1, length(dimensions));
k=1;

for n=dimensions 

    disp("-----------------")
    fprintf("Dimensione n=%g\n",n)
    disp("-----------------")

    points= new_points(-1.2,1,n);    
    
    for j= 1:size(points,1)%da 1 a 10

        point=points(j,:);
      
%         [xk, fk, time] = nelder(point,n);        
%         
%         fprintf("Time: %.4f s, f(x): %.4f\n", time, fk);
%         
        [xk,execution_time,best_rho, best_chi, best_gamma, best_sigma, best_f] = greedy_search(point, n);
        execution_times(k) = execution_time;
        k=k+1;
  
    end    
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
