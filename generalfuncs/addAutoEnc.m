function [ net,currentBlockNum ] = addAutoEnc( net,decode,encode,block,lr,currentBlockNum )
% Outputs 2^(dec+1-enc)/d^enc blocks. Input should be 2 blocks. 
for i = 1 : decode
net.layers{end+1} = struct('type', 'conv', ... 
                           'weights', {{.1*randn(1,1,block,block*currentBlockNum, 'single'), zeros(1, block*currentBlockNum, 'single')}}, ... 
                           'learningRate', lr, ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu','block',block,'scatter',true) ;
currentBlockNum = currentBlockNum*2;
end
level = decode+1;
if isinf(encode)
    encode = floor(log2(currentBlockNum));
end
for i = 1 :1: encode
net.layers{end+1} = struct('type', 'conv', ... 
                           'weights', {{.1*randn(1,1,2*block,block*currentBlockNum/2, 'single'), zeros(1,block*currentBlockNum/2, 'single')}}, ... 
                           'learningRate', lr, ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'avr') ;
currentBlockNum = currentBlockNum/2;
if currentBlockNum<1
    error('shit')
end
end
end
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*block,k*2*block, 'single'), zeros(1, k*2*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*block,k*4*block, 'single'), zeros(1, k*4*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*block,k*8*block, 'single'), zeros(1, k*8*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
% %encode
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*4*block,k*4*block, 'single'), zeros(1, k*4*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*4*block,k*2*block, 'single'), zeros(1, k*2*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
% net.layers{end+1} = struct('type', 'conv', ... 
%                            'weights', {{0.01*randn(1,1,k*4*block,k*1*block, 'single'), zeros(1, k*1*block, 'single')}}, ... 
%                            'learningRate', lr, ... 
%                            'stride', 1, ... 
%                            'pad', 0) ; 
% net.layers{end+1} = struct('type', 'birelu') ;
