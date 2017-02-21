% Validation croisée pour trouver les meilleurs paramètres du SVM (C et largeur
% de bande)
function [I,J] = ValidationCroisee(trainvec,trainlab,nbFolders,Cs,Ks)

if nargin==5
    precision = zeros(length(Cs),length(Ks));
else
    error('Pb arguments : 5 arguments attendus');
end

% découpage de la base
rn = randperm(length(trainlab));
S = ceil(length(trainlab)/nbFolders);
for N = 1:nbFolders
    selected = rn((S*(N-1))+1:min(end,N*S));
    notselected = setdiff(rn,selected);
    TV = trainvec(notselected,:);
    TL = trainlab(notselected);
    TTV = trainvec(selected,:);
    TTL = trainlab(selected);
    for i=1:length(Cs)
        for j=1:length(Ks)
            param = ['-s 0 -c ', num2str(Cs(i)), ' -g ', num2str(Ks(j))];
            model = svmtrain(TL,TV, param);
            [predict_label, accuracy, dec_values] = svmpredict(TTL,TTV, model);
            precision(i,j) = precision(i,j)+accuracy(1);
        end
    end
end
precision = precision./nbFolders;
A =  find(precision == max(max(precision)));
[I,J] = ind2sub(size(precision),A);
