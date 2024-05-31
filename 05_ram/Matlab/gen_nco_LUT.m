close all;
clear variables;

D           = 256;      %% LUT Speihertiefe
W           = 8;        %% LUT Wortbreite
dphi        = pi/2/D;   %% Delta Phi der LUT Einträge
pvector     = 0:dphi:pi/2; %% Phasenvektor generieren

vector_cos = cos(pvector(1:D)); %% Cosinuswerte erzeugen
vector_sin = sin(pvector(1:D)); %% Cosinuswerte erzeugen

gen_mif_file('cos_ram.mif',vector_cos,W,D,1); %% MIF File schreiben
gen_mif_file('sin_ram.mif',vector_sin,W,D,1); %% MIF File schreiben


figure; plot((0:0.01:2*pi)./pi,cos(0:0.01:2*pi),'b-')
hold on; 
plot((0:0.01:2*pi)./pi,sin(0:0.01:2*pi),'r-');
grid,
xlabel('phase/\pi')
