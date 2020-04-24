function plotData(X, y)

% find indices of positive and negative Examples
pos = find(y == 1); 
neg = find(y == 0);

plot(X(pos, 1), X(pos, 2), 'r+','LineWidth', 3, 'MarkerSize', 10);
plot(X(neg, 1), X(neg, 2), 'bo', 'LineWidth', 3,'MarkerSize', 7);

end