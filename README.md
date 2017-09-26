# MNIST_Classification
Image category classification by alexnet and SVM

Breif Introduction:

    catch features: by CNN's last layer
    train model: by SVM

Dataset: MNIST dataset downloaded from https://www.kaggle.com/scolianni/mnistasjpg
    
    1. This dataset has been modified as a simpler one which contains 45 pictures for each digital 
    number category. 
    2. How to change: 
    First, add/delete pictures on the folders '0',...,'9'. This program will use the smallest number 
    of pictures in each folders as a common ammount for usage. 
    Second, in 'myTrain.m', one should use the comment lines in 'load image' part in stead of 
    load('myImage_Datasets.mat') to create a new dataset. One can also save it and load it when needed.
    
    
Trainning model: myTrain.m
    
    1.Splitting traing/test image sets: training set contains around 30% of the total datasets, 
    which can be modified in function 'splitEachLabel'.
    
    2. myTrain.m trains a multiclass SVM classifier by using the features extracted by the last layer 
    of Alexnet.
Testing model: myLabel.m and predict.m
    
    1. myLabel.m receives one sample image and returns a forecasting using a trained model which saved 
    by myTrain.m.
    2. predict.m selects 20 random pictures in testSet and does precition simultaneously using myLabel.m.
    
    
