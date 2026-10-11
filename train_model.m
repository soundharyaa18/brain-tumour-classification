%% Train a Random Forest on HOG features of the Training set
clc; clear; close all; rng(1);

datasetPath = 'brain_mri';   % folder containing Training/ and Testing/

imdsTrain = imageDatastore(fullfile(datasetPath,'Training'), ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
disp(countEachLabel(imdsTrain));

trainF = computeHOG(imdsTrain.Files);
trainLabels = imdsTrain.Labels;

% Min-max normalisation fitted on the training set only
mn = min(trainF,[],1);
rg = max(trainF,[],1) - mn;  rg(rg==0) = 1;
trainN = (trainF - mn) ./ rg;

RandomForestModel = TreeBagger(100, trainN, trainLabels, 'Method','classification');

RandomForestModel = compact(RandomForestModel);   % drop stored training data
save('RandomForestModel.mat','RandomForestModel','mn','rg');
disp('Model saved to RandomForestModel.mat');
