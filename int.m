clc; clear; close all;

x = [1 2 3 5 7 8];
y = [3 6 19 99 291 44];

[
 Newtint(x(3:4), y(3:4), 4)
 Newtint(x(3:5), y(3:5), 4)
 Newtint(x(2:5), y(2:5), 4)
 Newtint(x(1:5), y(1:5), 4)
 Newtint(x, y, 4)
 ]

[
 Lagrange(x(3:4), y(3:4), 4)
 Lagrange(x(3:5), y(3:5), 4)
 Lagrange(x(2:5), y(2:5), 4)
 Lagrange(x(1:5), y(1:5), 4)
 Lagrange(x, y, 4)
 ]

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
    s = 0;
    for i = 1:n
        product = y(i);
        for j = 1:n
            if i ~= j
                product = product * (xx - x(j)) / (x(i) - x(j));
            end
        end
        s = s + product;
    end
    yint = s;
end
