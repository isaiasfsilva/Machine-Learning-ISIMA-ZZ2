filename = './data/digit10_16x16_learn.txt' ;
learning_set = readData (filename) ;

% Définition de l'architecture du Perceptron Multicouches
net = [] ;
net.dim_exemples  = learning_set.dim_exemples ;
net.dim_cachees = 10 ;
net.dim_output = learning_set.nb_class ;

% Lancement de l'apprentissage
n_epochs      = 1000 ;
mse           = 0.01 ;
learning_rate = 0.05 ;
disp ('Apprentissage PMC :') ;
[net stat] = PMCLearning (net , learning_set , learning_rate , mse , n_epochs) ;

% Affichage des statistiques
figure(1) ;
[ax,h1,h2] = plotyy (1:net.n_epochs,[stat(:).mse] ,1:net.n_epochs,[stat(:).err_exemple],'plot') ;

set(get(ax(1),'Ylabel'),'String','Erreur quadratique moyenne') ;
set(get(ax(2),'Ylabel'),'String','Erreur de classification') ;
xlabel ('Nombre de présentation de l''ensemble d''apprentissage') ;
title (sprintf('Statistiques pour %s' , filename)) ;
grid on

stat(end).mat_conf

filename = './data/digit10_16x16_test.txt' ;
test_set = readData(filename) ;
% Affichage de l'ensemble d'apprentissage
figure(2) ;

% Génération de points dans l'espace d'entrée [0,1]x[0,1]


%number of test success!!
nb_ok=0;
% test du perceptron sur l'ensemble généré
for i = 1:test_set.nb_exemples
    o = PMCpropagation(net , test_set.matExemple(i,:)); % patt_in
    [v cl] = max(o);

    if(cl-1==test_set.label(i))	
    	nb_ok=nb_ok+1;
    end
    %plot_output (axes , test_set.matExemple(i,:)  , cl-1 , max(o)) ;
end

nb_ok
