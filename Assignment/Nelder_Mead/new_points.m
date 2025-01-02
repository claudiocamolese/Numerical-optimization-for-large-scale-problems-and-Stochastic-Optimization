function new_starting_points = new_points(x,y,n)
    p=[x,y];
    new_starting_points = repmat(p, 10, 1) + rand(10, n) * 2 - 1;
end