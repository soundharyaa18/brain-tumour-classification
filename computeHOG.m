function F = computeHOG(files)
% HOG feature matrix (one row per image) for a cell array of image paths.
    n = numel(files);
    f1 = hogOne(files{1});
    F = zeros(n, numel(f1), 'single');
    F(1,:) = f1;
    for i = 2:n
        F(i,:) = hogOne(files{i});
    end
end

function f = hogOne(file)
    img = preprocessMRI(imread(file));
    f = extractHOGFeatures(img, 'CellSize', [6 6], 'NumBins', 12);
end
