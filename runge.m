clc; clear; close all; hold on; grid on;

f = @(x) 1 ./ (1 + 25 .* x .^ 2);

p_x = -1:0.01:1;
plot(p_x, f(p_x), 'LineWidth', 1)

x = -1:.5:1;
y = f(x);
plot(p_x, Lagrange(x, y, p_x), 'r', 'LineWidth', 1)

[
 Newtint(x(4:5), y(4:5), 0.8)
 Newtint(x(3:5), y(3:5), 0.8)
 Newtint(x(2:5), y(2:5), 0.8)
 Newtint(x(1:5), y(1:5), 0.8)
 ]

plot(p_x, interp1(x, y, p_x, 'cubic'), 'LineWidth', 1)
legend('f(x)', 'Lagrange', 'cubic')

function yint = Newtint(x, y, xx)
    n = length(x);
    if length(y) ~= n, error('x and y must be same length'); end
    b = zeros(n, n);
    % assign dependent variables to the first column of b.
    b(:, 1) = y(:); % the (:) ensures that y is a column vector.
    for j = 2:n
        for i = 1:n - j + 1
            b(i, j) = (b(i + 1, j - 1) - b(i, j - 1)) / (x(i + j - 1) - x(i));
        end
    end

    % use the finite divided differences to interpolate
    xt = 1;
    yint = b(1, 1);
    for j = 1:n - 1
        xt = xt * (xx - x(j));
        yint = yint + b(1, j + 1) * xt;
    end
end

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
