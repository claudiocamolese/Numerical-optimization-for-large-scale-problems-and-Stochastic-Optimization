function hess = Hessf(x)
    n = length(x);
    hess = zeros(n, n);
    
    for i = 2:n
        x_im1 = x(i-1);
        x_i = x(i);
        
        hess(i-1, i-1) = hess(i-1, i-1) + 1200 * x_im1^2 - 400 * x_i + 2;
        if i < n
            hess(i-1, i) = hess(i-1, i) - 400 * x_im1;
            hess(i, i-1) = hess(i, i-1) - 400 * x_im1;
            hess(i, i) = hess(i, i) + 200;
        end
    end
end