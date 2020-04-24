function [Xtrain, ytrain, Xval, yval, Xtest, ytest] = testTrainValSplit (data, m, train_split, val_split)
  
  num_training = round(train_split * m);
  num_validation = round(val_split * m);
  rand_idxs = randperm(m);

  training_idxs = rand_idxs(1:num_training);
  val_idxs = rand_idxs(num_training+1:num_training+1+num_validation);
  testing_idxs = rand_idxs(num_training+1+num_validation+1:end);

  Xtrain = data(training_idxs, 1:end-1); 
  ytrain = data(training_idxs, end);
  Xval = data(val_idxs, 1:end-1); 
  yval = data(val_idxs, end);
  Xtest = data(testing_idxs, 1:end-1); 
  ytest = data(testing_idxs, end); 

endfunction