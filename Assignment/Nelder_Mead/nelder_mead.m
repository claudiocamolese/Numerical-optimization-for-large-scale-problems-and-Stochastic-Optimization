function[xk,k,relres]=nelder_mead(symplex,f,kmax,tol, p)

% symplex is a matrix where each row corrisponds to the coordinates of the x_i elements 
% p is the coefficients of the reflection phase. Usually, it is set equal to 1

symplex = [ 1, 2;0, 0; 4, 1]; % Matrice dei punti
f = @(x1, x2) (1 - x1).^2 + 100 * (x2 - x1.^2).^2; % Funzione di Rosenbrock (vetoriale)


%es: symplex=[x_1 y_1 z_1... ; ...; x_n y_n z_n ...]
%rank(symplex)
A = sortrows([f(symplex(:, 1), symplex(:, 2)),symplex],1);
[baricenter_x, baricenter_y] = deal(mean(symplex(:, 1)), mean(symplex(:, 2))); %in automatico sulle colonne

A(-1,:)

% plot symplex
figure;
hold on;
plot(symplex(:, 1), symplex(:, 2), baricenter_y,baricenter_x,'o', 'MarkerSize', 10, 'LineWidth', 1.5); % Plotta i punti
plot([symplex(:, 1); symplex(1, 1)], [symplex(:, 2); symplex(1, 2)], '-k'); % Connetti i punti (opzionale)
xlabel('x');
ylabel('y');
title('Visualizzazione del simplex');
grid on;
hold off;

end