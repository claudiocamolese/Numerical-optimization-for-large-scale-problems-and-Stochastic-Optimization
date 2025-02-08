clear
close all
clc

[f, grad_f,Hess_f, ok]=menu_modified();
% Parameters
tolgrad = 1e-4;
kmax= 1000;
delta = 1e-4;
rho = 0.5;
c1=1e-4;
random_seed = 337517;
btmax=50;
rng(random_seed)
% 
% f = @(x) extended_rosenbrock(x);
% grad_f = @(x) extended_rosenbrock_grad(x);
% Hess_f = @(x) extended_rosenbrock_hessian(x);

% f = @(x) extendedFreudensteinRoth(x);
% grad_f = @(x) extended_freudenstein_grad(x);
% Hess_f = @(x) extended_freudenstein_hessian(x);
% f = @(x) extendedFreudensteinRoth(x);
% grad_f = @(x) findiff_gradf(f,x,1e-8,"fw");
% Hess_f = @(x) extendedFreudensteinRoth_findiff_Hess(f,x,sqrt(1e-8));

% f = @(x) compute_F_ascher(x);
% grad_f = @(x) compute_F_ascher_grad(x);
% Hess_f = @(x) compute_F_ascher_hessian(x);

% f = @(x) problem75(x);
% grad_f = @(x) problem75_grad(x);
% Hess_f = @(x) problem75_hessian(x);
% f = @(x) problem75(x);
% grad_f = @(x) findiff_gradf(f,x,1e-5,"fw");
% Hess_f = @(x) problem75_findiff_Hess(f,x,sqrt(1e-5));

% f = @(x) problem76_newton(x);
% grad_f = @(x) problem76_grad(x);
% Hess_f = @(x) problem76_hessian(x);
% f = @(x) problem76_newton(x);
% grad_f = @(x) findiff_gradf(f,x,1e-8,"fw");
% Hess_f = @(x) problem76_findiff_Hess(f,x,sqrt(1e-8));

% 
% for n = logspace(3, 5, 3) 
%     disp("------    ------")
%     disp(n)
    tic
%     x0 = ones(1000, 1);
%     x0(1:2:end) = -1.2;

%     x0 = 60*ones(10, 1);
%     x0(1:2:end) = 90;

x0 = -1.2*ones(10, 1);
x0(end) = -1;

% x0 = 2* ones(10, 1);

random_points = x0 + (rand(10, 10) * 2 - 1);

%% RUN THE MODIFIED NEWTON METHOD WITH BACKTRACK

disp('**** MODIFIED NEWTON METHOD: START *****')

for i = 1:10
    %  random_points(:, i)
[xk, fk, gradfk_norm, k] = ...
    modified_newton_bcktrck(random_points(:,i), f, grad_f, Hess_f, kmax, tolgrad, c1, rho, btmax, delta);
disp('**** MODIFIED NEWTON METHOD: FINISHED *****')
disp('**** MODIFIED NEWTON METHOD: RESULTS *****')
disp('')
disp(['xk: ', mat2str(xk), ' (actual minimum: [0; 0]);'])
disp(['f(xk): ', num2str(fk), ' (actual min. value: 0);'])
disp(['N. of Iterations: ', num2str(k),'/',num2str(kmax), ';'])
disp(gradfk_norm)
disp('')


toc
 end

%% PLOTS (BACKTRACK)
% 
% f_meshgrid = @(X,Y)reshape(f2([X(:),Y(:)]'),size(X));
% 
% % Creation of the meshgrid for the contour-plot
% [X, Y] = meshgrid(linspace(-6, 6, 500), linspace(-6, 6, 500));
% % Computation of the values of f for each point of the mesh
% Z = f_meshgrid(X, Y);
% 
% % Plots
% 
% % Simple Plot
% fig1 = figure();
% % Contour plot with curve levels for each point in xseq
% [C1, ~] = contour(X, Y, Z);
% hold on
% % plot of the points in xseq
% plot(xseq(1, :), xseq(2, :), '--*')
% hold off
% 
% % More interesting Plot
% fig2 = figure();
% % Contour plot with curve levels for each point in xseq
% % ATTENTION: actually, the mesh [X, Y] is too coarse for plotting the last
% % level curves corresponding to the last point in xseq (check it zooming
% % the image).
% [C2, ~] = contour(X, Y, Z, f2(xseq));
% hold on
% % plot of the points in xseq
% plot(xseq(1, :), xseq(2, :), '--*')
% hold off
% 
% % Barplot of btseq
% fig3 = figure();
% bar(btseq)
% 
% % Much more interesting plot
% fig4 = figure();
% surf(X, Y, Z,'EdgeColor','none')
% hold on
% plot3(xseq(1, :), xseq(2, :), f2(xseq), 'r--*')
% hold off

% end