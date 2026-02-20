function A = fit_nonlinear(x, y, model, seeds)
% Gauss-Newton NLLS with finite-difference Jacobian

h = 1e-6;  maxIter = 100;
x = x(:);  y = y(:);
p = seeds(:);
N = length(x);  M = length(p);

for k = 1:maxIter
    yhat = model(x, p);
    r = y - yhat;

    Z = zeros(N, M);
    for i = 1:M
        H = zeros(M,1); H(i) = h;
        Z(:,i) = (model(x, p + H) - yhat) / h;
    end

    dp = Z \ r;      % least-squares step
    p  = p + dp;
end

A = p;
end