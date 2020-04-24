function sim = guassianKernel(x1, x2, sigma)

  sim = exp(-((norm(x1 - x2)).^2)/(2*(sigma.^2)));
    
end
