clear
clc
close all
format long

% Definierung der Konstanten
f = 10000;
Vth = -5i;
Zth = 1000+(2*pi*f*1.5*10^-3)*1i;

% Variierende Widerstände und Kondensatoren
Rlasten = [100 560 820 1000 1200 3300 10000];
Clasten = [39*10^-9 68*10^-9 150*10^-9 168.8686394038963*10^-9 180*10^-9 220*10^-9 330*10^-9];

% Impedanzen von Kondensatoren
Zlasten = Zc(Clasten, f);

lasten_w = zeros(1,7);
lasten_c = zeros(1,7);

for i=1:7
    lasten_w(i) = Rlasten(i) + imag(Zlasten(4))*1i;
    lasten_c(i) = real(Zth) + Zlasten(i);
end

% Ein Vektor für Leistungen
leistungen_w = zeros(1,7);
leistungen_c = zeros(1,7);


% Ein Vektor für Lastspannungen
Vlasten_w = zeros(1, 7);
Vlasten_c = zeros(1, 7);

% Ein Vektor für Leistungsfaktoren
pf_w = zeros(1, 7);
pf_c = zeros(1, 7);

% Berechnung von Leistungen
for i=1:7
    ergebnissen_w = L(lasten_w(i), Vth, Zth);
    ergebnissen_c = L(lasten_c(i), Vth, Zth);
    leistungen_w(i) = ergebnissen_w(1)*1000;
    leistungen_c(i) = ergebnissen_c(1)*1000;
    Vlasten_w(i) = ergebnissen_w(2);
    Vlasten_c(i) = ergebnissen_c(2);
    pf_w(i) = ergebnissen_w(3);
    pf_c(i) = ergebnissen_c(3);
end

% Graph von Ergebnissen
Lasten_Namen_w=[100 560 820 1000 1200 3300 10000];
Lasten_Namen_c=[39 68 150 168.87 180 220 330];

x = 1:7;

hFigw = figure;
subplot(2,3,1);
bar(leistungen_w);
xticklabels(Lasten_Namen_w);
title("Leistung für Variierenden R")
xlabel("Widerstand [Ohm]");
ylabel("Leistung [mW]");
ylim([0 3.5]);
text(x,leistungen_w,num2str(leistungen_w','%0.4f'),'HorizontalAlignment','center','VerticalAlignment','bottom', 'FontSize', 8);

subplot(2,3,2);
bar(Vlasten_w);
xticklabels(Lasten_Namen_w);
title("Lastspannung für Variierenden R")
xlabel("Widerstand [Ohm]");
ylabel("Lastspannung [V]");
text(x,Vlasten_w,num2str(Vlasten_w','%0.3f'),'HorizontalAlignment','center','VerticalAlignment','bottom');

subplot(2,3,3);
bar(pf_w);
xticklabels(Lasten_Namen_w);
title("Leistungsfaktor für Variierenden R")
xlabel("Widerstand [Ohm]");
ylabel("Leistungsfaktoren");
ylim([0 1.2]);
text(x,pf_w,num2str(pf_w','%0.3f'),'HorizontalAlignment','center','VerticalAlignment','bottom');

subplot(2,3,4);
bar(leistungen_c);
xticklabels(Lasten_Namen_c);
title("Leistung für Variierenden C")
xlabel("Kondensator [nF]");
ylabel("Leistung [mW]");
text(x,leistungen_c,num2str(leistungen_c','%0.4f'),'HorizontalAlignment','center','VerticalAlignment','bottom', 'FontSize', 8);

subplot(2,3,5);
bar(Vlasten_c);
xticklabels(Lasten_Namen_c);
title("Lastspannung für Variierenden C")
xlabel("Kondensator [nF]");
ylabel("Lastspannung [V]");
ylim([0 5]);
text(x,Vlasten_c,num2str(Vlasten_c','%0.3f'),'HorizontalAlignment','center','VerticalAlignment','bottom');

subplot(2,3,6);
bar(pf_c);
xticklabels(Lasten_Namen_c);
title("Leistungsfaktor für Variierenden C")
xlabel("Kondensator [nF]");
ylabel("Leistungsfaktoren");
ylim([0 1.2]);
text(x,pf_c,num2str(pf_c','%0.3f'),'HorizontalAlignment','center','VerticalAlignment','bottom');

hFigw.WindowState = 'maximized';

% Funktion für Leistung
function L = L(z, Vth, Zth)
    Vl = Vth * ((z) / (Zth + z));
    [theta, rho] = cart2pol(real(Vl), imag(Vl));
    leist = 0.5 * ((rho^2) / (z'));
    [thetal, rhol] = cart2pol(real(leist), imag(leist));
    L = [rhol * cos(thetal), rho, cos(thetal)];
end

% Funktion für die Unwandlung von der Kapazität zur Impedanz
function Zc = Zc(x, f)
    Zc = 1 ./ (2*pi*f*x*1i);
end

