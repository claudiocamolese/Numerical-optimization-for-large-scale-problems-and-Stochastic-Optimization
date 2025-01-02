clc
close all
clear

rng(337517)

% Array di dimensioni da testare
dimensions =[2,3,4];
execution_times = zeros(1, length(dimensions));

for i = 1:length(dimensions)
    n = dimensions(i);
    
    % Calcola soluzione e tempo
    [xk, fk, time] = nelder(n);
    execution_times(i) = time;
    
    % Stampa il risultato per ogni dimensione
    fprintf("Dimension: %d, Time: %.4f s, f(x): %.4f\n", n, time, fk);
end

% Grafico dei tempi
figure;
hold on;
grid on;
plot(dimensions, execution_times, '-o', 'LineWidth', 1.5);
title('Execution time');
xlabel('Dimension n');
ylabel('Time(s)');
% set(gca, 'XScale', 'log'); % Usa scala logaritmica se necessario
grid on;
hold off;
