function predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

% This function should train a linear SVM for every category (i.e., one vs all)
% and then use the learned linear classifiers to predict the category of
% every test image. Every test feature will be evaluated with all 15 SVMs
% and the most confident SVM will "win".
% 
% Confidence, or distance from the margin, is W*X + B:
% The learned hyperplane is represented as:
% - W, a row vector
% - B, a scalar bias or offset
% X is a column vector representing the feature, and
% * is the inner or dot product.

%
% A Strategy
% 
% - Use fitclinear() to train a 'one vs. all' linear SVM classifier.
% - Observe the returned model - it defines a hyperplane with weights 'Beta' and 'Bias'.
% - For a test feature point, manually compute the distance form the hyperplane using the model parameters.
% - Store the confidence.
% - Once you have a confidence for every category, assign the most confident category.
% 

% unique() is used to get the category list from the observed training category list. 
% 'categories' will not be in the same order as unique() sorts them. This shouldn't really matter, though.
categories = unique(train_labels);
num_categories = length(categories);
[N,~] = size(train_image_feats);
[M,~] = size(test_image_feats);
predicted_categories = cell(M,1);
B_results = [];
W_results = [];

for c = 1:num_categories
    inds = zeros(N,1);
    inds(:,:) = -1;
    inds(strcmp(train_labels, categories{c})) = 1;
    model = fitcsvm(train_image_feats, inds);
    B = model.Bias;
    W = (model.Beta)';
    B_results = [B_results; B];
    W_results = [W_results; W];
end

for i = 1:M
    best_label = zeros(num_categories,1);
    for l = 1:num_categories
        best_label(l) = dot(W_results(l,:), test_image_feats(i,:)) + B_results(l);
    end
    [best_label,ind] = sort(best_label, 'descend');
    predicted_categories{i} = categories{ind(1)};
end
end