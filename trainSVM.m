function model = trainSVM (K, X, y, C)
  
  [m, n] = size(X); 
  tolerance = 1e-3;
  itterMax = 50;

  % map 0 to -1
  y(y==0) = -1;
  
  % SVM variables
  alphas = zeros(m, 1);
  b = 0;
  E = zeros(m, 1);
  itter = 0;
  eta = 0;
  L = 0;
  H = 0;   
  while itter < itterMax,
            
    num_changed_alphas = 0;
    for i = 1:m,
        
        E(i) = b + sum (alphas.*y.*K(:,i)) - y(i);
        
        if ((y(i)*E(i) < -tolerance && alphas(i) < C) || (y(i)*E(i) > tolerance && alphas(i) > 0)),
            
            j = ceil(m * rand());
            while j == i,
                j = ceil(m * rand());
            end

            E(j) = b + sum (alphas.*y.*K(:,j)) - y(j);

            alpha_i_old = alphas(i);
            alpha_j_old = alphas(j);
            
            if (y(i) == y(j)),
                L = max(0, alphas(j) + alphas(i) - C);
                H = min(C, alphas(j) + alphas(i));
            else
                L = max(0, alphas(j) - alphas(i));
                H = min(C, C + alphas(j) - alphas(i));
            end
           
            if (L == H),
                continue;
            end

            eta = 2 * K(i,j) - K(i,i) - K(j,j);
            if (eta >= 0),
                continue;
            end
            
            alphas(j) = alphas(j) - (y(j) * (E(i) - E(j))) / eta;
            
            alphas(j) = min (H, alphas(j));
            alphas(j) = max (L, alphas(j));
            
            if (abs(alphas(j) - alpha_j_old) < tolerance),
                alphas(j) = alpha_j_old;
                continue;
            end
             
            alphas(i) = alphas(i) + y(i)*y(j)*(alpha_j_old - alphas(j));
            
            b1 = b - E(i) ...
                 - y(i) * (alphas(i) - alpha_i_old) *  K(i,j)' ...
                 - y(j) * (alphas(j) - alpha_j_old) *  K(i,j)';
            b2 = b - E(j) ...
                 - y(i) * (alphas(i) - alpha_i_old) *  K(i,j)' ...
                 - y(j) * (alphas(j) - alpha_j_old) *  K(j,j)';

            if (0 < alphas(i) && alphas(i) < C),
                b = b1;
            elseif (0 < alphas(j) && alphas(j) < C),
                b = b2;
            else
                b = (b1+b2)/2;
            end

            num_changed_alphas = num_changed_alphas + 1;

        end
        
    end
    
    if (num_changed_alphas == 0),
        itter = itter + 1;
    else
        itter = 0;
    end
  end

  idx = alphas > 0;
  theta = [b ;((alphas.*y)'*X)'];
  
  % learning parameters
  model.theta = theta;
  % support vectors
  model.X = X(idx,:);
  model.y = y(idx);
  model.alphas = alphas(idx);

endfunction
