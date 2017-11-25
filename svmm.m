% .1 % increase per day
clear all;
file=importdata('DJI_20.csv',',',1);
X_train=file.data(:,1:2);
s=size(file.data,1);
Y_train=zeros(s,1);
% Y_train=logical(ceil(  (file.data(:,5)- file.data(:,1))/   ));
for i=1:size(file.data,1)
    if file.data(i,5)>1.005*file.data(i,1)
        Y_train(i)=1;
    end
end
Y_train=logical(Y_train);
%%
Model=fitcsvm(X_train,Y_train);
%%
test=importdata('DJI.csv',',',1);
X_test=test.data(:,1:2);
% Y_test=logical(ceil(test.data(:,3)- test.data(:,1)));
for i=1:size(test.data,1)
    if test.data(i,3)>1.001*test.data(i,1)
        Y_test(i)=1;
    end
end
Y_test=logical(Y_test);
a=predict(Model,X_test);
%%
acc=sum((Y_test.*a))/size(a,1);