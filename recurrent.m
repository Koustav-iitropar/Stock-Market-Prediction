clear all;
file=importdata('DJI.csv',',',1);
% file.data=normc(file.data);
B=normc([file.data(:,1) file.data(:,6)]);
Y=file.data(:,5);
size1=4;
size2=2;
alpha=0.01;
size3=1;
w1=-0.01+rand(size1+1,size2)*0.02;
w2=-0.01+rand(size2+1,size3)*0.02;
H=-0.01+rand(size2,1)*0.02;
% train_size=floor(80/100*size(B,1));
train_size=size(B,1);
test_size=size(B,1)-train_size;
train_points=zeros(size(train_size,1));
test_points=zeros(size(test_size,1));
nEpochs=500;
train_error=zeros(nEpochs,1);
test_error=zeros(nEpochs,1);
error=zeros(train_size,1);
for j=1:1
H=-0.01+rand(size2,1)*0.02;
 for i=1:train_size
 X=[1 B(i,:) H(1,1) H(2,1)]';
 H=w1'*X;
 H=spicy(H);
 X2=[1; H];
 o=w2'*X2;
t2=X2*(o-Y(i));
t1=X*(((o-Y(i))*w2(2:end)').*H'.*(1-H'));
w2=w2-alpha*t2;
w1=w1-alpha*t1;
error(i)=meansquarederr(o,Y(i));
fprintf('o , y and error are %f %f %f\n',o,Y(i),error(i));
train_points(i,1)=o;
 end
t_points=Y(1:train_size);
% train_error(j)=meansquarederr(train_points,t_points)/size(train_points,1);
H=-0.01+rand(size2,1)*0.02;

for i=i+1:size(B,1)
  X=[1 B(:,i)']';
 X(4,1)=H(1,1)';
 X(5,1)=H(2,1)';
 H=w1'*X;
 H=spicy(H);
 X2=[1 H']';
 o=w2'*X2;
 test_points(i,1)=o;
end
te_points=Y(train_size+1:end,1);
% test_error(j)=meansquarederr(test_points,te_points)/size(test_points,1);

fprintf('train error and test error are %f and %f \n', train_error(j),test_error(j));
end
plot(1:train_size,train_points,'r',1:train_size-100,t_points(1:train_size-100));