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
plot(out.logsout.get('uT').Values.Time, out.logsout.get('uT').Values.Data, 'LineWidth', 1);
ylabel('$u_T(t)$ [N]')
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

exportgraphics(f, 'uT_tau_b.pdf');