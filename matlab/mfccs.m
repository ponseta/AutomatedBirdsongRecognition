function [dctcoeff,d] = mfccs(y,nbanks,twindow,fs)

lwindow = twindow*fs;

nwindow = ceil(length(y)/lwindow); % Window number for each segment
pad = lwindow*nwindow - length(y);
y = [y zeros(1,pad)]; % Padding

lwindow = 1024;
NFFT = lwindow;

f = fs/2*linspace(0,1,NFFT/2); 

% Create filter bank
[H,indf] = melfilterbanks(300,fs/2,nbanks,f,fs,0,1); % melfilterbanks(flow,fhigh,nbanks,f,fs,central_frequencies_method ,normalization);


%%%% MFCCs
for nfr = 1:nwindow
    %%% Hamming window
    ywindow = y(1+(nfr-1)*lwindow:nfr*lwindow).*hamming(lwindow)';
    %%% Periodogram
    ps = abs(fft(ywindow,NFFT));
    ps = ps(1:end/2+1);
    %%% Filtering with filter banks
    Efilterbank = zeros(1,nbanks);
    for ibank = 1:nbanks
         Efilterbank (ibank) = log10(sum(ps.*H(ibank,:)));
    end
    dctcoeff(nfr,:) = dct(Efilterbank);
end


%%%% DELTAS
N = 2;
d = zeros(nwindow,nbanks);
divis = 0;
dctcoeffrep = [repmat(dctcoeff(1,:),N,1);dctcoeff;repmat(dctcoeff(end,:),N,1)];
for n = 1:N
    divis = divis + 2*n^2;
end
for i = 1+N:nwindow+N
    divid = zeros(1,nbanks);
    for n = 1:N
        divid = divid + n*(dctcoeffrep(i+n,:)-dctcoeffrep(i-n,:));
    end
    d(i-N,:) = divid./divis;
end
