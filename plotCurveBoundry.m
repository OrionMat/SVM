function plotCurveBoundry (X, model)
  
  % make classification predictions over a grid of values
  x1plot = linspace(min(X(:,1)), max(X(:,1)), 100)';
  x2plot = linspace(min(X(:,2)), max(X(:,2)), 100)';
  [X1, X2] = meshgrid(x1plot, x2plot);
  vals = zeros(size(X1));
  for i = 1:size(X1, 2)
     this_X = [X1(:, i), X2(:, i)];
     vals(:, i) = predictSVM (this_X, model, 'guassianKernel');
  end
  
  % Plot the SVM boundary
  contour(X1, X2, vals, [100, 100], 'm', 'LineWidth', 3);
  
endfunction