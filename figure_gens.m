%% PLOTTING CW SIGNAL
% 
% samples = 1000;
% f_samp = 10e3; %10KHz
% f_sig = 100; %250Hz
% signal = cw_gen(samples,f_samp,f_sig);
% SIGNAL = fftshift(fft(signal)./length(signal));
% 
% subplot(1,2,1)
% plot((1:1:samples)*(1/f_samp),signal)
% xlabel("Time(Seconds)")
% ylabel("Amplitude(Volts)")
% title("TIME DOMAIN PLOT OF A 100HZ SINUSOID")
% 
% subplot(1,2,2)
% ax = (-(samples-1)/2:1:(samples-1)/2)*(f_samp/samples);
% plot(ax,abs(SIGNAL))
% xlabel("Frequency(Hertz)")
% ylabel("Amplitude(Volts)")
% title("FREQUENCY DOMAIN PLOT OF A 100HZ SINUSOID")

%% PLOTTING UNMODULATED PULSE

% samples = 1000;
% duty = 0.1; %10%
% signal = pulse_gen(samples, duty);
% SIGNAL = fftshift(fft(signal)./length(signal));
% 
% subplot(1,2,1)
% plot((1:1:samples)*(1/f_samp),signal)
% xlabel("Time(Seconds)")
% ylabel("Amplitude(Volts)")
% ylim([-0.1 1.1])
% title("TIME DOMAIN PLOT OF A PULSE WITH A 10% DUTY CYCLE")
% 
% subplot(1,2,2)
% ax = (-(samples-1)/2:1:(samples-1)/2)*(f_samp/samples);
% plot(ax,abs(SIGNAL))
% xlabel("Frequency(Hertz)")
% ylabel("Amplitude(Volts)")
% title("FREQUENCY DOMAIN PLOT OF PULSE WITH A 10% DUTY CYCLE")

%% PLOTTING LFM PULSE

samples = 10000;
f_samp = 10e3; %10KHz
f_sig = 0; %starting at 0Hz
BW = 100; %chirp bandwidth - Hz
T = 2; %seconds
signal = chirp_gen(samples,f_samp,f_sig,BW, T);
SIGNAL = fftshift(fft(signal)./length(signal));

subplot(1,2,1)
plot((1:1:samples)*(1/f_samp),signal)
xlabel("Time(Seconds)")
ylabel("Amplitude(Volts)")
title("TIME DOMAIN PLOT OF A PULSE WITH A LFM PULSE")


subplot(1,2,2)
ax = (-(samples-1)/2:1:(samples-1)/2)*(f_samp/samples);
plot(ax,abs(SIGNAL))
xlabel("Frequency(Hertz)")
ylabel("Amplitude(Volts)")
title("FREQUENCY DOMAIN PLOT OF A PULSE WITH A LFM PULSE")


