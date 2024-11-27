%% Inizialization
clear
clc

load test_functions2.mat
load forcing_terms.mat

cg_maxit = 10;
fterms = fterms_quad;

%% PARABOLOID
x0 = [1.2; 1.2];
rho = 0.5;
xstar = [1; 1];
fxstar = 0;

disp('--    PARABOLOID')
disp('inexact Newton method with backtrack: start')


[xk, fk, gradfk_norm, k, xseq, btseq, cgiterseq] = ...
    troncated_nm(x0, f2, gradf2, Hessf2, kmax, tolgrad, c1, rho, ...
    btmax, fterms, cg_maxit);
disp('inexact Newton method with backtrack: finished')
disp('inexact Newton method with backtrack: results')
disp('************************************')
disp('xk: ')
disp(xk)
disp('actual minimum:')
disp(xstar)
disp('fk: ')
disp(fk)
disp('actual min. value:')
disp(fxstar)
disp(['N. of Iterations: ', num2str(k),'/',num2str(kmax), ';'])
disp('xseq:')
%disp(xseq)
disp('btseq:')
%disp(btseq)
disp('************************************')