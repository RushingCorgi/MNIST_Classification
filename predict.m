mode = input('Mode type:');
if mode == 1 %mode 1 runs the whole program
    %----------------Train or load the trained model--------------------------------
    %make sure we only train model once to save time
    net = alexnet();
    featureLayer = 'fc7';
    TrainModeExist = exist('classifier.mat','file');
    TestSetExist = exist('testSet.mat','file');
    if TrainModeExist==2 && TestSetExist==2
        load('testSet.mat');
        load('classifier.mat');
        traintype='load';
    else
        [classifier,testSet]=myTrain(net,featureLayer);
        save('testSet.mat','testSet');
        save('classifier.mat','classifier')
        traintype='run';
    end
    
    %---------------- get 20 sample images prepared------------------------
    label = zeros(20,1);
    truelabel=zeros(20,1);
    testLabels = testSet.Labels;
    %choose 20 different integers from 0 to 9
    Index_img = randi([1,numel(testSet.Labels)],20,1);
    %find 20 random corresponding pictures in testSet
    for i=1:20
        %read the 20 images from testSet
        eval(['img' num2str(i) '=readimage(testSet,Index_img(' num2str(i) '))'])
        %get the true value of the 20 numbers from testSet
        eval(['truelabel(' num2str(i) ')=grp2idx(testLabels(Index_img(' num2str(i) ')))-1']);
    end
    
    %Do prediction
    
    for i=1:20
        %predict each image and get the label
        eval(['type= myLabel(img' num2str(i) ',classifier,net,featureLayer)'])
        eval(['label(' num2str(i) ') = grp2idx(type)-1'])
    end
    % plot the prediction
    figure;
    for i=1:20
        subplot(4,5,i);
        eval(['imshow(img' num2str(i) ')'])
        if truelabel(i)==label(i)
            title(['\color{blue}prediction: ',num2str(label(i))])
        else
            %the title will be red if the prediction is wrong
            title(['\color{red}prediction: ',num2str(label(i))])
        end
    end
    
    saveas(gcf,'prediction.fig')
elseif mode==2 %mode 2 only plot the existing sample
    test=exist('prediction.fig','file');
    if test==2
        load('prediction.fig','-mat');
    else
        disp('Sample figure does not exist, please run mode 1 to get it')
    end
    
else
    disp('Please enter the correct mode type number.')
end