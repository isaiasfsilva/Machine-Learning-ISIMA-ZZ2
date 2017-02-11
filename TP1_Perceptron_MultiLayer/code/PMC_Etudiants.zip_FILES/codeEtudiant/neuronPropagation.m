%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation d'un exemple dans le perceptron au travers d'un neurone.
% En entrée :
%   neuron :  définition du neurone
%   exemple : exemple présenté 

% En sortie :
%   output  : Valeur prédire par le perceptron

% Attention : à l'entrée doit être ajoutée une entrée supplémentaire mise à 1 
% correspondant au biais  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = neuron_propagation (neuron , exemple)

%--------------------------------------
    %Pour TangH
        %output=tanh(dot(neuron.weights',[exemple 1]));
	%pour Sigmoid
		%output = 2.0/(1.0+exp(-1*(dot(neuron.weights',[exemple 1])))) -1.0;	
	%Pour Soul
		output = sign(dot(neuron.weights',[exemple 1]));
%--------------------------------------
end
