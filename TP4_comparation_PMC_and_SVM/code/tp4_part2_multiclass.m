addpath('../Toolbox/libsvm-mat-2.88-1/');
addpath('../Toolbox/netlab3.3/');
load ../Data/usps.mat



%Parameters PMC
alpha=0.2;
nhidden=2;

%Parameters BASE_1
itenA=2;
itenB=8;


%%Train labels and patterns
%On peut utili


nb_class=1;

%prepare train
nbFolders = 2;
Cs = [1 10 100];
Ks = [1 0.1 0.01];
bestCs = zeros(nb_class,1);
bestKs = zeros(nb_class,1);
accuracy = zeros(3,nb_class);

nb_test=size(test_labels);

predict_label = zeros(nb_test(1),nb_class);


%Faire le train pour le numero et pour le complement
for i=1:10
    %Train pour i
	train_labels_A = find(train_labels==i);
	train_patterns_A = train_patterns(:,train_labels_A(:));
	%Train pour non i
	train_labels_B = find(train_labels~=i);
	train_patterns_B = train_patterns(:,train_labels_B(:));
	%concat trains

	%set == i comme 1 et itens non i comme -1
	train_labels_AB = vertcat(ones(size(train_labels_A)),-1*ones(size(train_labels_B)));
	
	train_patterns_AB = horzcat(train_patterns_A,train_patterns_B);
	train_patterns_AB=train_patterns_AB';

        fprintf('Training pour i=%d\n',i);
        
        net = mlp(256, nhidden, 1, 'logistic', alpha);

        options = zeros(1,18);
        options(1) = 1;              
        options(14) = 10;

        [net] = netopt(net, options, train_patterns_AB,  train_labels_AB, 'quasinew');

        %Predict
        predict_label(:,i) = mlpfwd(net, test_patterns');


end



[v cl]=max(predict_label');
cl = cl';
%plot errors
%compute all errors
errors = find((test_labels-cl)~=0);

%number of errors
nbErrors = length(errors);



