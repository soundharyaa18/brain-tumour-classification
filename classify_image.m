function label = classify_image(imgPath)
% Predict the class of a single MRI image with the saved model.
% Usage: classify_image('brain_mri/Testing/glioma/Te-gl_0010.jpg')
    S = load('RandomForestModel.mat','RandomForestModel','mn','rg');
    raw = imread(imgPath);
    img = preprocessMRI(raw);
    f = (extractHOGFeatures(img,'CellSize',[6 6],'NumBins',12) - S.mn) ./ S.rg;
    label = char(predict(S.RandomForestModel, f));
    figure; imshow(raw); title(['Predicted: ' label]);
end
