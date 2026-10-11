# Brain Tumour MRI Classification (HOG + Random Forest)

Classical machine-learning baseline that classifies brain MRI slices into four classes: **glioma, meningioma, pituitary tumour, no tumour**. Written in MATLAB.

## Pipeline

1. **Preprocessing** (`preprocessMRI.m`): resize to 200×200, grayscale, 3×3 median filter, CLAHE contrast enhancement.
2. **Features** (`computeHOG.m`): Histogram of Oriented Gradients, cell size 6×6, 12 orientation bins (49,152 features per image).
3. **Normalisation**: min-max scaling, fitted on the training set only and reused for the test set.
4. **Classifier** (`train_model.m`): Random Forest (`TreeBagger`, 100 trees).
5. **Evaluation** (`evaluate_model.m`): accuracy, per-class precision / recall / F1, confusion matrix on the held-out test set.
6. **Single-image prediction** (`classify_image.m`).

## Dataset

[Brain Tumor MRI Dataset (Kaggle, Masoud Nickparvar)](https://www.kaggle.com/datasets/masoudnickparvar/brain-tumor-mri-dataset). Images are not included in this repository. Download and unzip so that the folder `brain_mri/` contains `Training/` and `Testing/` (1,400 training and 400 test images per class in the version used).

## Example images

![Example MRI slices, one per class](images/class_examples.png)

*One axial test-set slice per class (glioma, meningioma, pituitary tumour, no tumour), taken from the Kaggle dataset above. Scan sequence, zoom and slice level vary between images. They illustrate the four classes the model is trained to separate; they are not model predictions.*

## How to run

```matlab
train_model      % trains and saves RandomForestModel.mat
evaluate_model   % prints metrics and saves RandomForest_confusion.png
classify_image('brain_mri/Testing/glioma/<image>.jpg')
```

Requires MATLAB with the Image Processing Toolbox and the Statistics and Machine Learning Toolbox. Change `datasetPath` at the top of the scripts if your folder has a different name.

## Results

*Results to be added after the final run of `train_model.m` and `evaluate_model.m`.*

## Limitations

- Classical hand-crafted-feature baseline; deep-learning approaches are expected to perform better.
- Single train/test split, no cross-validation.
- Research and learning project only, not a medical device.
