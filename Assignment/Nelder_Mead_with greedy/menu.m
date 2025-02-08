function [f,ok]=menu()

datasets = {'Extended Freudenstein and Roth ', 'Problem 75', 'Problem76'};

[choice, ok] = listdlg('PromptString', 'Select a functions:', ...
                          'SelectionMode', 'single', ...
                          'ListString', datasets, ...
                          'ListSize', [250, 250], ...
                          'Name', 'Function selection', ...
                          'OKString', 'Select', ...
                          'CancelString', 'Cancel');

if ok
    switch choice
        case 1
            f = @(x) extendedFreudensteinRoth(x);      
        case 2
          f = @(x) problem75(x);   
        
        case 3
          f=@(x) problem76(x); 
    end
    disp('Function loaded!');
else
    error('Abort operation');
end
