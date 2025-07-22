%% PLOTS SETTINGS

% modifico a monte le impostazioni dei plots
set(groot, 'DefaultAxesFontSize', 12)                      % per i tick (numeri)
set(groot, 'DefaultAxesLabelFontSizeMultiplier', 1.2)      % multiplier che esprime quante volte xlabel e ylabel hanno unFontSize maggiore dei tick
set(groot, 'DefaultTextInterpreter', 'latex')              % per tutto tranne sgtitle
set(groot, 'DefaultAxesTickLabelInterpreter', 'latex')

set(groot, 'defaultLegendInterpreter', 'latex');        
set(groot, 'defaultLegendOrientation', 'horizontal'); 
set(groot, 'defaultLegendLocation', 'southoutside');


colors = [                     % colori richiesti da assignment
    0, 0.4470, 0.7410;         % blu (1° colore di default di matlab)
    0.8500, 0.3250, 0.0980;    % arancio (2° colore di default di matlab)
    0.4940, 0.1840, 0.5560     % viola (4° colore di default di matlab)
];


% external disturbance f_e_dist
f = figure;

hold on
plot(out.logsout.get('f_e_dist').Values.Time, out.logsout.get('f_e_dist').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('f_e_dist').Values.Time, out.logsout.get('f_e_dist').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('f_e_dist').Values.Time, out.logsout.get('f_e_dist').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
xlabel('$t$ [s]')
ylabel('$f_{e,dist}$ [rads]')
ylim padded
grid on
box on 
legend('$f_{e,dist,x}$','$f_{e,dist,y}$','$f_{e,dist,z}$','FontSize',12); 

%sgtitle("External disturbance", 'Interpreter', 'latex');

exportgraphics(f, 'f_e_dist.pdf');




% desired vs current x,y,z
f = figure;
tiledlayout(3,1)

nexttile
hold on
plot(out.logsout.get('pbd').Values.Time,out.logsout.get('pbd').Values.Data(:,1),'LineWidth',1)
plot(out.logsout.get('Position').Values.Time,out.logsout.get('Position').Values.Data(:,1),'LineWidth',1)
hold off
ylabel('$x_d(t), x(t)$ [m]')
ylim padded
grid on
box on

nexttile
hold on
plot(out.logsout.get('pbd').Values.Time,out.logsout.get('pbd').Values.Data(:,2),'LineWidth',1)
plot(out.logsout.get('Position').Values.Time,out.logsout.get('Position').Values.Data(:,2),'LineWidth',1)
hold off
ylabel('$y_d(t), y(t)$ [m]')
ylim padded
grid on
box on

nexttile
hold on
plot(out.logsout.get('pbd').Values.Time,out.logsout.get('pbd').Values.Data(:,3),'LineWidth',1)
plot(out.logsout.get('Position').Values.Time,out.logsout.get('Position').Values.Data(:,3),'LineWidth',1)
hold off
xlabel('$t$ [s]','FontSize',14)
ylabel('$z_d(t), z(t)$ [m]')
ylim padded
grid on
box on

legend('Desired','Current','FontSize',12); 

%sgtitle("Time Evolution of Desired and Current Coordinates", 'Interpreter', 'latex')

exportgraphics(f, 'des_curr_coo.pdf');


% desired vs current phi, theta, psi (roll, pitch, yaw angles)
f = figure;
tiledlayout(3,1);

nexttile
hold on
plot(out.logsout.get('eta_d').Values.Time, out.logsout.get('eta_d').Values.Data(:,1),'LineWidth',1)
plot(out.logsout.get('eta').Values.Time, out.logsout.get('eta').Values.Data(:,1),'LineWidth',1)
hold off
ylabel('$\phi_d(t), \phi(t)$ [rad]')
ylim padded
grid on
box on

nexttile
hold on
plot(out.logsout.get('eta_d').Values.Time, out.logsout.get('eta_d').Values.Data(:,2),'LineWidth',1)
plot(out.logsout.get('eta').Values.Time, out.logsout.get('eta').Values.Data(:,2),'LineWidth',1)
hold off
ylabel('$\theta_d(t), \theta(t)$ [rad]')
ylim padded
grid on
box on

nexttile
hold on
plot(out.logsout.get('eta_d').Values.Time,out.logsout.get('eta_d').Values.Data(:,3),'LineWidth',1)
plot(out.logsout.get('eta').Values.Time,out.logsout.get('eta').Values.Data(:,3),'LineWidth',1)
hold off
xlabel('$t$ [s]','FontSize',14)
ylabel('$\psi_d(t), \psi(t)$ [rad]')
ylim padded
grid on
box on

legend('Desired','Current','FontSize',12); 

%sgtitle("Time Evolution of Desired and Current RPY angles", 'Interpreter', 'latex')

exportgraphics(f, 'des_curr_rpy.pdf');


% errors e_p, dot_e_p
f = figure;
tiledlayout(2,1);

nexttile
hold on
plot(out.logsout.get('ep').Values.Time, out.logsout.get('ep').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('ep').Values.Time, out.logsout.get('ep').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('ep').Values.Time, out.logsout.get('ep').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
ylabel('$e_p(t)$ [m]')
ylim padded
grid on
box on 

nexttile
hold on
plot(out.logsout.get('ep_dot').Values.Time, out.logsout.get('ep_dot').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('ep_dot').Values.Time, out.logsout.get('ep_dot').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('ep_dot').Values.Time, out.logsout.get('ep_dot').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
xlabel('$t$ [s]')
ylabel('$\dot{e}_p(t)$ [m/s]')
ylim padded
grid on
box on 
legend('$e_{px}$,$\dot{e}_{px}$','$e_{py}$,$\dot{e}_{py}$','$e_{pz}$,$\dot{e}_{pz}$','FontSize',12); 

%sgtitle("Errors $e_p$, $\dot{e}_p$", 'Interpreter', 'latex');

exportgraphics(f, 'e_p_dot_e_p.pdf');


% errors e_eta, e_eta_dot
f = figure;
tiledlayout(2,1);

nexttile
hold on
plot(out.logsout.get('e_eta').Values.Time, out.logsout.get('e_eta').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('e_eta').Values.Time, out.logsout.get('e_eta').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('e_eta').Values.Time, out.logsout.get('e_eta').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
ylabel('$e_{\eta}(t)$ [rad]')
ylim padded
grid on
box on 

nexttile
hold on
plot(out.logsout.get('e_eta_dot').Values.Time, out.logsout.get('e_eta_dot').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('e_eta_dot').Values.Time, out.logsout.get('e_eta_dot').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('e_eta_dot').Values.Time, out.logsout.get('e_eta_dot').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
xlabel('$t$ [s]')
ylabel('$\dot{e}_{\eta}(t)$ [rad/s]')
ylim padded
grid on
box on 
legend('$e_{\eta x}$,$\dot{e}_{\eta x}$','$e_{\eta y}$,$\dot{e}_{\eta y}$','$e_{\eta z}$,$\dot{e}_{\eta z}$','FontSize',12); 

%sgtitle("Errors $e_{\eta}(t)$, $\dot{e}_{\eta}(t)$", 'Interpreter', 'latex');

exportgraphics(f, 'e_eta_dot_e_eta.pdf');



% uT, tau_b
f = figure;
tiledlayout(2,1);

nexttile
plot(out.logsout.get('uT_GECE').Values.Time, out.logsout.get('uT_GECE').Values.Data, 'LineWidth', 1);
ylabel('$u_{T,GECE}(t)$ [N]')
ylim padded
grid on
box on 

nexttile
hold on
plot(out.logsout.get('tau_b').Values.Time, out.logsout.get('tau_b').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('tau_b').Values.Time, out.logsout.get('tau_b').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('tau_b').Values.Time, out.logsout.get('tau_b').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
xlabel('$t$ [s]')
ylabel('$\tau^b(t)$ [Nm]')
ylim padded
grid on
box on 

legend('$\tau^b_x(t)$','$\tau^b_y(t)$','$\tau^b_z(t)$','FontSize',12,'Location', 'best'); 

%sgtitle("Control Inputs $u_T(t)$, $\tau^b(t)$", 'Interpreter', 'latex');

exportgraphics(f, 'uT_GECE_tau_b.pdf');


% f_est, tau_est
f = figure;
tiledlayout(2,1);

nexttile
hold on
plot(out.logsout.get('f_est').Values.Time, out.logsout.get('f_est').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('f_est').Values.Time, out.logsout.get('f_est').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('f_est').Values.Time, out.logsout.get('f_est').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
ylabel('$f_e(t)$ [N]')
ylim padded
grid on
box on 

nexttile
hold on
plot(out.logsout.get('tau_est').Values.Time, out.logsout.get('tau_est').Values.Data(:,1), 'LineWidth', 1,'Color',colors(1,:));
plot(out.logsout.get('tau_est').Values.Time, out.logsout.get('tau_est').Values.Data(:,2), 'LineWidth', 1,'Color',colors(2,:));
plot(out.logsout.get('tau_est').Values.Time, out.logsout.get('tau_est').Values.Data(:,3), 'LineWidth', 1,'Color',colors(3,:));
hold off
xlabel('$t$ [s]')
ylabel('$\tau^b_e(t)$ [Nm]')
ylim padded
grid on
box on 

legend('$f_{e x}$,$\tau^b_{ex}(t)$','$f_{e y}$,$\tau^b_{ey}(t)$','$f_{e z}$,$\tau^b_{ez}(t)$','FontSize',12); 

%sgtitle("Estimated Wrench $f_e(t)$, $\tau^b_e(t)$", 'Interpreter', 'latex');

exportgraphics(f, 'f_est_tau_est.pdf');


% uT, uT_GECE
f = figure;
hold on
plot(out.logsout.get('uT').Values.Time, out.logsout.get('uT').Values.Data, 'LineWidth', 1);
plot(out.logsout.get('uT_GECE').Values.Time, out.logsout.get('uT_GECE').Values.Data, 'LineWidth', 1);
hold off
ylabel('$u_T(t)$, $u_{T,GECE}$ [N]')
xlabel('$t$ [s]')
ylim padded
grid on
box on 

legend('$u_T$','$u_{T,GECE}$','FontSize',12); 

%sgtitle("Control Thrust $u_T$ and Total Thrust $u_{T,GECE}$", 'Interpreter', 'latex');

exportgraphics(f, 'uT_uTGECE.pdf');


% k_GE, k_CE
f = figure;
tiledlayout(2,1);

% Primo grafico - k_GE
nexttile
plot(out.logsout.get('k_GE').Values.Time, out.logsout.get('k_GE').Values.Data, 'LineWidth', 1);
ylabel('$k_{GE}$', 'Interpreter', 'latex')
ylim padded
grid on
box on 

% Secondo grafico - k_CE
nexttile
plot(out.logsout.get('k_CE').Values.Time, out.logsout.get('k_CE').Values.Data, 'LineWidth', 1);
ylabel('$k_{CE}$', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex')
ylim padded
grid on
box on 

% Inset (zoom) su k_CE
% Specifica la posizione dell'inset [x, y, width, height] in unità normalizzate (relative alla figura)
inset_ax = axes('Position', [0.65 0.30 0.2 0.2]);  % adatta se serve
box on

% Dati da plottare nello zoom
plot(out.logsout.get('k_CE').Values.Time, out.logsout.get('k_CE').Values.Data, 'LineWidth', 1);
xlim([22.5 28]);       % <-- scegli tu la porzione di tempo
ylim([0.98 1.02]);   % <-- scegli tu la porzione verticale
set(inset_ax, 'FontSize', 8);
grid on

%sgtitle("Ground and Ceiling Effects coefficients", 'Interpreter', 'latex');

exportgraphics(f, 'k_GE_k_CE.pdf');