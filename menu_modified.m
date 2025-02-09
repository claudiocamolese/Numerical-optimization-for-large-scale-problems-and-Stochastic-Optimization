function [f, x0, grad,H, tolgrad, kmax, rho, c1,mode,opts,ok] = menu_modified(h)

    datasets = {'Extended Freudenstein and Roth', 'Problem 75', 'Problem 76'};
    [choice, ok] = listdlg('PromptString', 'Select a function:', ...
                           'SelectionMode', 'single', ...
                           'ListString', datasets, ...
                           'ListSize', [250, 250], ...
                           'Name', 'Function selection', ...
                           'OKString', 'Select', ...
                           'CancelString', 'Cancel');
    
    if ~ok
        error('Abort operation');
    end
    
    deriv_methods = {'Analytical derivatives', 'Finite differences'};
    [deriv_choice, flag] = listdlg('PromptString', 'Select a differentiation method:', ...
                                   'SelectionMode', 'single', ...
                                   'ListString', deriv_methods, ...
                                   'ListSize', [250, 250], ...
                                   'Name', 'Differentiation method', ...
                                   'OKString', 'Select', ...
                                   'CancelString', 'Cancel');
    
    if ~flag
        error('Abort operation');
    end
    
    switch choice
        case 1
            f = @(x) extendedFreudensteinRoth(x);
            x0 = @(n) (60 * ones(n, 1)) .* (mod((1:n)', 2) == 0) + (90 * ones(n, 1)) .* (mod((1:n)', 2) ~= 0);
            tolgrad = 1e-4;
            kmax= 10000;
            rho = 0.5;
            c1=1e-6;  
            mode='smallestreal';
%             opts = struct('Tolerance', 1e-6, 'MaxIterations', 100000);
            opts.maxit=100000;
            opts.tol=1e-6;

            if deriv_choice == 1
                grad= @(x) extended_freudenstein_grad(x);
                H = @(x) extended_freudenstein_hessian(x);
               
            else
%                 h=1e-8;
                type="fw";
                grad=@(x) findiff_gradf(f, x, h, type);
                H = @(x) extendedFreudensteinRoth_findiff_Hess(f, x, sqrt(h));
            end

        case 2
            f = @(x) problem75(x);
            x0 = @(n) [-1.2 * ones(n-1, 1); -1];
            tolgrad = 1e-4;
            kmax= 1000;
            rho = 0.5;
            c1=1e-4;
            mode="smallestabs";
            opts=struct();

            if deriv_choice == 1
                grad= @(x)problem75_grad(x);
                H = @(x) problem75_hessian(x);
            else
                type="fw";
                grad=@(x) findiff_gradf(f, x, h, type);
                H = @(x) problem75_findiff_Hess(f, x, sqrt(h));
            end

        case 3
            f = @(x) problem76_newton(x);
            x0 =@(n) 2* ones(n, 1);
            tolgrad = 1e-4;
            kmax= 1000;
            rho = 0.5;
            c1=1e-4;
            if deriv_choice == 1
                grad=@(x) problem76_grad(x);
                H = @(x) problem76_hessian(x);
            else
                type="fw";
                grad=@(x)findiff_gradf(f, x, h, type);
                H = @(x) problem76_findiff_Hess(f, x, sqrt(h));
            end
    end
    
    disp('Function and differentiation method loaded!');
end
