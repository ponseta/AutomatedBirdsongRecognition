% This script loads MP3 files, applies mfccs.m, then finalNeuralNetworkFunction15khz.m and 
% accumulates to generate figures in order to manually count FPs, FNs, TPs and TNs.

% CHOOSE A RECORD (not used in training)

song = audioread('XC308093 - Cernícalo primilla - Falco naumanni - lantejuela.mp3');
song = audioread('XC308097 - Cernícalo primilla - Falco naumanni - lantejuela.mp3');
song = audioread('XC141177 - Cernícalo primilla - Falco naumanni - caceres.mp3');
song = audioread('XC308077 - Cernícalo primilla - Falco naumanni.mp3');
song = audioread('XC308089 - Cernícalo primilla - Falco naumanni - lantejuela.mp3');
bird = '\it Falco Naumanni';
song = song(:,1);

% song = audioread('XC179785 - Sturnus Unicolor.mp3');
% song = audioread('XC192088 - Sturnus Unicolor.mp3');
% song = audioread('XC343499 - Sturnus Unicolor.mp3');
% song = song(1:end,1);
% bird = '\it Sturnus Unicolor';

% song = audioread('XC308063 - Streptopelia decaocto.mp3');
% song = audioread('XC269719 - StreptopeliaDecaocto.mp3');
% song = song(1:end,1);
% bird = '\it Streptopelia Decaocto';
  
% song = audioread('XC282760 - Cernícalo vulgar - Falco tinnunculus.mp3');
% song = audioread('XC264073 - Cernícalo vulgar - Falco tinnunculus.mp3');
% song = audioread('XC264073 - Cernícalo vulgar - Falco tinnunculus filter.mp3');
% song = audioread('XC360599 - Cernícalo vulgar - Falco tinnunculus.mp3');
% song = audioread('XC463430 - Cernícalo vulgar - Falco tinnunculus5.mp3');
% song = song(:,1);
% bird = '\it Falco tinnunculus';

% song = audioread('XC289360 - Grajilla occidental - Coloeus monedula.mp3');
% bird = '\it Coloeus monedula';
% song = song(:,1); 

% song = audioread('XC418869 - Vencejo común - Apus apus.mp3');
% song = audioread('XC466671 - Vencejo común - Apus apus.mp3');
% song = song(1:end,1);
% bird = '\it Apus Apus';

% song = audioread('XC263307 - Escribano triguero - Emberiza calandra.mp3');
% song = audioread('XC299528 - Escribano triguero - Emberiza calandra.mp3');
% song = song(1:end,1);
% bird = '\it Emberiza calandra';

% song = audioread('XC278154 - Abubilla común - Upupa epops.mp3');
% song = audioread('XC202569 - Abubilla común - Upupa epops.mp3');
% song = audioread('XC181659 - Abubilla común - Upupa epops.mp3');
% song = song(1:end,1);
% bird = '\it Upupa epops';

% song = audioread('XC246586 - Paloma bravía - Columba livia.mp3');
% bird = '\it Columbia livia';
% song = song(:,1);

% song = audioread('XC381732 - PasserDomesticus.mp3');
% song = song(1:end,1);
% bird = '\it Passer Domesticus';

%%
fs = 32000;
FS = 44100;
[P,Q] = rat(fs/FS);
song = resample(song,P,Q);
lwindow = 1024;

T = (length(song)-1)/fs;
t = 0:1/fs:(length(song)-1)/fs;
f = fs/1024:fs/1024:fs/2;
[spec,f,tspec,psd] = spectrogram(song,lwindow,lwindow/2,f,fs);


