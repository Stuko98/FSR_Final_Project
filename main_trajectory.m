clear all
close all
clc

%% POINTS CHOICE

% scegli tra traiettoria definita o casuale: 
% "defined" 
% "casual"
% AI FINI DELLA SIMULAZIONE DEL PROGETTO, USARE SOLO QUELLA DEFINITA!

flag1 = "defined";

if flag1 == "defined"
    run('defined_points.m')
else
    run('casual_points.m')
end

%% ESTIMATOR
run('filter_coeff.m')


%% TIME 
tf = 5;       % tempo per inseguire il singolo segmento. Scelta libera. OCCHIO: il nostro controllo non è fatto per effettuare voli acrobatici, quindi non può essere troppo basso. Ad esempio se tf == 1, il controllo esplode
t = 0:0.01:tf; % asse temporale


%% TIME LAW
% Vedi cap.4 di "Robotics" di Siciliano

% % coefficienti per la time law (polinomio di 3° grado) che rispettino le
% % condizioni: 
% % s(0) = 0,    s_dot(0) = 0,
% % s(tf) = 1,   s_dot(tf) = 0.
% % Calcolati a mano per facilità
%
% a0 = 0;
% a1 = 0;
% a2 = 3/tf^2;
% a3 = -2/tf^3;
% 
% % time law s(t) polinomiale cubica ( = polinomio  di 3° grado) 
% s = a3*t.^3 + a2*t.^2 + a1*t + a0;
% s_dot = 3*a3*t.^2 + 2*a2*t + a1;
% s_ddot = 6*a3*t + 2*a2;



% coefficienti per la time law (polinomio di 5° grado) che rispettino le
% condizioni: 
% s(0) = 0 ,  s_dot(0) = 0 ,   s_ddot(0) = 0, 
% s(tf) = 1,  s_dot(tf) = 0,   s_ddot(tf) = 0.

% Calcolati tramite sistema di equazioni (impegnativi a mano)
b = [0 0 0 1 0 0]'; % termini noti

A = [0 0 0 0 0 1; % sistema di equazioni
     0 0 0 0 1 0;
     0 0 0 1 0 0;
     tf^5 tf^4 tf^3 tf^2 tf 1;
     5*tf^4 4*tf^3 3*tf^2 2*tf 1 0;
     20*tf^3 12*tf^2 6*tf 2 0 0];

a_i = inv(A)*b; % incognite = coefficienti

a0 = a_i(6,1);
a1 = a_i(5,1);
a2 = a_i(4,1);
a3 = a_i(3,1);
a4 = a_i(2,1);
a5 = a_i(1,1);

s = a5*t.^5 + a4*t.^4 + a3*t.^3 + a2*t.^2 + a1*t + a0;
s_dot = 5*a5*t.^4 + 4*a4*t.^3 + 3*a3*t.^2 + 2*a2*t + a1;
s_ddot = 20*a5*t.^3 + 12*a4*t.^2 + 6*a3*t + 2*a2;

% equivalent 
% s_dot = gradient(s,t);
% s_ddot = gradient(s_dot,t);

% plots: time law and its derivatives wrt time
% figure;
% 
% tiledlayout(3,1);
% 
% % time law
% nexttile
% plot(t, s, 'LineWidth', 2)
% xlabel('$\mathbf{t} $ [s]')
% ylabel('$\mathbf{s(t)}$ [m]')
% grid on
% box on
% 
% % time law first derivative
% nexttile
% plot(t, s_dot, 'LineWidth', 2)
% xlabel('$\mathbf{t}$ [s]')
% ylabel('$\mathbf{\dot{s}(t)}$ [m/s]')
% grid on
% box on
% 
% % time law second derivative
% nexttile
% plot(t, s_ddot, 'LineWidth', 2)
% xlabel('$\mathbf{t}$ [s]')
% ylabel('$\mathbf{\ddot{s}(t)}$ [m/$s^2$]')
% grid on
% box on
% 
% sgtitle('Time law & derivatives of the 2 segments')


%% SEGMENTS

