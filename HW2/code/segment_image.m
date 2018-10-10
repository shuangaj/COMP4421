% SEGMENT_PANDA contains the implementation of the main routine for Assignment 2. 
% This routine reads a image, which contains three intensity classes.
% The routine employs the Expectation-maximization method to estimate the parameters
% of the three intensity classes with a mixture of three Gaussian distributions, and
% segment the image with minimum error thresholds.
%  
function segment_image() 

% Define convergence threshold.
threshold = 0.01;

% Read the panda image and convert the color image into grayscale image.
Im = imread('sunset.jpg');
Im = rgb2gray(Im);
V_Im = double(reshape(Im, 1, [])');
[n,m] = size(Im);
% Build a histgoram of the image, it is for the sake of
% parameter estimations and visualization.
Hist = imhist(Im,256)';
%
% The Expectation-maximization algorithm.
%

% Initialize the paramters.
Weight = zeros(3,1);
Mu = zeros(3,1);
Sigma = zeros(3,1);
Weight(1) = 0.35;
Weight(2) = 0.25;
Weight(3) = 0.40;
Mu(1) = 5;
Mu(2) = 90;
Mu(3) = 230;
Sigma(1) = 1;
Sigma(2) = 10;
Sigma(3) = 20;

itn = 1;
while(1)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_1: Estimate the expected posterior probabilities.
    likelihood_1 = normpdf(V_Im,Mu(1),Sigma(1));
    likelihood_2 = normpdf(V_Im,Mu(2),Sigma(2));
    likelihood_3 = normpdf(V_Im,Mu(3),Sigma(3));
    Expectation = likelihood_1*Weight(1) + likelihood_2*Weight(2) + likelihood_3*Weight(3);
    posterior_1 = likelihood_1*Weight(1)./Expectation;
    posterior_2 = likelihood_2*Weight(2)./Expectation;
    posterior_3 = likelihood_3*Weight(3)./Expectation;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Allocate spaces for the parameters estimated.
	NewWeight = zeros(3,1);
	NewMu = zeros(3,1);
	NewSigma = zeros(3,1);
    
    % TODO_2: Estimate the parameters.
    NewMu(1) = sum(sum(posterior_1.*V_Im))/sum(sum(posterior_1));
    NewMu(2) = sum(sum(posterior_2.*V_Im))/sum(sum(posterior_2));
    NewMu(3) = sum(sum(posterior_3.*V_Im))/sum(sum(posterior_3));
    NewSigma(1) = sqrt(sum(sum(posterior_1.*((V_Im - NewMu(1)).^2)))/sum(sum(posterior_1)));
    NewSigma(2) = sqrt(sum(sum(posterior_2.*((V_Im - NewMu(2)).^2)))/sum(sum(posterior_2)));
    NewSigma(3) = sqrt(sum(sum(posterior_3.*((V_Im - NewMu(3)).^2)))/sum(sum(posterior_3)));
    NewWeight(1) = sum(sum(posterior_1)) / (n*m);
    NewWeight(2) = sum(sum(posterior_2)) / (n*m);
    NewWeight(3) = sum(sum(posterior_3)) / (n*m);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
    % Check if convergence is reached.
	DiffWeight = abs(NewWeight-Weight)./Weight;
	DiffMu = abs(NewMu-Mu)./Mu;
	DiffSigma = abs(NewSigma-Sigma)./Sigma;
	
	if (max(DiffWeight) < threshold) && (max(DiffMu) < threshold) && (max(DiffSigma) < threshold)
        break;
	end
	
	% Update the parameters.
	Weight = NewWeight;
	Mu = NewMu;
	Sigma = NewSigma;
    
    disp(['Iteration #' num2str(itn)]);
    disp([' Weight: ' num2str(Weight(1)) ' ' num2str(Weight(2)) ' ' num2str(Weight(3))]);
    disp([' Mu: ' num2str(Mu(1)) ' ' num2str(Mu(2)) ' ' num2str(Mu(3))]);
    disp([' Sigma: ' num2str(Sigma(1)) ' ' num2str(Sigma(2)) ' ' num2str(Sigma(3))]);
    itn = itn + 1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO_3(a): Compute minimum error threshold between the first and the second
% Gaussian distributions.
%
% FirstThreshold = ?
% FirstThreshold = (Mu(1)+Mu(2))/2 + (Sigma(1)^2/(Mu(1)-Mu(2)))*log(Weight(2)/Weight(1));
syms x
eqn = (x-Mu(2))^2/(2*Sigma(2)^2) - (x-Mu(1))^2/(2*Sigma(1)^2) == log((Weight(2)*Sigma(1))/(Weight(1)*Sigma(2)));
result_1 = vpasolve(eqn,x);
FirstThreshold = double(result_1(result_1<Mu(2) & result_1>Mu(1)));
% TODO_3(b): Compute minimum error threshold between the second and the third
% Gaussian distributions.
%
% SecondThreshold = ?
%SecondThreshold = (Mu(2)+Mu(3))/2 + (Sigma(2)^2/(Mu(2)-Mu(3)))*log(Weight(3)/Weight(2));
syms x
eqn = (x-Mu(3))^2/(2*Sigma(3)^2) - (x-Mu(2))^2/(2*Sigma(2)^2) == log((Weight(3)*Sigma(2))/(Weight(2)*Sigma(3)));
result_2 = vpasolve(eqn,x);
SecondThreshold = double(result_2(result_2<Mu(3) & result_2>Mu(2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show the segmentation results.
figure;
subplot(2,3,1);imshow(Im);title('Sunset');
subplot(2,3,3);imshow(Im<=FirstThreshold);title('First Intensity Class');
subplot(2,3,4);imshow(Im>FirstThreshold & Im<SecondThreshold);title('Second Intensity Class');
subplot(2,3,5);imshow(Im>=SecondThreshold);title('Third Intensity Class');
Params = zeros(9,1);
Params(1) = Weight(1);
Params(2) = Mu(1);
Params(3) = Sigma(1);
Params(4) = Weight(2);
Params(5) = Mu(2);
Params(6) = Sigma(2);
Params(7) = Weight(3);
Params(8) = Mu(3);
Params(9) = Sigma(3);
subplot(2,3,2);ggg(Params,Hist);