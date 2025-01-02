function [xk, fk, gradfk_norm, k, xseq, btseq] = modified_newton_bcktrck(x0, f, gradf, Hessf, kmax, tolgrad, c1, rho, btmax, delta)
%
% Function that performs the Modified Newton optimization method,
% using backtracking strategy for step-length selection.
%
% INPUTS:
% x0, f, gradf, Hessf, kmax, tolgrad, c1, rho, btmax: same as in newton_bcktrck
% delta: threshold for ensuring positive definiteness (small positive value)
%
% OUTPUTS:
% xk, fk, gradfk_norm, k, xseq, btseq: same as in newton_bcktrck
%

% Function handle for the Armijo condition
farmijo = @(fk, alpha, c1_gradfk_pk) fk + alpha * c1_gradfk_pk;

% Initializations
xseq = zeros(length(x0), kmax);
btseq = zeros(1, kmax);

xk = x0;
fk = f(xk);
gradfk = gradf(xk);
k = 0;
gradfk_norm = norm(gradfk);

while k < kmax && gradfk_norm >= tolgrad
    % Compute the Hessian
    Hk = Hessf(xk);
    
    % Ensure positive definiteness: compute tau_k
    lambda_min = min(eig(Hk));  % Minimum eigenvalue of the Hessian
    if lambda_min <= 0
        tau_k = delta - lambda_min;  % Correction to make Bk positive definite
        Bk = Hk + tau_k * eye(length(x0));
    else
        Bk = Hk;
    end
    
    % Solve the linear system Bk * pk = -gradfk
    pk = -Bk \ gradfk;
    
    % Reset alpha for backtracking
    alpha = 1;
    
    % Compute the candidate new xk
    xnew = xk + alpha * pk;
    fnew = f(xnew);
    
    c1_gradfk_pk = c1 * gradfk' * pk;
    bt = 0;
    
    % Backtracking strategy
    while bt < btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        alpha = rho * alpha;  % Reduce step size
        xnew = xk + alpha * pk;
        fnew = f(xnew);
        bt = bt + 1;
    end
    
    if bt == btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        break;
    end
    
    % Update values for the next iteration
    xk = xnew;
    fk = fnew;
    gradfk = gradf(xk);
    gradfk_norm = norm(gradfk);
    
    k = k + 1;
    xseq(:, k) = xk;
    btseq(k) = bt;
end

% Adjust sequence sizes
xseq = xseq(:, 1:k);
btseq = btseq(1:k);
xseq = [x0, xseq];  % Add initial guess to sequence

end