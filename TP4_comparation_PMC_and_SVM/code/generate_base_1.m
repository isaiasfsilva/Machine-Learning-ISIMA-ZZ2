function [train_pattern_b1 train_labels_b1 test_pattern_b1 test_labels_b1] = generate_base_1(train_size, test_size, Desloc, variance)

%Database pour le train

%Primeira parte
train_pattern_1 = [ones(train_size,1) zeros(train_size,1)];
train_pattern_1 = train_pattern_1 + randn(train_size,2);

%Segunda parte
train_pattern_2 = -Desloc*[ones(train_size,1) ones(train_size,1)];
train_pattern_2=train_pattern_2 + randn(train_size,2)*variance;  %desloca a distribuicao gaussienne

%concat les 2 ensembles des points.
train_pattern_b1 = [train_pattern_1 ; train_pattern_2];

train_labels_1 = ones(train_size,1);
train_labels_2 = -1*ones(train_size,1);
train_labels_b1 = [train_labels_1 ; train_labels_2];



% base de test 1
test_pattern_1 = [ones(test_size,1) zeros(test_size,1)];
test_pattern_1=test_pattern_1 + randn(test_size,2);

test_pattern_2 = -Desloc*[ones(test_size,1) ones(test_size,1)];
test_pattern_2=test_pattern_2 + randn(test_size,2)*variance;
test_pattern_b1 = [test_pattern_1 ; test_pattern_2];

test_labels_1 = ones(test_size,1);
test_labels_2 = -1*ones(test_size,1);
test_labels_b1 = [test_labels_1 ; test_labels_2];

%plot
%plot(train_pattern_1(:,1), train_pattern_1(:,2), 'bo',...
%train_pattern_2(:,1),train_pattern_2(:,2),'ro',...
%test_pattern_1(:,1), test_pattern_1(:,2),'c+',...
%test_pattern_2(:,1), test_pattern_2(:,2),'m+')

end
