function img = preprocessMRI(img)
% Resize to 200x200, convert to grayscale, median filter, CLAHE.
    img = imresize(img, [200 200]);
    if size(img,3) == 3
        img = rgb2gray(img);
    end
    img = medfilt2(img, [3 3]);
    img = adapthisteq(img);
end
