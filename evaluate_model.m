%% Evaluate the saved model on the Testing set
clc; clear; close all;

datasetPath = 'brain_mri';   % folder containing Training/ and Testing/

imdsTest = imageDatastore(fullfile(datasetPath,'Testing'), ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
testLabels = imdsTest.Labels;

load('RandomForestModel.mat','RandomForestModel','mn','rg');

testN = (computeHOG(imdsTest.Files) - mn) ./ rg;
preds = categorical(predict(RandomForestModel, testN), categories(testLabels));

acc = mean(preds == testLabels) * 100;
cm = confusionmat(testLabels, preds);
P = diag(cm)' ./ max(sum(cm,1),1);
R = diag(cm)' ./ max(sum(cm,2)',1);
F1 = 2*P.*R ./ max(P+R, eps);

fprintf('Accuracy: %.2f%%\n', acc);
disp(table(categories(testLabels), P', R', F1', ...
    'VariableNames', {'Class','Precision','Recall','F1'}));

figure; confusionchart(testLabels, preds);
title('Random Forest - confusion matrix');
exportgraphics(gcf, 'RandomForest_confusion.png');
