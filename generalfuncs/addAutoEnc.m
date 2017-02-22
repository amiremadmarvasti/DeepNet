function [ net ] = addAutoEnc( net,bits,block,lr,k )
%ADDAUTOENC Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : bits
net.layers{end+1} = struct('type', 'conv', ... 
                           'weights', {{.1*randn(1,1,k*block,k*(2^i)*block, 'single')/k, zeros(1, k*(2^i)*block, 'single')}}, ... 
                           'learningRate', lr, ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'birelu') ;
end
for i = bits :-1: 1
net.layers{end+1} = struct('type', 'conv', ... 
                           'weights', {{.1*randn(1,1,k*2*block,k*(2^i)*block, 'single')/k, zeros(1, k*(2^i)*block, 'single')}}, ... 
                           'learningRate', lr, ... 
                           'stride', 1, ... 
                           'pad', 0) ; 
net.layers{end+1} = struct('type', 'relu') ;
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
