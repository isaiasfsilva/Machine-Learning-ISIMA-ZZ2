%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithme d'apprentissage du perceptron.
% En entrée :
%   neuron  : Neurone dont l'apprentissage est à réaliser
%   dataset : Ensemble d'apprentissage
%   learning_rate : Taux d'apprentisage initial
%   mse           : Erreur quadratique moyenne à attendre
%   n_epochs      : Nombre maximum de présentation du jeu d'apprentissage
%
% En sortie :
%   neuron : Neurone mis à jour par l'apprentissage (weights : Poids
%   synaptiques du neurone)
%                  
%   stat : Statistiques d'apprentissage de chaque présentation de
%   l'ensemble d'apprentissage
%       .mse         : Erreur quadratique moyenne
%       .err_exemple : Nombre d'exemples mal classifiés
%       .mat_conf    : Matrice de confusion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [neuron , stat] = neuron_learning (neuron , dataset , learning_rate , mse , n_epochs)

% Problème de classification à deux classes
nb_class = 2 ;

% Vérification de la taille des données proposées pour l'apprentissage
if dataset.dim_exemples ~= neuron.dim_exemples
    disp ('ERROR : Problème de dimensions en entrée') ;
    return ;
end   
if dataset.nb_class ~= nb_class
    disp ('ERROR : Problème de dimensions en sortie') ;
    return ;
end

neuron.learning_rate = learning_rate ;

% Ordre de présentation des exemples
ordre_Presentation = 'random' ;      

% Initialisation aléatoire des poids synaptiques du réseau
neuron.weights = rand([neuron.dim_exemples+1 1]) ;

% Initialisation des statistiques d'apprentissage
stat = [] ;

% Présentation de l'ensemble d'apprentissage
for epoch = 1:n_epochs
   
    if (ordre_Presentation == 'random')
        tab = randperm(dataset.nb_exemples) ;
    else
        tab = 1:dataset.n_pattern ;
    end
    
    % Initialisation des statistiques pour la présentation
    stat_epoch.mse          = 0.0 ;
    stat_epoch.err_exemple  = 0 ;
    stat_epoch.mat_conf     = zeros (nb_class,nb_class) ;
    
    
    for i = 1:dataset.nb_exemples
    
        % Sélection de l'exemple à présenter
        p = tab(i); 
        
        % exemple à présenter en entrée (ajout du biais)
        patt_in  = [dataset.matExemple(p,:) 1]; 
        
        % Sortie théorique (-1/1)
        ex_out = dataset.label(p,:)*2-1; 
       
        
        % Propagation de l'exemple
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Apprentissage avec tanh ou sigmoide ou seuil 

%--------------------------------------
%Avec Tanh
        net_output = tanh(dot(neuron.weights',patt_in));

%--------------------------------------
%Avec sigmoid
        %net_output = 2.0/(1.0+exp(-1*(dot(neuron.weights',patt_in)))) -1.0;	

%--------------------------------------
%Avec hands
        %net_output = sign(dot(neuron.weights',patt_in));
        
%--------------------------------------
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        
        % Calcul de l'erreur constatée en sortie
        error_output = ex_out - net_output ;
               
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Ajustement effectif des poids

%--------------------------------------
        neuron.weights = neuron.weights + learning_rate*(error_output.*patt_in)';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------       
        % Mise à jour des statistiques
        
        % Erreur quadratique moyenne
        stat_epoch.mse = stat_epoch.mse + sum(error_output.^2) ;
        
        % Erreur de classification
        cl = (net_output >= 0.0)*1 ;
        stat_epoch.err_exemple = stat_epoch.err_exemple + 1*(cl~=dataset.label(p)) ;
        
        % Matrice de confusion
        stat_epoch.mat_conf(dataset.label(p)+1,cl+1) = stat_epoch.mat_conf(dataset.label(p)+1,cl+1) + 1 ;

    end


    % Erreur quadratique moyenne
    stat_epoch.mse = stat_epoch.mse / dataset.nb_exemples ;

    stat = [stat ; stat_epoch] ;

    % Affichage
    if (mod(epoch,10) == 0)
        disp(sprintf('Epoch : %d/%d (%d/%d) %f\n' , epoch , n_epochs , stat_epoch.err_exemple , dataset.nb_exemples , stat_epoch.mse)) ;
        
    end
    
    % Arrêt de la présentation de la base d'apprentissage
    if (stat_epoch.mse <= mse)
        break ;
    end
    
end
    
neuron.n_epochs = epoch ;
neuron.mse      = stat_epoch.mse ;
