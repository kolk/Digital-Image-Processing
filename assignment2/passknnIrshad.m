clear
clc
feat2Train = load('/home/vaishali/Documents/courses/MachineLearningJawaharCV/Assignment1 ML 2k15/data/feat2/train/trainFeatures.mat');
feat2Test = load('/home/vaishali/Documents/courses/MachineLearningJawaharCV/Assignment1 ML 2k15/data/feat2/test/testFeatures.mat');
feat2Train =  feat2Train.projTrainFtrs;
feat2Test = feat2Test.projTestFtrs;

trainLabels = vec_read('/home/vaishali/Documents/courses/MachineLearningJawaharCV/Assignment1 ML 2k15/data/corel5k.20091111/corel5k_train_annot.hvecs');
index = load('/home/vaishali/Documents/courses/MachineLearningJawaharCV/Assignment1 ML 2k15/data/feat2/train/randpick.txt');
trainLabels = trainLabels(index, :);
testLabels = vec_read('/home/vaishali/Documents/courses/MachineLearningJawaharCV/Assignment1 ML 2k15/data/corel5k.20091111/corel5k_test_annot.hvecs');


pairwise_distances = pdist2(feat2Train, feat2Test, 'cityblock');
minDist = min(pairwise_distances(:));
maxDist = max(pairwise_distances(:));
normalizedDist = (pairwise_distances(:,:) -  minDist) / (maxDist - minDist);
for k = 1:5
p = twopassknn(normalizedDist, trainLabels, testLabels, k, 15, 5);
p
end