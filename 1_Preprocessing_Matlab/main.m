%% load data
clc
clear; close all;

%This line of code adds the path to your data. Data are supposed to be in a
%folder. They should contain the X,Y trajectories of the Eye-Tracking
%recordings, and any flag for reaction times RTs in case accounted by the
%experimental task. 

addpath _Dataset
%% load and pre-process all the file within a Folder

% Read path for every mat file containing the X,Y trajectories 
mat = dir('_Dataset/*.mat');

%3000 is the length of our trials, input your maximal length instead.
N = 3000;
%This variable is commented as we have it in our recordings, however if you
%don't, set it to the maximal length of the trial N (here 3000)
%RTs = 0; %This flag is 0 if in the task there are behavioral controls for target reaching - as in our case. This variable is overwritten in the loop

X_all = [];
Y_all = [];
Y_label = []; 

%Loop over subjects
for q = 1:length(mat)
    
    load(mat(q).name)
    %EyeX_ and EyeY_ are the name of variables of the X and Y trajectories
    %Replace the variable name according to your dataset
    
    %We inizialise the length of our variables, and we standardise the
    %size of the matrix we are processing. If the trials are shorter, we
    %fill with NaN that are further processed afterwards. 
    length_traject = size(EyeX_,2);
    EyeX_unif = zeros(size(EyeX_,1),N);
    EyeY_unif = zeros(size(EyeY_,1),N);
    
    % Filling in until Max duration of the trial according to the sampling rate.
    % In this case it was 9s (length = 3000, sampling rate 0.003), to uniform RAW data 
    EyeX_unif(:,(length_traject+1):N) = NaN;
    EyeX_unif(:,1:length_traject) = EyeX_;
    EyeY_unif(:,(length_traject+1):N) = NaN;
    EyeY_unif(:,1:length_traject) = EyeY_;
    
    % Call the preprocessing function to format the data for the
    % Machine-Learning technique
    [rawx,rawy] = preprocessing(EyeX_unif,EyeY_unif,RTs);
    
    % Create X raw matrix, with Label vector; 
    X_all = [X_all; rawx];
    Y_all = [Y_all; rawy];
    Y_label = [Y_label; [Label*ones(size(rawx,1),1), q*ones(size(rawx,1),1)]];
    
    
    %clear up the variables before reading new ones
    clear rawx; clear rawy; clear EyeX_; clear EyeY_; clear EyeX_unif; clear EyeY_unif; clear Label;
     
end

%% Define Label and Subject ID
Y = Y_label(:,1);
Sub_ID = Y_label(:,2);

%% Here you can save the data
%save('X_coord.mat','X_all') 
%save('Y_coord.mat','Y_all') 
%save('Label.mat','Y') 
%save('Sub_ID.mat','Sub_ID') 