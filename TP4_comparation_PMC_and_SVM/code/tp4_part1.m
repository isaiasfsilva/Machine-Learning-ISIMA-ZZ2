addpath('../Toolbox/libsvm-mat-2.88-1/');
addpath('../Toolbox/netlab3.3/');


%Parameters PMC
alpha=0.18;
nhidden=40;
%Parameters BASE_1
train_size = 30;
test_size = 45;
Desloc=3;
variance=3

%Database pour le train
[train_patt train_lab test_patt test_lab] = generate_base_1(train_size, test_size, Desloc, variance);


%Train
net = mlp(2, nhidden, 1, 'logistic', alpha);

options = zeros(1,18);
options(1) = 1;              
options(14) = 100; %% tamanho do loop

[net] = netopt(net, options, train_patt, train_lab, 'quasinew');

%Predict
ypred = mlpfwd(net, test_patt);
ypred(find(ypred>0.5)) = 1;
ypred(find(ypred<=0.5)) = -1;


erros = ypred-test_lab;
nb_erros = sum(abs(erros))/2;
val_croise = nb_erros/test_size;



% affichage de la base

