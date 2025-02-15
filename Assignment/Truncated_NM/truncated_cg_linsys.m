function [xk, k, flag, relres] = ...
    truncated_cg_linsys(A, b, kmax, tol)

% Conjugate gradient method as iterative method to find the newton step pk.
% Compute pk applying CG to the linear system Hessf(xk)*pk = -gradf(xk) and
% terminate the CG iterations eather when relres > tol or if the negative
% curvature condition is satisfyed, thus avoiding non descent directions
%
% INPUTS:
%   A:      n-by-n matrix rappresenting Hessf(xk)
%   b:      column vector of n elements rappresenting gradf(xk)
%   kmax:   positive integer, maximum number of steps
%   tol:    positive real value, tolerance for relative residual

x0 = zeros(length(b), 1);
xk = x0;
rk = b-A*xk;
pk = rk;

k = 0;
flag = 0;

norm_b = norm(b);
relres = norm(rk)/norm_b;

while k < kmax && relres > tol
    zk = A*pk;
    alphak = (rk'*pk)/(pk'*zk);
    xk = xk+alphak*pk;
    rk = rk-alphak*zk;

    betak = -(rk'*zk)/(pk'*zk);

    pk1 = rk+betak*pk;
    % negative curvature condition
    if pk1'*A*pk1 <= 0
        flag = 1;
        break
    end
    pk = pk1;
    
    relres = norm(rk)/norm_b;
    k = k + 1;
end

end