% MFCCS
nbanks = 41;
twindow = 0.0232; %twindow = 0.02;
%[dctcoeff,d] = mfccs(data_dn,nbanks,twindow,fs);
[dctcoeff,d] = mfccs(song',nbanks,twindow,fs);


% NN
%[y] = finalNeuralNetworkFunction([dctcoeff(:,2:13) d(:,2:13)]');
[y] = finalNeuralNetworkFunction15khz([dctcoeff(:,2:13) d(:,2:13)]');
%[y] = net([dctcoeff(:,2:13) d(:,2:13)]');
y1 = y(1,:);


% RESULTS IN FIGURE

samples = 16;
detect6 = zeros(1,length(y));
detect7 = zeros(1,length(y));
detect75 = zeros(1,length(y));
detect8 = zeros(1,length(y));
detect9 = zeros(1,length(y));
th1 = 0.3;
th2 = 0.4;
th3 = 0.5;
th4 = 0.6;
th5 = 0.7;
for k = 1:samples:length(y1)-samples
    %sumita(1+(k-1)/samples) = sum(y1(k:k+samples-1));
    sumita(k:k+samples-1) = sum(y1(k:k+samples-1))/samples;
    if(sum(y1(k:k+samples-1))>th5*samples)
        detect6(k:k+samples)=1;
        detect7(k:k+samples)=1;
        detect75(k:k+samples)=1;
        detect8(k:k+samples)=1;
        detect9(k:k+samples)=1;

    elseif(sum(y1(k:k+samples-1))>th4*samples)
        detect6(k:k+samples)=1;
        detect7(k:k+samples)=1;
        detect75(k:k+samples)=1;
        detect8(k:k+samples)=1;

    elseif(sum(y1(k:k+samples-1))>th3*samples)
        detect6(k:k+samples)=1;
        detect7(k:k+samples)=1;
        detect75(k:k+samples)=1;

    elseif(sum(y1(k:k+samples-1))>th2*samples)
        detect6(k:k+samples)=1;
        detect7(k:k+samples)=1;

    elseif(sum(y1(k:k+samples-1))>th1*samples)
        detect6(k:k+samples)=1;
     
    end
end

%%
figure
nframes = 112;
t1 = 0:lwindow/fs:lwindow/fs*length(y);
sumita_ind = 0:1/16:(length(y)-1)/16;
for i=1:floor(length(t1)/nframes)
    %subplot(3,1,1)
    subplot(7,1,1)
    plot(t1(1+nframes*(i-1):i*nframes),detect6(1,1+nframes*(i-1):i*nframes))
    %plot(sumita_ind(1+nframes*(i-1):i*nframes),sumita(1,1+nframes*(i-1):i*nframes))
    xlim([t1(1+nframes*(i-1)) t1(i*nframes+1)])
    %xlim([sumita_ind(1+nframes*(i-1)) sumita_ind(i*nframes+1)])
    ylim([0 1])
    xlabel('Time (s)')
    ylabel(['th>',num2str(th1)])
    title(bird)

    subplot(7,1,2)
    plot(t1(1+nframes*(i-1):i*nframes),detect7(1,1+nframes*(i-1):i*nframes))
    xlim([t1(1+nframes*(i-1)) t1(i*nframes+1)])
    ylim([0 1])
    xlabel('Time (s)')
    ylabel(['th>',num2str(th2)])
    
    subplot(7,1,3)
    plot(t1(1+nframes*(i-1):i*nframes),detect75(1,1+nframes*(i-1):i*nframes))
    xlim([t1(1+nframes*(i-1)) t1(i*nframes+1)])
    ylim([0 1])
    xlabel('Time (s)')
    ylabel(['th>',num2str(th3)])
    
    subplot(7,1,4)
    plot(t1(1+nframes*(i-1):i*nframes),detect8(1,1+nframes*(i-1):i*nframes))
    xlim([t1(1+nframes*(i-1)) t1(i*nframes+1)])
    ylim([0 1])
    xlabel('Time (s)')
    ylabel(['th>',num2str(th4)])
    
    subplot(7,1,5)
    plot(t1(1+nframes*(i-1):i*nframes),detect9(1,1+nframes*(i-1):i*nframes))
    xlim([t1(1+nframes*(i-1)) t1(i*nframes+1)])
    ylim([0 1])
    xlabel('Time (s)')
    ylabel(['th>',num2str(th5)])
    
    %subplot(3,1,2)
    subplot(7,1,6)
    plot(t(1+nframes*lwindow*(i-1):i*lwindow*nframes),song(1+nframes*lwindow*(i-1):i*lwindow*nframes))
    xlim([t(1+nframes*lwindow*(i-1)) t(i*lwindow*nframes)])
    xlabel('Time(s)')
    ylabel('Amplitude')
    
    %subplot(3,1,3)
    subplot(7,1,7)
    surf(tspec(1+nframes*2*(i-1):i*2*nframes),f,log(abs(spec(:,1+nframes*2*(i-1):i*2*nframes))),'EdgeColor','None');
    xlim([tspec(1+nframes*2*(i-1)) tspec(i*2*nframes)])
    view(2)
    xlabel('Time')
    ylabel('Frequency')
    ylim([0 15000])
    
    sound(song(1+nframes*lwindow*(i-1):i*lwindow*nframes),fs)
    
    pause
end

length(sumita_ind)/samples
