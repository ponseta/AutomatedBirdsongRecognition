% This script saves the sampling frequency, the MFCC coefficients and the label for output in the 
% corresponding cell. It uses the function described in mfccs.m

trecord = 0;
ninputsloc = 0;
i = 1;
j = 1;
stop = 0;
bird = {};

while(stop==0)
   [stereo,FS] = audioread(matfiles(j).name); 
   [P,Q] = rat(fs/FS);
   
   if (length(resample(stereo(:,1),P,Q))>lwindow)
       bird{i,1} = resample(stereo(:,1),P,Q);
       bird{i,2} = fs; 

       t = 0:1/fs:length(stereo)/fs; 
       bird{i,3} = t(1:end-1);

       [dctcoeff,dctdelta] = mfccs(bird{i,1}',nbanks,twindow,bird{i,2}); %[dctcoeff,dctdelta] = mfccs(signal,nbanks,twindow,fs)
       bird{i,4} = [dctcoeff,dctdelta];

       bird{i,5} = label; %% target
       bird{i,6} = matfiles.name; %% What is it?

       trecord = trecord + length(stereo(:,1))/fs;

       %ninputs = ninputs + size(bird{i,5},1);
       ninputsloc = ninputsloc + size(bird{i,5},1);
       
       i = i+1;
   end
   
   if (j == length(matfiles))
       stop = 1;
   else
       j = j+1;
   end
   
end

stop = 0;
