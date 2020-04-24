function plotLineBoundry (X, theta)
  x = linspace(min(X(:,1)), max(X(:,1)), 100); % no bias
  y = - (theta(2)*x + theta(1))/theta(3);
  plot(x, y, '-m', 'LineWidth', 3); 
endfunction
