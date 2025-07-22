%% CASUAL POINTS 

n = 5; % numero causale di punti da raggiungere
points = zeros(n,3); % inizializzo una tabella contenente tutti i punti in riga

points(1,:) = [0 0 1]; % starting point

for i = 2:n
    v = rand(1,3); % definisco una direzione randomica a partire da questo punto, tale che il punto successivo sia esattamente a 1 metro da quello precedente
    v = v/norm(v);
    points(i,:) = points(i-1,:) + v; % fisso il punto successivo 
end
