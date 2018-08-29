function [error_train, error_val] = ...
    learningCurveRandom(X, y, Xval, yval, lambda)

% Number of training examples
m = size(X, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

n = 50;

for i = 1:m
  for j = 1:n
    randIdx = randperm(m);
    
    X_rand = X(randIdx(1:i), :);
    y_rand = y(randIdx(1:i), :);
    
    [theta] = trainLinearReg(X_rand, y_rand, lambda);
    error_train(i) = error_train(i) + linearRegCostFunction(X_rand, y_rand, theta, 0);
    error_val(i) = error_val(i) + linearRegCostFunction(Xval, yval, theta, 0);
  end
  
  error_train(i) = error_train(i) / n;
  error_val(i) = error_val(i) / n;
end

end
