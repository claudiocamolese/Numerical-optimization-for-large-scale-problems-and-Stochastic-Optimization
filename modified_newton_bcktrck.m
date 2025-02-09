function [xk, fk, gradfk_norm, k] = modified_newton_bcktrck(x0, f, gradf, Hessf, kmax, tolgrad, c1, rho, btmax, delta)

farmijo = @(fk, alpha, c1_gradfk_pk) fk + alpha * c1_gradfk_pk;


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
    
    Hk = Hessf(xk);
   
%     lambda_min = eigs(Hk,1,"smallestreal", "Tolerance",1e-6, "MaxIterations",100000);  
    lambda_min = eigs(Hk,1,'smallestabs'); 
    
    if lambda_min <= 0
        tau_k = max(0, delta - lambda_min);
        Bk = Hk + tau_k * speye(length(x0));
    else
        Bk = Hk;
    end


%        pk = -Bk \ gradfk;   
%    disp(k+2)

    L = ichol(Bk, struct('type', 'nofill')); 
    tol = 1e-4;
    maxIter = 100;
    [pk,~] = pcg(Bk, -gradfk, tol, maxIter,L,L');

    alpha = 1;
    
    xnew = xk + alpha * pk;
    fnew = f(xnew);
    
    c1_gradfk_pk = c1 * gradfk' * pk;
    bt = 0;
   
    while bt < btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        alpha = rho * alpha;  
        xnew = xk + alpha * pk;
        fnew = f(xnew);
        bt = bt + 1;
    end

    if bt == btmax && fnew > farmijo(fk, alpha, c1_gradfk_pk)
        break;
    end
    
    xk = xnew;
    fk = fnew;
    gradfk = gradf(xk);
    gradfk_norm = norm(gradfk);
%     if mod(k, 50) == 0
%         disp(k)
%         disp(fk)
%         disp(gradfk_norm)
%     end
    k = k + 1;
%     xseq(:, k) = xk;
%     btseq(k) = bt;
end

% xseq = xseq(:, 1:k);
% btseq = btseq(1:k);
% xseq = [x0, xseq];  % Add initial guess to sequence

end