close all;
clear all;

% Nos = 10;
% 
% b = 2*(randi(2,1,124)-1) - 1;
% 
% t = -0.5:1/Nos:0.5-(1/Nos);
% h = ones(1,Nos);
% 
% d = zeros(length(b)*Nos,1);
% d(1:Nos:end) = b;
% x = conv(d,h);
% snr_dB = 0;
% snr_lin = 10^(0.1*snr_dB);
% n = sqrt(1/snr_lin).*randn(length(x),1);
% c = 13.7;
% B = 8;
% xn = c.*(x+n);
% x = c.*x;
% x = myquant(x,B);
% xn = myquant(xn,B);
% 
% save('voyager_signal_ideal.mat','x');
% save('voyager_signal.mat','xn');

load('voyager_signal_ideal.mat');
load('voyager_signal.mat');

B = 8;
beff = log2(sqrt(mean(abs(xn).^2)));

figure; 
plot(x(1:139),'r--','linewidth',2);
hold on;
plot(xn(1:139),'b-','linewidth',2);
grid;
xlabel('Sample Index');
ylabel('Sample');
legend('ideales Voyager Signal','verrauschtes Originalsignal');
title(strcat('ADC Bitbreite:',num2str(B),'Bit, b_{eff} = ',num2str(beff),'Bit'));


ys = xn;

c = 1;
cvec = [c];
bsoll = 6;
var_soll = 2^(2*bsoll);
kp = (0.002).^2;

for it = 1:length(ys)
    symtemp = c*ys(it);
    eps         = (var_soll) - abs(symtemp)^2;
    c           = c + kp*eps;
    cvec        = [cvec, c];
end

figure; 
plot(cvec,'b-','linewidth',2);
hold on;
plot(1:length(cvec),(2^(bsoll - beff)).*ones(size(cvec)),'k--','linewidth',2);
grid;
ylabel('Skalierungsfaktor a');
xlabel('Sample Index');
legend('Skalierungsfaktor Regler','idealer Skalierungsfaktor');