% inizializzo una matrice che contenga, per ogni segmento, tutte e tre le componenti xyz.
% Ciò è stato fatto anche per velocità e accelerazione.

segments = zeros(3*(n-1),length(t));
segments_dot = zeros(3*(n-1),length(t));
segments_ddot = zeros(3*(n-1),length(t));

% compongo i posizione, velocità e accelerazione per i singoli segmenti
k = 1; % coefficiente k ci serve per passare dall'assegnare una componente ad assegnarne un'altra per lo stesso segmento all'interno delle matrici 
for i = 1:n-1 % n punti -> n-1 segmenti
    segments(k:k+2,:) = points(i,:)' + s./norm(points(i+1,:)'-points(i,:)').*(points(i+1,:)'-points(i,:)'); 
    segments_dot(k:k+2,:) = s_dot./norm(points(i+1,:)'-points(i,:)').*(points(i+1,:)'-points(i,:)'); 
    segments_ddot(k:k+2,:) = s_ddot./norm(points(i+1,:)'-points(i,:)').*(points(i+1,:)'-points(i,:)'); 
    
    % gestisco hovering nella parte finale della traiettoria (la presenza di s(t) mi dà problemi perché mi costringe per forza ad andare avanti di 1 metro dal punto in cui mi trovo)
    if points(i,:) == points(i+1,:)  % se voglio rimanere allo stesso punto di prima, e quindi rimanere in hovering...
        segments(k:k+2,:) = points(i,:)'+zeros(3,length(t)); % rimango al punto di prima
        segments_dot(k:k+2,:) = zeros(3,length(t)); % non mi muovo -> velocità nulla 
        segments_ddot(k:k+2,:) = zeros(3,length(t)); % non mi muovo -> accelerazione nulla
    end
    
    k = k + 3; % vado avanti di 3 perché 3 sono le componenti di ogni segments, di ogni segments_dot e di ogni segments_ddot
end

% equivalent
% p_dot = gradient(p,s);
% p_ddot = gradient(p_dot,s);

% % segments 3D plots 
% for i= 1:3:size(segments,1)
%     figure
%     plot3(segments(i,:),segments(i+1,:),segments(i+2,:), 'LineWidth', 2)
%     grid on
%     box on
% end
% 
% %'time - position' plots for segments 
% for i= 1:3:size(segments,1)
%     figure
%     tiledlayout(3,1)
% 
%     nexttile
%     plot(t,segments(i,:));
%     grid on
%     box on
% 
%     nexttile
%     plot(t,segments(i+1,:));
%     grid on
%     box on
% 
%     nexttile
%     plot(t,segments(i+2,:));
%     grid on
%     box on
% end
% 
% %'time - velocity' plots for segments 
% for i= 1:3:size(segments_dot,1)
%     figure
%     tiledlayout(3,1)
% 
%     nexttile
%     plot(t,segments_dot(i,:));
%     grid on
%     box on
% 
%     nexttile
%     plot(t,segments_dot(i+1,:));
%     grid on
%     box on
% 
%     nexttile
%     plot(t,segments_dot(i+2,:));
%     grid on
%     box on
% end


%% TRAJECTORY

% costruisco la time law per l'intera traiettoria
t_tot = []; % devo definire preliminarmente un tempo totale per eseguire l'intera traiettoria
s_tot = []; % stessa cosa, ma per la time law
s_dot_tot = [];
s_ddot_tot = [];

t_temp = zeros(n-1,length(t)); % inizializzo delle variabili temporali, infatti sia i tempi che la time law (occhio, non le derivate della time law!) vanno sommati
s_temp = zeros(n-1,length(t));

for i = 1:n-1
    t_temp(i,:) = t + tf*(i-1);
    s_temp(i,:) = s + 1*(i-1);
    t_tot = [t_tot t_temp(i,:)];
    s_tot = [s_tot s_temp(i,:)];
    s_dot_tot = [s_dot_tot s_dot]; % invece derivata prima e seconda della time law vanno solo ripetute, non sommate!
    s_ddot_tot = [s_ddot_tot s_ddot];
end

