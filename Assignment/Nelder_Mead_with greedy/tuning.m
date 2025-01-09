clear
clc

n = 25;
N = 1000;

range = 0.3:0.1:1;

steps = zeros(1, N);
res = zeros(1, N);
avg_steps = zeros(1, length(range));
avg_res = zeros(1, length(range));

% Parameters to check
rho = 1;
chi = 1.1;
gamma = 0.5;
sigma = 0.5;

i = 1;
for sigma = range
    for j = 1:N
        [xk, fk, execution_time, k] = ...
            nelder([], n, rho, chi, gamma, sigma, 1);
        steps(j) = k;
        res(j) = fk;
    end
    avg_steps(i) = mean(steps);
    avg_res(i) = mean(res);
    i = i+1;
end

figure;
plot(range, avg_steps, '-o', 'LineWidth', 1.2);
title("Number of iteration");
xlabel('rho');
ylabel('avg steps');
grid on;

figure;
plot(range, avg_res, '-o', 'LineWidth', 1.2);
title("Convergence");
xlabel('rho');
ylabel('avg f(xk)');
grid on;