function [f, grad,H, ok] = menu_modified()

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
            if deriv_choice == 1
                grad= @(x) extended_freudenstein_grad(x);
                H = @(x) extended_freudenstein_hessian(x);
            else
                grad=findiff_gradf(f, x, h, type);
                H = @(x) problem75_findiff_Hess(f, x, h);
            end

        case 2
            f = @(x) problem75_newton(x);
            if deriv_choice == 1
                grad= @(x)problem75_grad(x);
                H = @(x) problem75_hessian(x);
            else
                grad=@(x) findiff_gradf(f, x, h, type);
                H = @(x) problem75_findiff_Hess(f, x, h);
            end

        case 3
            f = @(x) problem76_newton(x);
            if deriv_choice == 1
                grad=@(x) problem76_grad(x);
                H = @(x) problem76_hessian(x);
            else
                grad=findiff_gradf(f, x, h, type);
                H = @(x) problem76_findiff_Hess(f, x, h);
            end
    end
    
    disp('Function and differentiation method loaded!');
end
