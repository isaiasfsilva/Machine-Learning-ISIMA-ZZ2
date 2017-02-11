% Jeu de donnees au format suivant
% Type du jeu de donn�es (lin�airement s�parable sym�trique ou
% dissym�trque, non lin�airement s�parable)
% Dimension d'un exemple (dim_input)
% Nombre d'exemples (n_class) 
% exemples  + labels

function NeuronMain(nomFichier)


% Chargement du jeu de donn�es
learning_set = readData (nomFichier) ;

% D�finition du perceptron
neuron = [] ;
neuron.dim_exemples  = learning_set.dim_exemples ;

% Lancement de l'apprentissage
n_epochs      = 200 ; % nombre de pr�sentation de l'ensemble d'apprentissage
mse           = 0.0001 ; % test d'arr�t sur l'erreur quadratique
learning_rate = 0.1 ; % taux d'apprentissage initial
disp (' Apprentissage Perceptron lin�aire :') ;
[neuron stat] = ApprentissagePerceptron (neuron , learning_set , learning_rate , mse , n_epochs) ;

% Affichage des statistiques
figure(1) ;
[ax,h1,h2]=plotyy(1:neuron.n_epochs,[stat(:).mse] ,1:neuron.n_epochs,[stat(:).err_exemple],'plot') ;
set(get(ax(1),'Ylabel'),'String','Erreur quadratique moyenne') ;
set(get(ax(2),'Ylabel'),'String','Erreur de classification') ;
xlabel ('Nombre de pr�sentation de l''ensemble d''apprentissage') ;
title (sprintf('Statistiques pour %s' , nomFichier)) ;
grid on

stat(end).mat_conf

% Affichage de l'ensemble d'apprentissage
figure(2) ;
axis ([0 1 0 1]) ;
axes = [1 2] ;
plot_exemple (axes , learning_set.matExemple , learning_set.label) ;

% G�n�ration de points dans le carr� unit� 
nb_points = 70 ;
pointsTest = rand(nb_points,learning_set.dim_exemples);

% test du perceptron sur l'ensemble g�n�r�
for i = 1:nb_points
    o = neuronPropagation(neuron , pointsTest(i,:)) ;
    plot_output (axes , pointsTest(i,:) , (o >= 0.0)*1 , o) ;
end

% Affichage de l'hyperplan s�parateur
plot_hyperplane (neuron.weights , [0 1] , [0 1]) ;





