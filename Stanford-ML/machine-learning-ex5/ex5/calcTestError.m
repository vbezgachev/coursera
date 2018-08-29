function [error_test] = ...
    calcTestError(X, y, Xtest, ytest)

error_test = 0;

[theta] = trainLinearReg(X, y, 3);
error_test = linearRegCostFunction(Xtest, ytest, theta, 0);


% =========================================================================

end
