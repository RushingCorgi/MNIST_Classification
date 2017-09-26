function label = myLabel(img,classifier,net,featureLayer)
%----------------------try classification-------------------------
% Extract image features using the CNN
imageFeatures = activations(net, img, featureLayer);
% Make a prediction using the classifier
label = predict(classifier, imageFeatures);
