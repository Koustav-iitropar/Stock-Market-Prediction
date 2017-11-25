clear all;
file=importdata('DJI_20.csv',',',1);
X_train=file.data(:,1:2);
Y_train=file.data(:,5);
Model = fitlm(X_train,Y_train);
%Model = fitrsvm(X_train,Y_train,'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus'));
%%
test=importdata('DJI_test.csv',',',1);
X_test=test.data(:,1:2);
Y_test=test.data(:,3);
a=predict(Model,X_test);
plot(a)
hold on
plot(Y_test);