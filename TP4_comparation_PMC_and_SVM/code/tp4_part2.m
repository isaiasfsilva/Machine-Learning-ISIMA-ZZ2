addpath('../Toolbox/libsvm-mat-2.88-1/');
addpath('../Toolbox/netlab3.3/');
load ../Data/usps.mat

%Parameters PMC
alpha=0.04;
nhidden=40;

%Parameters BASE_1
itenA=2;
itenB=8;

%Database pour le train
[train_patt train_lab test_patt test_lab] = generate_base_usps(itenA, itenB, train_patterns,train_labels,test_patterns, test_labels);


%Train
net = mlp(256, nhidden, 1, 'logistic', alpha);

options = zeros(1,18);
options(1) = 1;              
options(14) = 10;

[net] = netopt(net, options, train_patt, train_lab, 'quasinew');

%Predict
ypred = mlpfwd(net, test_patt);
ypred(find(ypred>0.5)) = 1;
ypred(find(ypred<=0.5)) = -1;

test_size=size(ypred);

erros = ypred-test_lab;
nb_erros = sum(abs(erros))/2;
val_croise = nb_erros/test_size(1);



% affichage de la base

