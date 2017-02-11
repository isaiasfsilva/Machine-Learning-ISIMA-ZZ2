%generate random numbers


% Structure de sortie
learning_set = [] ;
learning_set.filename = '';
learning_set.dim_exemples   = 2 ;   % surface dans R^3
learning_set.nb_class     = 1 ;   
learning_set.nb_exemples   = 64 ;  % Nombre de points d'interpolation
learning_set.pmatExemple     = zeros (learning_set.nb_exemples , learning_set.dim_exemples) ;
learning_set.label       = zeros (learning_set.nb_exemples , 1) ;
learning_set.output      = zeros (learning_set.nb_exemples , 1) ;


% Discr�tisation de la fonction (x,y)-> cos(x)+sin(y)
nbExemplePerDim = sqrt(learning_set.nb_exemples) ;
x = linspace (0,2*pi,nbExemplePerDim) ;
y = linspace (0,2*pi,nbExemplePerDim) ;
pt = zeros (nbExemplePerDim , nbExemplePerDim) ;
i_exemple = 1 ;
for i = 1 : nbExemplePerDim
    for j = 1 : nbExemplePerDim
        learning_set.matExemple(i_exemple , 1) = x(i) ;
        learning_set.matExemple(i_exemple , 2) = y(j) ;
        pt(i,j) = (sin(x(i))+cos(y(j)))/2 ;
        learning_set.output (i_exemple , 1) = pt(i,j) ; 
        i_exemple = i_exemple + 1 ;
    end
end
figure () ;
figure,mesh (x , y , pt) ;


% D�finition de l'architecture du MLP
net = [] ;
net.dim_exemples  = learning_set.dim_exemples ;
net.dim_cachees = 12 ;
net.dim_output = learning_set.nb_class ;

% Apprentissage
n_epochs      = 20000 ;
mse           = 0.0001 ;
learning_rate = 0.01 ;
disp ('Apprentissage MLP :') ;
[net stat] = PMCLearning (net , learning_set , learning_rate , mse , n_epochs) ;

% Affichage des statistiques
figure(1) ;
[ax,h1,h2] = plotyy (1:net.n_epochs,[stat(:).mse] ,1:net.n_epochs,[stat(:).err_exemple],'plot') ;
set(get(ax(1),'Ylabel'),'String','Erreur quadratique moyenne') ;
set(get(ax(2),'Ylabel'),'String','Erreur de classification') ;
xlabel ('Nombre de run') ;
title (sprintf('Statistiques pour %s' , learning_set.filename)) ;
grid on

stat(end).mat_conf


test_set = [] ;
test_set.filename = '';
test_set.dim_exemples   = 2 ;   % surface dans R^3
test_set.nb_class     = 1 ;   
test_set.nb_exemples   = 121 ;  % Nombre de points d'interpolation
test_set.pmatExemple     = zeros (test_set.nb_exemples , test_set.dim_exemples) ;
test_set.label       = zeros (test_set.nb_exemples , 1) ;
test_set.output      = zeros (test_set.nb_exemples , 1) ;

nbExemplePerDim = sqrt(learning_set.nb_exemples) ;

x = linspace (-1,4*pi,nbExemplePerDim) ;
y = linspace (-1,4*pi,nbExemplePerDim) ;
pt = zeros (nbExemplePerDim , nbExemplePerDim) ;

for i = 1 : nbExemplePerDim
    for j = 1 : nbExemplePerDim      
        pt(i,j) = PMCpropagation(net , [x(i) y(j)]);;     
    end
end

figure,surf (x , y , pt) ;

