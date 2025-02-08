function f=rosenbrock_function(x)

if size(x,2)==1
    f= 100*(x(2)-x(1).^2).^2 + (1-x(1)).^2;
else
    f=100*(x(2,:)-x(1,:).^2).^2+(1-x(1,:)).^2;
    f=f';
end
end