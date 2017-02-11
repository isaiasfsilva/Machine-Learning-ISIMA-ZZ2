%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation d'un exemple au travers d'un perceptron multicouches.
% Entr�e :
%   net     : PMC
%   exemple : exemple en entr�e 

% sortie :
%   output  : sortie du r�seau
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = PMCPropagation (net , exemple)

% Propagation de l'exemple au travers de la couche cach�e
sortie_cachee = PMCLayerPropagation (exemple , net.IH) ;

% Propagation du r�sultat de la couche cach�e au travers de la couche de
% sortie
output = PMCLayerPropagation (sortie_cachee , net.HO) ;
    
end
