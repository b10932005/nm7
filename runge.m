clc; clear; close all; hold on; grid on;

f = @(x) 1 ./ (1 + 25 .* x .^ 2);

p_x = -1:0.01:1;
plot(p_x, f(p_x))

x = -1:.5:1;
y = f(x);
plot(p_x, Lagrange(x, y, p_x), 'r')

function yint = Lagrange(x, y, xx)
    n = length(x);
    if length(y) ~= n, error('x and y must be same length'); end
    s = zeros(1, length(xx));
    for i = 1:length(xx)
        for j = 1:n
            product = y(j);
            for k = 1:n
                if j ~= k
                    product = product * (xx(i) - x(k)) / (x(j) - x(k));
                end
            end
            s(i) = s(i) + product;
        end
    end
    yint = s;
end
