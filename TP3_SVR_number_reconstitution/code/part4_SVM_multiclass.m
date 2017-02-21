addpath('Toolbox/libsvm-mat-2.88-1/');
load Data/usps.mat


%%Train labels and patterns
%On peut utili


nb_class=10;

%prepare train
nbFolders = 2;
Cs = [1 10 100];
Ks = [1 0.1 0.01];
bestCs = zeros(nb_class,1);
bestKs = zeros(nb_class,1);
accuracy = zeros(3,nb_class);

nb_test=size(test_labels)

predict_label = zeros(nb_test(1),nb_class);


%Faire le train pour le numero et pour le complement
for i=1:nb_class
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
    [I,J] = ValidationCroisee(train_patterns_AB, train_labels_AB, nbFolders, Cs, Ks);


    bestCs(i) = Cs(I(1));
    bestKs(i) = Ks(J(1));
    
    
    param = ['-s 0 ', num2str(bestCs(i)), ' -g ', num2str(bestKs(i))];
    %teacher example
	%model = svmtrain(train_lab, train_vec, param);

	%learn model 1 vs all
	model = svmtrain(train_labels_AB, train_patterns_AB, param);
    
    %faire la prediction
    [predict_label(:,i), accuracy(:,i)] = svmpredict(test_labels, test_patterns', model);
end



[v cl]=max(predict_label');
cl = cl';
%plot errors
%compute all errors
errors = find((test_labels-cl)~=0);

%number of errors
nbErrors = length(errors);

%param to plot size
n = ceil(sqrt(nbErrors));


%print all images error
for i=1:nbErrors

    subplot(n,n,i);
 
    M = reshape(test_patterns(:,test_labels(errors(i))),16,16);

    imagesc(M');
end
