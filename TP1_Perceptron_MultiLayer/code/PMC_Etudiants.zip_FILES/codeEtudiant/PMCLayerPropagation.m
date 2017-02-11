%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation de l'entr�e au travers de la couche d�finie par les poids
% 'weights'. La fonction d'activation utilis�e est la fonction
% 'tanh'.
% 
%   Entr�e 
%   input   : Vecteur ligne contenant les donn�es � propager 
%               (un exemple ou les sorties d'une couche)          
%   weights : Matrice contenant les poids synaptiques correspondant � la
%               couche dans laquelle doit s'op�rer la propagation
%               
% Sortie
%   * output : Vecteur ligne de sortie de la couche apr�s propagation
%

% Au vecteur d'entr�e doit �tre ajout�e une entr�e suppl�mentaire mise � 1 
% correspondant au neurone de biais  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = PMCLayerPropagation (input , weights)

%%Il y a le biais!!!!!
        output=tanh([input 1]*weights);

end
