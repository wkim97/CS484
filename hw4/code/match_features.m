% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Please implement the "nearest neighbor distance ratio test", 
% Equation 4.18 in Section 4.1.3 of Szeliski. 
% For extra credit you can implement spatial verification of matches.

%
% Please assign a confidence, else the evaluation function will not work.
%

% This function does not need to be symmetric (e.g., it can produce
% different numbers of matches depending on the order of the arguments).

% Input:
% 'features1' and 'features2' are the n x feature dimensionality matrices.
%
% Output:
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index in features2. 
%
% 'confidences' is a k x 1 matrix with a real valued confidence for every match.

function [matches, confidences] = match_features(features1, features2)

% % Placeholder random matches and confidences.
% num_features = min(size(features1, 1), size(features2,1));
% matches = zeros(num_features, 2);
% matches(:,1) = randperm(num_features); 
% matches(:,2) = randperm(num_features);

[N K] = size(features1);
matches = zeros(N, 2);
confidences = zeros(N, 1);
threshold = 0.75;

neighbors = zeros(N, N);
for i = 1:N
    for j = 1:N
        % NxN matrix of all possible matches between all feature points
        % Row = same features1 points
        % Col = same features2 points
        neighbors(i,j) = sqrt(sum((features1(i,:) - features2(j,:)).^2)); 
    end
end
% neighbors sorted based on features2 points
% e.g. col1 = neighbors of 1st features2, col2 = neighbors of 2nd features2
[neighbors, index] = sort(neighbors);
for i = 1:N
    ratio = neighbors(1,i)/neighbors(2,i);
    if (ratio < threshold)
        matches(i,2) = i;
        matches(i,1) = index(1,i);
        confidences(i) = 1 - ratio;
    end
end
matches( ~any(matches,2), : ) = [];
confidences( ~any(confidences,2), : ) = [];

[confidences, sort_index] = sort(confidences, 'descend');
matches = matches(sort_index,:);

% Remember that the NNDR test will return a number close to 1 for 
% feature points with similar distances.
% Think about how confidence relates to NNDR.