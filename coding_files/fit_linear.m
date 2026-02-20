function [A, E, R2] = fit_linear(Z, Y)
    % Solve least squares 
    A = (Z' * Z) \ (Z' * Y);
    % Predicted values
    Y1 = Z * A;
    % Error
    E = Y - Y1;
    % R^2
    R2 = 1 - sum(E.^2) / sum((Y - mean(Y)).^2);
end