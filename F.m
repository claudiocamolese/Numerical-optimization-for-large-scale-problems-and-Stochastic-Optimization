function F = F(x)
    n = length(x);
    F = 0;
    
    for i = 2:n
        x_im1 = x(i-1);
        x_i = x(i);
        
        F = F + 100 * (x_im1^2 - x_i)^2 + (x_im1 - 1)^2;
    end
end