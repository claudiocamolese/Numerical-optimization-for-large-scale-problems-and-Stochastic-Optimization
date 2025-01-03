function new_starting_points = new_points(x,y,n)

result = zeros(1, n);  % Crea un vettore vuoto di lunghezza n
    
    for i = 1:n
        if mod(i, 2) == 1
            result(i) = x;  % Posizione dispari: assegna x
        else
            result(i) = y;  % Posizione pari: assegna y
        end
    end

new_starting_points = repmat(result, 10, 1) + rand(10, n) * 2 - 1;
end