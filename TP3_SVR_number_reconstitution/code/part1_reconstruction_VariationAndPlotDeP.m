addpath('Toolbox/libsvm-mat-2.88-1/');
load Data/usps.mat

%%Example pour A
%%Train labels and patterns
itenA=4;

%Train pour A
train_labels_A = find(train_labels==itenA);
train_patterns_A = train_patterns(:,train_labels_A(:));
train_labels_A = train_labels(train_labels_A);
train_patterns_A=train_patterns_A';


%%Validation pour A



image_base=train_patterns_A(1,:);

p = (50*(rand())+26);      %between 10% et 90% of my image size (256px)

p=int32(256-p);
pg=[];
ag=[];
sg=[];
tp=randperm(256);
for i=230:-25:26
	p=i;
	pg=[pg (1.0-i/256.0)];	
	%randomize le vector
	train_pattern=tp;

	%img randomize
	image_base_aux=image_base(train_pattern);

	%prendre les labels pour train
	train_label_img=image_base_aux(1:p);

	%prendre les labels pour test
	test_label_img=image_base_aux(p+1:256);

	%cree le patter de train x(i,j)
	train_pattern_img=ones(p,2);
	for i=1:p
	        train_pattern_img(i,:)=[fix(train_pattern(i)/16) mod(train_pattern(i),16)];     
	end

	%cree le patter de test
	test_pattern_img=ones(256-p,2);
	b=p+1;
	for i=b:256
	        test_pattern_img(i-p,:)=[fix(train_pattern(i-p)/16) mod(train_pattern(i-p),16)];     
	end

	%adaptation 
	test_label_img=test_label_img';
	train_label_img=train_label_img';


	%paremeters cross
	nbFolders = 2;

	Cs = [1 10 100 1000];
	Ks = [1 0.1 0.01];

	[I,J] = ValidationCroisee(train_pattern_img, train_label_img, nbFolders, Cs, Ks);

	bestCs = Cs(I(1));
	bestKs = Ks(J(1));

	param = ['-s 3 ', num2str(bestCs), ' -g ', num2str(bestKs), ' -e 0.002'];

	model = svmtrain(train_label_img, train_pattern_img, param);

	[predict_label, accuracy, dec_values] = svmpredict(test_label_img, test_pattern_img, model);
	ag=[ag max(accuracy)];

	a=predict_label-test_label_img;
	
	sg = [sg sum(abs(a))];
end

plot(pg,sg);
hold on;
plot(pg,ag*100,'r');



