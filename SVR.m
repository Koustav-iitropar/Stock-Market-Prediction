clear all;
file=importdata('DJI.csv',',',1);
X=file.data(:,1:2);
Y=file.data(:,3);
Model = fitrsvm(X,Y);
