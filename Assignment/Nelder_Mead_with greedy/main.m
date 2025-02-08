clc
close all
clear

rng(337517)

rosenbrock([1.2;1.2],1,1.1,0.7,0.6)
rosenbrock([-1.2;1],1,1.1,0.7,0.6)

[f,ok]= menu();

dimensions=[10, 25, 50];

rho = [1,1,1];
chi = [1.1,1.1,1.1];
gamma = [0.7,0.7,0.7];
sigma = [0.6,0.6,0.6];
k=1;

execution_times = zeros(1, length(dimensions));


for n=dimensions 

    if ok==1
        x0 = 60*ones(n, 1);
        x0(1:2:end) = 90;
    elseif ok==2
        x0 = -1.2*ones(n, 1);
        x0(end) = -1;
    else
        x0 = 2* ones(n, 1);
    end

    hypercube = x0 + (rand(n, 10) * 2 - 1);

    disp("-----------------")
    fprintf("Dimensione n=%g\n",n)
    disp("-----------------")
    
    [xk, fk, execution_time, iter] = nelder(f,x0, n, rho(k), chi(k), gamma(k), sigma(k));   
    
    for j= 1:size(hypercube,2)

        point=hypercube(:,j);
        [xk, fk, execution_time, iter] = nelder(f,point, n, rho(k), chi(k), gamma(k), sigma(k));
        execution_times(k) = execution_time;
        disp(['Best objective function value: ', num2str(fk)]);
        disp(['Number of iterations: ', num2str(iter)]);
        disp(xk');
    end
    k=k+1;
end

figure;
hold on;
grid on;
plot(dimensions, execution_times, '-o', 'LineWidth', 1.5);
title('Execution time');
xlabel('Dimension n');
ylabel('Time(s)');
set(gca, 'YScale', 'log');
grid on;
hold off;
