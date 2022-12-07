clc; clear; close all; hold on; grid on;

f = @(x) sin(x) .^ 2;
x = linspace(0, 2 * pi, 8);
scatter(x, f(x), 'filled')

p_x = linspace(0, 2 * pi, 100);
% not-a-knot
plot(p_x, spline(x, f(x), p_x), '--', 'LineWidth', 1)
% clamped
plot(p_x, spline(x, [1 f(x) 1], p_x), '-.', 'LineWidth', 1)
% Hermite interpolation
plot(p_x, interp1(x, f(x), p_x, 'pchip'), ':', 'LineWidth', 1)

legend('data', 'not-a-knot', 'clamped', 'Hermite', 'Location', 'best')
