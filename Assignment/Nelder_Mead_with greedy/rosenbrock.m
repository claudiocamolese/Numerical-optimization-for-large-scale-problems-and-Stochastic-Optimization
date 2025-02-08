function rosenbrock(x0, rho,chi,gamma,sigma)

f = @(x) rosenbrock_function(x);
[xk, fk, execution_time, iter] = nelder(f,x0, 2, rho, chi, gamma, sigma);
disp(xk)
disp(fk)
   
end