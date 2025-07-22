% Computation of a transfer function such that is a low-pass filter that
% has a high cutting frequency to pass almost every signal but with not
% too much noise

r = 1; % order
wc = 1; % cutting frequency [rad/s] (the value must be high)

syms s
den_s = expand((s + wc)^r);       % denominator of the filter's transfer function. In this case "expand(S)" multiplies all parentheses in S 
c_sym = coeffs(den_s,s,"All");     % denominator coefficients. Il vettore di coefficienti ha però per primi i coefficienti di ordine maggiore
c = double(fliplr(c_sym(2:end)));  % non consideriamo il coefficiente di "s^r", e giriamo i coefficienti nel vettore: ora i primi coefficienti del vettore sono quelli a ordine minore
                                   % "d = double(s)" converts the symbolic 
                                   % values s to double precision. Serve
                                   % perché se ad esempio ho il valore 
                                   % simbolico "1/3", viene convertito in "0.3333"  

K = zeros(1,r);                    % K_i coefficients initialization 
K(r) = c(end);                     % "j = 0, ..., r-1". Quindi il coefficiente r-esimo può essere inizializzato già subito 
for i = r-1:-1:1
    prodK_next = prod(K(i+1:end));
    K(i) = c(i)/prodK_next;
end

%%%%%%% TRANSFER FUNCTION %%%%%%%%

G_i = tf(c(end),[1 c])

[mag,phase,wout] = bode(G_i); % in uscita hai rispettivamente array 3D della magnitudo + quello della fase + vettore di frequenze su cui sono stati calcolati i primi 2
Mag=20*log10(mag(:));Phase=phase(:); % converto i vettori 3D in vettori colonna

f = figure('Position', [300 300 1000 300]);
tiledlayout(1,2)

nexttile
semilogx(wout,Mag,'LineWidth',2); % è come plot(x,y,options)
xlabel('Frequency [rad/s]')
ylabel('Magnitude [dB]')
ylim padded
grid on
box on 

nexttile
semilogx(wout,Phase,'LineWidth',2);
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim padded
grid on
box on

%sgtitle("$G_i(s)$'s Bode diagram for $r = $" + r + " and $w_c = $" + wc, 'Interpreter','latex');

%exportgraphics(f, 'Gi(s)_bode_diag.pdf');