addpath('Toolbox/libsvm-mat-2.88-1/');
load Data/usps.mat

%%Example pour A
%%Train labels and patterns
itenA=4;

%Train pour A
train_labels_A = find(train_labels==itenA);
train_labels_A = train_patterns(:,train_labels_A(:));

s = size(train_labels_A);


train_patterns_A = linspace(1,256,256);

train_patterns_A=train_patterns_A';

test_pattern_img=train_patterns_A;

test_label_img = randn(256,1);

%paremeters cross
nbFolders = 10;

Cs = [1 10 100 1000];
Ks = [1 0.1 0.01];

%[I,J] = ValidationCroisee(train_patterns_A, train_labels_A, nbFolders, Cs, Ks);

bestCs = 0.1;%Cs(I(1));
bestKs = 0.1;%Ks(J(1));

param = ['-s 3 ', num2str(bestCs), ' -g ', num2str(bestKs), ' -e 0.002'];

model = svmtrain(train_labels_A, train_patterns_A, param);


[predict_label, accuracy, dec_values] = svmpredict(test_label_img, test_pattern_img, model);

predict_label=predict_label';

myimg = predict_label;
subplot(2,2,1);
M2=reshape(myimg,16,16);
title('Bottom Subplot')
imagesc(M2');
colormap('gray');

