%% LOADING THE VARIABLES FOR THE TEST

clear
close all
clc

load('test_functions2.mat')
delta = 1e-8;
x0 = [0 0; 1 0; 0 1];
rho = 0.5;


%% RUN THE MODIFIED NEWTON METHOD WITH BACKTRACK

disp('**** STEEPEST DESCENT ("SIMPLE"): START *****')

chat()
disp('**** STEEPEST DESCENT: FINISHED *****')
disp('**** STEEPEST DESCENT: RESULTS *****')
disp('')
disp(['xk: ', mat2str(xk), ' (actual minimum: [0; 0]);'])
disp(['f(xk): ', num2str(fk), ' (actual min. value: 0);'])
%disp(['N. of Iterations: ', num2str(k),'/',num2str(kmax), ';'])
disp('')


%% PLOTS (BACKTRACK)

f_meshgrid = @(X,Y)reshape(f2([X(:),Y(:)]'),size(X));

% Creation of the meshgrid for the contour-plot
[X, Y] = meshgrid(linspace(0.5, 1.5, 500), linspace(0.5, 1.5, 500));
% Computation of the values of f for each point of the mesh
Z = f_meshgrid(X, Y);

% Plots

% Simple Plot
fig1 = figure();
% Contour plot with curve levels for each point in xseq
[C1, ~] = contour(X, Y, Z);
hold on
% plot of the points in xseq
plot(xseq(1, :), xseq(2, :), '--*')
hold off

% More interesting Plot
fig2 = figure();
% Contour plot with curve levels for each point in xseq
% ATTENTION: actually, the mesh [X, Y] is too coarse for plotting the last
% level curves corresponding to the last point in xseq (check it zooming
% the image).
[C2, ~] = contour(X, Y, Z, f2(xseq));
hold on
% plot of the points in xseq
plot(xseq(1, :), xseq(2, :), '--*')
hold off

% Barplot of btseq
fig3 = figure();
bar(btseq)

% Much more interesting plot
fig4 = figure();
surf(X, Y, Z,'EdgeColor','none')
hold on
plot3(xseq(1, :), xseq(2, :), f2(xseq), 'r--*')
hold off