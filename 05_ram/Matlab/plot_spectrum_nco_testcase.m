close all;
clear all;

%%%% Read Real Part of Low-IF Signal %%%%%%
fid = fopen('voyager_signal_low_IF_real.dat');
sig_real = fscanf(fid,'%d');
fclose(fid);

%%%% Read Imaginary Part of Low-IF Signal %%%%%%
fid = fopen('voyager_signal_low_IF_imag.dat');
sig_imag = fscanf(fid,'%d');
fclose(fid);

%% Build Complex Signal Vektor %%%%%%%%%%%%%%%%%%%
signal = complex(sig_real, sig_imag);
fc_Hz       = 5e3;  %% Low-IF Carrier Frequency
Bsample_Hz  = 20480; %% IQ Sample Rate 

%%% Generate Spectrum Plot;
Nfft        = 256; %% FFT Size (Frequency resolution)
plotflag    = true;
mypsd(signal, Nfft, Bsample_Hz, plotflag);