function net = cnn_cifar_init_nin(varargin) 
opts.networkType = 'simplenn' ; 
opts = vl_argparse(opts, varargin) ; 
 
% CIFAR-10 model from 
% M. Lin, Q. Chen, and S. Yan. Network in network. CoRR, abs/1312.4400, 2013. 
 
net.layers = {} ; 
b=0 ; 
k=1; 
R = 1;
% Block 1 
i =1;
j = 1;
g =1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'conv1', ... 
                           'weights', {{0.01*randn(5,5,3,k*192,'single')/R, b*ones(1,k*192,'single')}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 2) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu1') ; 
j = j+1;
g =2;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp1', ... 
                           'weights', {{0.05*randn(1,1,k*192,k*160, 'single')/R, b*ones(1,k*160,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu_cccp1') ; 
j = j+1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp2', ... 
                           'weights', {{0.05*randn(1,1,k*160/2,k*96*2,'single')/R, b*ones(1,k*96*2,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu_cccp2') ; 
net.layers{end+1} = struct('name', 'pool1', ... 
                           'type', 'pool', ... 
                           'method', 'avg', ... 
                           'pool', [3 3], ... 
                           'stride', 2, ... 
                           'pad', 0) ; 
%net.layers{end+1} = struct('type', 'dropout', 'name', 'dropout1', 'rate', 0.5) ; 
 
% Block 2 
i = i+1;
j = 1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'conv2', ... 
                           'weights', {{0.05*randn(5,5,k*96/2,k*192*2,'single')*2/R, b*ones(1,k*192*2,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 2) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu2') ; 
j = j+1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp3', ... 
                           'weights', {{0.05*randn(1,1,k*192/4,k*192*2,'single')*4/R, b*ones(1,k*192*2,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu_cccp3') ; 
j = j+1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp4', ... 
                           'weights', {{0.05*randn(1,1,k*192/2,k*192*2, 'single')*2/R, b*ones(1,k*192*2,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu_cccp4') ; 
net.layers{end+1} = struct('name', 'pool2', ... 
                           'type', 'pool', ... 
                           'method', 'avg', ... 
                           'pool', [3 3], ... 
                           'stride', 2, ... 
                           'pad', 0) ; 
%net.layers{end+1} = struct('type', 'dropout', 'name', 'dropout2', 'rate', 0.5) ; 
 
% Block 3 
i = i+1;
j = 1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'conv3', ... 
                           'weights', {{0.05*randn(3,3,k*192/2,k*192,'single')/R, b*ones(1, k*192, 'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 1) ; 
net.layers{end+1} = struct('type', 'birelu', 'name', 'relu3') ; 
j = j+1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp5', ... 
                           'weights', {{0.05*randn(1,1,k*192,k*192,'single')/R, b*ones(1,k*192,'single')/R}}, ... 
                           'learningRate', [.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'relu', 'name', 'relu_cccp5') ; 
j = j+1;
net.layers{end+1} = struct('type', 'conv', ... 
                           'name', 'cccp6', ... 
                           'weights', {{0.05*randn(1,1,k*192,10, 'single')/R, b*ones(1,10,'single')/R}}, ... 
                           'learningRate', 0.1*[.1 2], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
%net.layers{end+1} = struct('type', 'birelu', 'name', 'relu_cccp6') ; 
net.layers{end+1} = struct('type', 'pool', ... 
                           'name', 'pool3', ... 
                           'method', 'avg', ... 
                           'pool', [7 7], ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
 
% Loss layer 
net.layers{end+1} = struct('type', 'softmaxloss') ; 
 
% Meta parameters 
net.meta.inputSize = [32 32 3] ; 
net.meta.trainOpts.learningRate = [0.5*ones(1,30) 0.1*ones(1,10) 0.02*ones(1,5) 0.005*ones(1,5) 0.0005*ones(1,5) ]  ; 
net.meta.trainOpts.weightDecay = 0.0005 ; 
net.meta.trainOpts.batchSize = 100 ; 
net.meta.trainOpts.numEpochs = numel(net.meta.trainOpts.learningRate) ; 
 
% Fill in default values 
net = vl_simplenn_tidy(net) ; 
 
% Switch to DagNN if requested 
switch lower(opts.networkType) 
  case 'simplenn' 
    % done 
  case 'dagnn' 
    net = dagnn.DagNN.fromSimpleNN(net, 'canonicalNames', true) ; 
    net.addLayer('error', dagnn.Loss('loss', 'classerror'), ... 
      {'prediction','label'}, 'error') ; 
  otherwise 
    assert(false) ; 
end 
