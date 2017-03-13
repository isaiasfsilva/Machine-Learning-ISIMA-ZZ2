function [train_patterns_AB train_labels_AB test_patterns_AB test_labels_AB] = generate_base_usps(itenA, itenB, train_patterns,train_labels,test_patterns, test_labels)

%Train pour 0
train_labels_A = find(train_labels==itenA);
train_patterns_A = train_patterns(:,train_labels_A(:));
%Train pour 1
train_labels_B = find(train_labels==itenB);
train_patterns_B = train_patterns(:,train_labels_B(:));
%concat trains

tempA = train_labels(train_labels_A);
tempB = train_labels(train_labels_B);
tempA(:)=1;
tempB(:)=-1;

train_labels_AB = vertcat(tempA,tempB);
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
LtempA = test_labels(test_labels_A);
LtempB = test_labels(test_labels_B);
LtempA(:)=1;
LtempB(:)=-1;



test_labels_AB = vertcat(LtempA,LtempB);
test_patterns_AB = horzcat(test_patterns_A,test_patterns_B);
test_patterns_AB=test_patterns_AB';


end
