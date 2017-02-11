%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation d'un exemple au travers d'un perceptron multicouches.
% Entrée :
%   net     : PMC
%   exemple : exemple en entrée 

% sortie :
%   output  : sortie du réseau
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = PMCPropagation (net , exemple)

% Propagation de l'exemple au travers de la couche cachée
sortie_cachee = PMCLayerPropagation (exemple , net.IH) ;

% Propagation du résultat de la couche cachée au travers de la couche de
% sortie
output = PMCLayerPropagation (sortie_cachee , net.HO) ;
    
end
