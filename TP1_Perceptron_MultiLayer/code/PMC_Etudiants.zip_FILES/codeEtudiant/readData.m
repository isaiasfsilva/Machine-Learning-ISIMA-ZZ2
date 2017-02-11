%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lecture d'un fichier de données 
%   
% En entrée :
%   nomFichier  : Nom du fichier contenant les exemples et les labels
% En sortie :
%   * data : Structure 
%       .filename  : Nom du fichier d'entrée
%       .dim_exemples : Dimension d'un exemple
%       .nb_class   : Nombre de classes 
%       .nb_exemples : Nombre d'exemples
%       .matExemple   : Matrice des exemples  [nb_exemples x dim_exemples]
%       .label     : Matrice des identifiants de classe (1 id / ligne)
%                       [nb_exemples x 1]
%       .output    : Matrice des classes de chaque exemple 
%                       classe 1 ==> (0.0 1.0 0.0 0.0) avec nb_class = 4
%                       [nb_exemples x nb_class]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function data = readData (filename)

% Structure de sortie
data = [] ;
data.filename = filename ;

fid = fopen (filename , 'rt') ;

% Lecture de la ligne de description des données
comment = fgetl (fid) ;
disp (comment) ;

% Lecture des paramètres des données
line = fgetl(fid) ;
data.dim_exemples = str2num(line) ;
line = fgetl(fid) ;
data.nb_class = str2num (line) ;

% Lecture des exemples
a = fscanf (fid , '%g' , [data.dim_exemples+1 inf]) ;

fclose (fid) ;

% Partition apprentissage /  test
data.nb_exemples = size(a,2) ;
data.matExemple = a(1:data.dim_exemples,:)' ;
data.label = a(data.dim_exemples+1,:)' ;

% Passage i_class = 1 --> (-1.0 1.0 -1.0 -1.0)
data.output = [] ;
for (k = 1:data.nb_exemples)
    data.output = [data.output ; 2*((1:1:data.nb_class)==(ones(1,data.nb_class)*(a(data.dim_exemples+1,k)+1)))-1 ] ;
end
