%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apprentissage d'un PMC par r�tropropropagation du gradient

% entr�e :
%   net     : PMC
%   data : ensemble d'apprentissage
%   learning_rate : Taux d'apprentisage initial
%   mse           : Erreur quadratique moyenne � attendre
%   nb_epochs      : Nombre maximum de pr�sentation du jeu d'apprentissage

% Sortie :
%   net  : PMC mis � jour par l'apprentissage
%           .IH : Poids synaptiques entre couche d'entr�e et couche cach�e
%           .HO : Poids synaptiques entre couche cach�e et couche de sortie
%   stat : statistiques d'apprentissage de chaque epoch
%       stat(epoch).mse         : Erreur quadratique moyenne
%       stat(epoch).err_exemple : Nombre d'exemples mal classifi�s
%       stat(epoch).mat_conf    : Matrice de confusion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [net , stat] = PMCLearning (net , data , learning_rate , mse , nb_epochs)

% V�rification de la taille des donn�es propos�es pour l'apprentissage
if data.dim_exemples ~= net.dim_exemples
    disp ('ERROR : Incoh�rence entre dimension des exemples et taille de la r�tine') ;
    return ;
end   
if data.nb_class ~= net.dim_output
    disp ('ERROR : Incoh�rence entre nombre de classes et nombre de neurones de la couche de sortie') ;
    return ;
end

net.learning_rate = learning_rate ;

% Param�tres internes de l'algorithme
ordre_Presentation = 'random' ;      

net.IH = rand([net.dim_exemples+1 net.dim_cachees]) ;
net.HO = rand([net.dim_cachees+1 net.dim_output]) ;

% Initialisation des statistiques d'apprentissage
stat = [] ;

% Pr�sentations de la base d'apprentissage
for epoch = 1:nb_epochs
   
    % Ordre de pr�sentation des patterns
    if (ordre_Presentation == 'random')
        tab = randperm(data.nb_exemples) ;
    else
        tab = 1:data.n_pattern ;
    end
    
    stat_epoch.mse          = 0.0 ;
    stat_epoch.err_exemple  = 0 ;
    stat_epoch.mat_conf     = zeros (net.dim_output,net.dim_output) ;
    
    %
    % Pr�sentation d'un exemple
    %
    for i = 1:data.nb_exemples
    
        % S�lection du pattern � pr�senter
        p = tab(i) ;
        
        % Pattern en entr�e & sortie souhait�e
        patt_in = data.matExemple(p,:) ;
        patt_out = data.output(p,:) ;
       
        % Propagation compl�te du pattern (entr�e --> cach�e --> sortie)
        hidden_output = PMCLayerPropagation (patt_in , net.IH) ;
        net_output = PMCLayerPropagation (hidden_output , net.HO) ;

        % Calcul de l'erreur constat�e en sortie
        error_output = patt_out - net_output ;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de l'ajustement des poids de HO (couche cach�e -> couche de sortie).
%Le delta_K du diaporama
        delta_HO = error_output.*(1.0-(net_output).^2.0);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de l'ajustement des poids de IH (couche d'entr�e -> couche cach�e)
        
        calcula_hidd=(1-hidden_output.^2);
        
        tmpp_HO=net.HO;
        
        tmpp_HO(net.dim_cachees+1,:)=[];
        
 % le delta_J du diaporama       
        delta_IH = calcula_hidd.*(delta_HO*tmpp_HO');%tmpp_HO.*delta_HO;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustement effectif des poids


%backpropagation!!! Slide 35 (NN.pdf)
        net.HO =net.HO + learning_rate*[hidden_output 1]'*delta_HO; 
        net.IH = net.IH +learning_rate*(delta_IH'*[patt_in 1])';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
      
        
        % Erreur quadratique moyenne
        stat_epoch.mse = stat_epoch.mse + sum(error_output.^2) ;
        
        % Erreur de classification
        [v , cl] = max(net_output) ;
        stat_epoch.err_exemple = stat_epoch.err_exemple + 1*(cl~=data.label(p)+1) ;
        
        % Matrice de confusion
        stat_epoch.mat_conf(data.label(p)+1,cl) = stat_epoch.mat_conf(data.label(p)+1,cl) + 1 ;


    end

    % Erreur quadratique moyenne
    stat_epoch.mse = stat_epoch.mse / data.nb_exemples ;

    stat = [stat ; stat_epoch] ;

    % Affichage 
    if (mod(epoch,200) == 0)
        disp(sprintf('Epoch : %d/%d (%d/%d) %f\n' , epoch , nb_epochs , stat_epoch.err_exemple , data.nb_exemples , stat_epoch.mse)) ;
    end
    
    % Crit�re d'arr�t
    if (stat_epoch.mse <= mse)
        break ;
    end
    
end
    
net.n_epochs = epoch ;
net.mse      = stat_epoch.mse ;
