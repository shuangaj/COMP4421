function [weakClassifiers, alpha] =  adaboost(h, y, T)
%ADABOOST - select T weak classifiers from h to form a stong classifiers
%           based on the ground truth label y
%Comments:
%       Function uses Standard Adaboost algorithm to select weak classifiers.
%
%Usage: [weakClassifiers, alpha] =  adaboost(h, y, T)
%
%Arguments:
%       h        - prediction result of weak classifiers
%       y        - ground truth label
%       T        - number of weak classifiers to be selected
%
%Returns:
%       weakClassifiers    - the indexs of selected weak classifier
%       alpha              - weights of the selected weak classifiers

% Start with equal weights on each image
[~,col] = size(y);
weights = ones(1,col);
alpha = zeros(1,T);
weakClassifiers = zeros(1,T);

% Select T weakClassifiers
for i = 1:T
    % Noemalize all weights
    weights = weights/sum(weights);
    
    % Select the weak classifier with minimum error
    error = sum(weights.*((1-h.*y))/2,2);
    [Ek, weakClassifiers(i)] = min(error);
    
    % Set weight for the selected weak classifier
    alpha(i) = log((1-Ek)/Ek)/2;
    
    % Reweight the examples(boosting)
    weights = weights.*exp(-alpha(i)*y.*h(weakClassifiers(i),:));
end

end