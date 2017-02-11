%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation de l'entrée au travers de la couche définie par les poids
% 'weights'. La fonction d'activation utilisée est la fonction
% 'tanh'.
% 
%   Entrée 
%   input   : Vecteur ligne contenant les données à propager 
%               (un exemple ou les sorties d'une couche)          
%   weights : Matrice contenant les poids synaptiques correspondant à la
%               couche dans laquelle doit s'opérer la propagation
%               
% Sortie
%   * output : Vecteur ligne de sortie de la couche après propagation
%

% Au vecteur d'entrée doit être ajoutée une entrée supplémentaire mise à 1 
% correspondant au neurone de biais  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = PMCLayerPropagation (input , weights)

%%Il y a le biais!!!!!
        output=tanh([input 1]*weights);

end
