function pred = predictSVM (X, model, kernel)
  
  m = size(X, 1);
  p = zeros(m, 1);
  pred = zeros(m, 1);
    
  if strcmp(kernel, 'guassianKernel')    
    kernel = 'guassian';
    sigma = 0.01;
    kernelFunction = @(x1, x2) guassianKernel(x1, x2, sigma);
    
    X1 = sum(X.^2, 2);
    X2 = sum(model.X.^2, 2)';
    K = bsxfun(@plus, X1, bsxfun(@plus, X2, - 2 * X * model.X'));
    K = kernelFunction(1, 0) .^ K;
    K = bsxfun(@times, model.y', K);
    K = bsxfun(@times, model.alphas', K);
    p = sum(K, 2);    
    
  else 
    # linear kernel assumed
    kernel = 'linear';
    theta = model.theta;
    p = [ones(m, 1) X]*theta;
    
  end
  
  % Convert predictions into 0/1
  pred(p >= 0) =  1;
  pred(p <  0) =  0;
  
endfunction
