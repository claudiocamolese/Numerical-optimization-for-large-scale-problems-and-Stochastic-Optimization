function [xk, fk, gradfk_norm, k] = modified_newton_bcktrck(x0, f, gradf, Hessf, kmax, tolgrad, c1, rho, btmax, delta)

farmijo = @(fk, alpha, c1_gradfk_pk) fk + alpha * c1_gradfk_pk;

% Initializations
% xseq = zeros(length(x0), kmax);
% btseq = zeros(1, kmax);

xk = x0;
fk = f(xk);
gradfk = gradf(xk);
k = 0;
gradfk_norm = norm(gradfk);

while k < kmax && gradfk_norm >= tolgrad
%     if mod(k, 500) == 0
%         disp(k)
%         disp(fk)
%         disp(gradfk_norm)
%     end
    % Compute the Hessian
    Hk = Hessf(xk);
%     disp(k)
    % Ensure positive definiteness: compute tau_k
    lambda_min = eigs(Hk,1,"smallestreal","MaxIterations",100000);  % Minimum eigenvalue of the Hessian
%     disp(k+1)
%     disp(cond(Hk));
%     disp(lambda_min);
    if lambda_min <= 0
        tau_k = max(0, delta - lambda_min);  % Correction to make Bk positive definite
        Bk = Hk + tau_k * speye(length(x0));
%         disp(tau_k)
    else
        Bk = Hk;
    end
    

% Solve the linear syste   m Bk * pk = -gradfk

       pk = -Bk \ gradfk;   
%    disp(k+2)

%     L = ichol(Bk, struct('type', 'nofill')); % Precondizionatore
%     tol = 1e-4;
%     maxIter = 100;
%     [pk,~] = pcg(Bk, -gradfk, tol, maxIter,L,L');


    % Reset alpha for backtracking
    alpha = 1;
    
    % Compute the candidate new xk
    xnew = xk + alpha * pk;
    fnew = f(xnew);
    
    c1_gradfk_pk = c1 * gradfk' * pk;
    bt = 0;
%     disp(k+3)
    % Backtracking strategy
    while bt < btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        alpha = rho * alpha;  % Reduce step size
        xnew = xk + alpha * pk;
        fnew = f(xnew);
        bt = bt + 1;
    end
%     disp(k+4)
%     if bt ~= 0
%         disp(bt)
%     end

    if bt == btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        break;
    end
    
    % Update values for the next iteration
    xk = xnew;
    fk = fnew;
    gradfk = gradf(xk);
    gradfk_norm = norm(gradfk);
    if mod(k, 500) == 0
        disp(k)
        disp(fk)
        disp(gradfk_norm)
    end
    k = k + 1;
%     xseq(:, k) = xk;
%     btseq(k) = bt;
end

% Adjust sequence sizes
% xseq = xseq(:, 1:k);
% btseq = btseq(1:k);
% xseq = [x0, xseq];  % Add initial guess to sequence

end