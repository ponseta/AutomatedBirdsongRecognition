% The script presented here is a modification of the auto-generated code that 
% MATLAB creates when using Deep Learning Toolbox for training a neural network
% It saves the net in finalNeuralNetworkFunction.m

% Load inputs for training the net
% Prepare inputs - input data and outputs - target data
% Set training characteristics
% Train

% load('inputs20dB.mat');
load('inputs20dB-areanormal.mat')


% All MFCCs in a vector and Desired output
inputs = zeros(ninputs,2*nbanks); 
outputs = zeros(ninputs,1);
ij = 0;
for j = 1:size(data,1)
    for i=1:size(data{j,5},1)
        ij = ij + 1;
        %inputs(ij,:) = data{j,7}; %Wavelet
        inputs(ij,:) = data{j,5}(i,:); %MFFCs
        outputs(ij,1) = data{j,8}(1);
    end
end



% Proportional quantity of 0s and 1s in each subset randomly 
% ordered
[trainInd,valInd,testInd] = divideint(size(inputs,1),0.65,0.15,0.2);

orderTrainInd = randperm(size(trainInd,2)); 
inputstrain = inputs(trainInd(orderTrainInd),:);
outputstrain = outputs(trainInd(orderTrainInd),:); 

orderTrainVal = randperm(size(valInd,2));
inputsval = inputs(valInd(orderTrainVal),:);
outputsval = outputs(valInd(orderTrainVal),:);

orderTrainTest = randperm(size(testInd,2));
inputstest = inputs(testInd(orderTrainTest),:);
outputstest = outputs(testInd(orderTrainTest),:);

inputs = [inputstrain; inputsval; inputstest];
outputs = [outputstrain; outputsval; outputstest];


init(net)

% x = inputs(:,[1:13 42:42+12])'; % With zeroed MFCC
x = inputs(:,[2:13 43:42+12])'; % Without zeroed MFCC
t = outputs(:,1)';
t(2,:) = ~t(1,:);

% Choose a Training Function
% trainFcn = 'trainrp'; % Resilient backpropagation
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.


% Create a Pattern Recognition Network
hiddenLayerSize = 2;
net = patternnet(hiddenLayerSize, trainFcn);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'softmax';


% Choose Input and Output Pre/Post-Processing Functions
% net.input.processFcns = {'removeconstantrows','mapminmax'};
net.input.processFcns = {'removeconstantrows'};
net.output.processFcns = {};

% Setup Division of Data for Training, Validation, Testing
% net.divideFcn = 'dividerand';  % Divide data randomly
% net.divideMode = 'sample';  % Divide up every sample
% net.divideParam.trainRatio = 65/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 20/100;
% net.divideFcn = 'divideint'; 
net.divideFcn = 'divideind'; % Partition indices into three sets using specified indices
net.divideParam.trainInd = 1:length(trainInd);
net.divideParam.valInd   = 1+length(trainInd):length(trainInd)+length(valInd);
net.divideParam.testInd  = 1+length(trainInd)+length(valInd):length(trainInd)+length(valInd)+length(testInd);


% Choose a Performance Function
net.performFcn = 'crossentropy';  % Cross-Entropy


% Choose Plot Functions
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotconfusion', 'plotroc'};

% Train the Network
% rng(0), [net,tr] = train(net,x,t); %Same init weights
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% Recalculate Training, Validation and Test Performance
trainPerformance = perform(net,t(tr.trainInd),y(tr.trainInd))
valPerformance = perform(net,t(tr.valInd),y(tr.valInd))
testPerformance = perform(net,t(tr.testInd),y(tr.testInd))



% View the Network
view(net)

% Deployment

if (true)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
    genFunction(net,'finalNeuralNetworkFunction');
    save('tr')
end
