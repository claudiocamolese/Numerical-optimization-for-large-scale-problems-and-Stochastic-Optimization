function grad = gradf(x)
    n = length(x);
    grad = zeros(n, 1);
    
    for i = 2:n
        x_im1 = x(i-1);
        x_i = x(i);
        
        grad(i-1) = grad(i-1) + 400 * (x_im1^2 - x_i) * x_im1 + 2 * (x_im1 - 1);
        if i < n
            grad(i) = grad(i) - 200 * (x_im1^2 - x_i);
        end
    end
end