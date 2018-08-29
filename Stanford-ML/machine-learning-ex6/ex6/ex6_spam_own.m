%% Initialization
clear ; close all; clc

% Load the Spam Email dataset
% You will have X, y in your environment

fprintf('loading train and test data...\n')

load('email_data.mat');

fprintf('\nTraining Linear SVM (Spam Classification)\n')
fprintf('(this may take 1 to 2 minutes) ...\n')

% divide the emails into training and test data
m = size(X, 1);
randomIndices = randperm(m);
mTraining = int32(m * 0.7);

XTrain = X(randomIndices(1:mTraining), :);
yTrain = y(randomIndices(1:mTraining), :);
XTest = X(randomIndices(mTraining + 1:m), :);
yTest = y(randomIndices(mTraining + 1:m), :);

% Train and predict with traning data
C = 0.1;
model = svmTrain(XTrain, yTrain, C, @linearKernel);

p = svmPredict(model, XTrain);

fprintf('Training Accuracy: %f\n', mean(double(p == yTrain)) * 100);

% Predict on test data
fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, XTest);

fprintf('Test Accuracy: %f\n', mean(double(p == yTest)) * 100);
pause;

