%train a CNN model for image category classification
function [classifier,testSet]=myTrain(net,featureLayer)
%-------------------load image------------------------------------
%categories = {'0', '1', '2','3','4','5','6','7','8','9'};
%imds = imageDatastore(fullfile(categories), 'LabelSource', 'foldernames');
%tbl = countEachLabel(imds);
%minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category.
%imds = splitEachLabel(imds, minSetCount, 'randomize');
DatasetExist=exist('myImage_Datasets.mat','file');
if DatasetExist==2
    load('myImage_Datasets.mat');
    %-------------------load pre-trained AlexNet network---------------
    %-------------------pre-process images-----------------------------
    % Set the ImageDatastore ReadFcn
    imds.ReadFcn = @(filename)readAndPreprocessImage(filename);
    %splitting traing/test image sets
    [trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');
    % ------------------Extract features-------------------------------
    %****extract good features********
    trainingFeatures = activations(net, trainingSet, featureLayer, ...
        'MiniBatchSize', 32, 'OutputAs', 'columns');
    %------------------------Train SVM-----------------------------
    % Get training labels from the trainingSet
    trainingLabels = trainingSet.Labels;
    
    % Train multiclass SVM classifier using a fast linear solver, and set
    % 'ObservationsIn' to 'columns' to match the arrangement used for training
    % features.
    classifier = fitcecoc(trainingFeatures, trainingLabels, ...
        'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
else
    disp('Image dataset needed.')
end
