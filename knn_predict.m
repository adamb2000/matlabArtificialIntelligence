% Description: use an existing k-NN model to classify some testing examples 
%
% Inputs:
% m: a struct containing details of the k-NN model we want to use
% for classification 
% test_examples: a numeric array containing the testing examples we want to
% classify
% 
% Outputs:
% predictions: a categorical array containing the predicted
% labels (i.e., with the same ordering as test_examples)
%
% Notes:
% Assumes that the model m has been created with a call to knn_fit()
% 
function predictions = knn_predict(m, test_examples)

    % Guidance (first task):
    % 1. initialise an empty categorical array to hold the predictions
    % 2. loop over every example in the testing_examples array
    % and... 
    %   a. find its nearest neighbour in the data inside the
    %   model
    %   b. take the label associated with that nearest neighbour as
    %   your prediction
    %   c. add the new prediction onto the end of your categorical
    %   array (from step 1)
    
    % Guidance (second task):
    % adjust your code to take account of the k value set inside the model
    % m. Adjust step a from above so that all k nearest neighbours are
    % found. Adjust step b from above to take the the most common class
    % label across all k nearest neighbours as your prediction

    predictions = categorical;
    % add your code and comments on the lines below:


    for i=1:1:size(test_examples,1) %loop over all the values in test_examples
        tempArray = []; %array created to hold all of the neighbours distances
        for j=1:1:size(m.train_example,1)%for each test_example, loop over all of the train_examples
            distance = knn_calculate_distance(test_examples(i,:),m.train_example(j,:)); %distance for test_example - train_example calculated
            tempArray = [tempArray,distance];   %distance to this specific train_example added to list
        end

        sortedArray = sort(tempArray);%sorts the array to put the smallest values (closest) to the front
        neighbours = [];    
        for j=1:1:m.k %does k amount of loops, with k= the amount of nearest neighbours specified
            foundItem = find(tempArray == sortedArray(j));  %match one of the nearest neighbours with a value in the pre-sorted array (to find correct index of label)
            neighbours = [neighbours,m.train_label(foundItem(1))]; %add the label of one of  the nearest neighbours to the 
        end
        mo = mode(neighbours);  %find the most commonly occuring nearest neighbour and use this as the prediction for this specific test_example

        predictions = [predictions;mo];
    end

end