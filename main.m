clear;
close all;
clc;

% load data and split into train, vaidation and test sets
data = load('student_admissions.txt');
[m_total, ~] = size(data);
train_split = 0.6
val_split = 0.2
[X, y, Xval, yval, Xtest, ytest] = testTrainValSplit (data, m_total, train_split, val_split);

% plot the data
figure 1
hold on
plotData(X, y);
xlabel('Exam 1 score');
ylabel('Exam 2 score');
legend('Admitted', 'Not admitted', 'location', 'southwest');




##% linear svm
##% linear kernel matrix
##K = X*X';
##
##C = 1;
##model = trainSVM (K, X, y, C);
##
##% linear svm evaluation
##predictions = predictSVM(X, model, 'linear');
##fprintf('training set accuracy: %f\n', mean(double(predictions == y)) * 100);
##
##predVal = predictSVM(Xval, model, 'linear');
##fprintf('validation set accuracy: %f\n', mean(double(predVal == yval)) * 100);
##
##predTest = predictSVM(Xtest, model, 'linear');
##fprintf('test set accuracy: %f\n', mean(double(predTest == ytest)) * 100);
##
##figure 1
##hold on
##plotData(X, y);
##plotLineBoundry (X, model.theta)




% guassian svm
% guassian kernel matrix
sigma = 0.1;
kernelFunction = @(x1, x2) guassianKernel(x1, x2, sigma);
K = bsxfun(@plus, sum(X.^2, 2), bsxfun(@plus, sum(X.^2, 2)', - 2 * (X * X')));
K = kernelFunction(1, 0) .^ K;

C = 1;
model = trainSVM (K, X, y, C);

% guassian svm evaluation
predictions = predictSVM(X, model, 'guassianKernel');
fprintf('training set accuracy: %f\n', mean(double(predictions == y)) * 100);

predVal = predictSVM(Xval, model, 'guassianKernel');
fprintf('validation set accuracy: %f\n', mean(double(predVal == yval)) * 100);

predTest = predictSVM(Xtest, model, 'guassianKernel');
fprintf('test set accuracy: %f\n', mean(double(predTest == ytest)) * 100);


figure 2
hold on
plotData(X, y);
plotCurveBoundry(X, model);