% time law and derivatives plots
f = figure;
t = tiledlayout(3,1);  % Salvi il layout in una variabile

nexttile
plot(t_tot,s_tot, 'LineWidth', 2)
ylabel('$s(t)$ [m]','Interpreter','latex','FontSize',14)
grid on
box on
ylim padded

nexttile
plot(t_tot,s_dot_tot, 'LineWidth', 2)
ylabel('$\dot{s}(t)$ [m]','Interpreter','latex','FontSize',14)
grid on
box on
ylim padded

nexttile
plot(t_tot,s_ddot_tot, 'LineWidth', 2)
ylabel('$\ddot{s}(t)$ [m]','Interpreter','latex','FontSize',14)
grid on
box on
ylim padded

xlabel(t, '$t$ [s]', 'Interpreter', 'latex','Fontsize', 14)
%sgtitle('Time law and time derivatives', 'Interpreter', 'latex')

%exportgraphics(f, 'time_law.pdf');



% trajectory: componiamo i segments + le derivate
p = [];
p_dot = [];
p_ddot = [];
for i = 1:3:size(segments,1)
    p = [p segments(i:i+2,:)];
    p_dot = [p_dot segments_dot(i:i+2,:)];
    p_ddot = [p_ddot segments_ddot(i:i+2,:)];
    

end

% % trajectory plot
% figure
% plot3(p(1,:),p(2,:),p(3,:), 'LineWidth', 2)
% grid on 
% box on

% % p components plot
% figure
% tiledlayout(3,1)
% nexttile
% plot(t_tot,p(1,:));
% nexttile
% plot(t_tot,p(2,:));
% nexttile
% plot(t_tot,p(3,:));
% title('Segment 1 and 2')

% % p_dot components plot
% figure
% tiledlayout(3,1)
% nexttile
% plot(t_tot,p_dot(1,:));
% nexttile
% plot(t_tot,p_dot(2,:));
% nexttile
% plot(t_tot,p_dot(3,:));
% title('Segment 1 and 2')



%% SCENARIO + TRAJECTORY PLOT
run('scenario.mlx');


%% CONTROLLER CHOICE
% scegli tra hierarchical, geometric o passivity-based controllers,
% comprese le rispettive varianti: 

% hierarchical controller    ->                                                     "hierarchical"
% geometric controller       ->                                                     "geometric"
% passivity-based controller ->                                                     "passivity"

% hierarchical controller    + momentum-based estimator + collision detection ->    "hier_est"
% geometric controller       + momentum-based estimator + collision detection ->    "geom_est"
% passivity-based controller + momentum-based estimator + collision detection ->    "pass_est"

% hierarchical contr.    + m-b est. + ground and ceiling effects + col. detect. ->  "hier_est_gece"
% geometric contr.       + m-b est. + ground and ceiling effects + col. detect. ->  "geom_est_gece"
% passivity-based contr. + m-b est. + ground and ceiling effects + col. detect. ->  "pass_est_gece".

flag2 = "hierarchical";

if flag2 == "hierarchical"
    out = sim("hierarchical_controller.slx");
    run("plots.m");

elseif flag2 == "geometric"
    out = sim("geometric_controller.slx");
    run("plots.m");

elseif flag2 == "passivity"
    out = sim("passivity_based_controller.slx");
    run("plots.m");

elseif flag2 == "hier_est"
    out = sim("hierarchical_controller_with_estimator.slx");
    run("plots_est.m");

elseif flag2 == "geom_est"
    out = sim("geometric_controller_with_estimator.slx");
    run("plots_est.m");

elseif flag2 == "pass_est"
    out = sim("passivity_based_controller_with_estimator.slx");
    run("plots_est.m");

elseif flag2 == "hier_est_gece"
    out = sim("hierarchical_controller_with_estimator_gece.slx");
    run("plots_est_gece.m");

elseif flag2 == "geom_est_gece"
    out = sim("geometric_controller_with_estimator_gece.slx");
    run("plots_est_gece.m");

elseif flag2 == "pass_est_gece"
    out = sim("passivity_based_controller_with_estimator_gece.slx");
    run("plots_est_gece.m");

end