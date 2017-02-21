addpath('Toolbox/libsvm-mat-2.88-1/');
load Data/usps.mat

%%Example pour 0 et 1
%%Train labels and patterns
itenA=2;
itenB=8;
%Train pour 0
train_labels_A = find(train_labels==itenA);
train_patterns_A = train_patterns(:,train_labels_A(:));
%Train pour 1
train_labels_B = find(train_labels==itenB);
train_patterns_B = train_patterns(:,train_labels_B(:));
%concat trains
train_labels_AB = vertcat(train_labels(train_labels_A),train_labels(train_labels_B));
train_patterns_AB = horzcat(train_patterns_A,train_patterns_B);
train_patterns_AB=train_patterns_AB';


%%Validation pour 0 et 1
%Test pour 0
test_labels_A = find(test_labels==itenA);
test_patterns_A = test_patterns(:,test_labels_A(:));
%Train pour 1
test_labels_B = find(test_labels==itenB);
test_patterns_B = test_patterns(:,test_labels_B(:));
%concat tests
test_labels_AB = vertcat(test_labels(test_labels_A),test_labels(test_labels_B));
test_patterns_AB = horzcat(test_patterns_A,test_patterns_B);
test_patterns_AB=test_patterns_AB';


%prepare train
nbFolders = 10;
Cs = [1 10 100];
Ks = [1 0.1 0.01];

%Faire la validationcroisseee
[I,J] = ValidationCroisee(train_patterns_AB, train_labels_AB, nbFolders, Cs, Ks);

%prendre les meiux valeurs
bestCs = Cs(I(1));
bestKs = Ks(J(1));

%modèle les param pour le svm
param = ['-s 0 ', num2str(bestCs), ' -g ', num2str(bestKs)];


%teacher example
%model = svmtrain(train_lab, train_vec, param);


%Train!
model = svmtrain(train_labels_AB, train_patterns_AB, param);

%validate!!!
[predict_label, accuracy, dec_values] = svmpredict(test_labels_AB, test_patterns_AB, model);




%plot errors
%compute all errors
errors = find((test_labels_AB-predict_label)~=0);
%number of errors
nbErrors = length(errors);

%param to plot size
n = ceil(sqrt(nbErrors))

D = [test_labels_A;test_labels_B];

%print all images error
for i=1:nbErrors

    subplot(n,n,i);
 
    M = reshape(test_patterns(:,D(errors(i))),16,16);

    imagesc(M');
end
