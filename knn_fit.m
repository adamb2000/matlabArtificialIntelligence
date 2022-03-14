% Description: create a model ready to perform k-NN classification
% from some training data (assuming k=1 initially)
%
% Inputs:
% train_examples: a numeric array containing the training examples
% train_labels: a categorical array containing the associated
% labels (i.e., with the same ordering as train_examples)
% 
% Outputs:
% m: a struct holding the parameters of the k-NN model (the
% training examples, the training labels, and a value for k - the number of
% nearest neighbours to use)
% 
% Notes:
% This method should be relatively short and simple, perhaps just a
% few lines of code appropriately commented.
%
function m = knn_fit(train_examples, train_labels,k)


    m = struct;
    m.train_example = train_examples;   %puts all of the given values into a structure to be used in the knn_predict
    m.train_label = train_labels;
    m.k = k;
    
end