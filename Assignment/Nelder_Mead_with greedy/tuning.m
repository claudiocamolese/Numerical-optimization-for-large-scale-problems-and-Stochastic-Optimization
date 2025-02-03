clear
clc

n = 10;
N = 1;

range = 0.1:0.1:0.9;

steps = zeros(1, N);
res = zeros(1, N);
avg_steps = zeros(1, length(range));
avg_res = zeros(1, length(range));

% Parameters to check
rho = 1.7;
chi = 1.9;
gamma = 0.7;
% sigma = 0.6;

i = 1;
for sigma = range
    for j = 1:N
        [xk, fk, execution_time, k] = ...
            nelder([], n, rho, chi, gamma, sigma);
        steps(j) = k;
        res(j) = fk;
    end
    avg_steps(i) = mean(steps);
    avg_res(i) = mean(res);
    i = i+1;
    disp(i);
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