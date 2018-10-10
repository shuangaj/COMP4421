%   MAIN.m runs adaboost function for assignment 3.
%   REMINDER: You cannot modify this file.


% training data
y = [1 1 1 1 -1 -1 -1 -1 -1] ;
% Weak classifier responses on the training data
h = zeros(3,9) ;
h(1,:) = [1, 1, 1, 1, -1, -1, -1, 1, -1];
h(2,:) = [1, 1, -1, 1, 1, -1, -1, 1, -1];
h(3,:) = [-1, 1, 1, 1, -1, -1, 1, -1, 1];

% k is the number of weak classifier we need
k = 2;

% weakClassifiers stores the index of selected weak classifier
% alpha stores the weights of the selected weak classifiers
[weakClassifiers, alpha] = adaboost(h, y, k)

% Display the selected weak classifier(s) and its corresponding weight
weakClassifiers
alpha

% Strong classifier responses on the training data
H = sign(alpha * h(weakClassifiers, :))
