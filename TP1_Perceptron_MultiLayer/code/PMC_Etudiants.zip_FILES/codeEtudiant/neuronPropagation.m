%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propagation d'un exemple dans le perceptron au travers d'un neurone.
% En entr�e :
%   neuron :  d�finition du neurone
%   exemple : exemple pr�sent� 

% En sortie :
%   output  : Valeur pr�dire par le perceptron

% Attention : � l'entr�e doit �tre ajout�e une entr�e suppl�mentaire mise � 1 
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
