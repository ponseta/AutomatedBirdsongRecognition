% This function calculates the values of the mel filters

function [H,indf] = melfilterbanks(flow,fhigh,nbanks,f,fs,l,n)

k = length(f); % Number of points of DFT

%%% Obtain central frequencies
if l==0
    
    mflow = 1125*log(1+flow/700);
    mfhigh = 1125*log(1+fhigh/700);

    mel = linspace(mflow,mfhigh,nbanks+2);
    hertz = 700*(exp(mel/1125)-1); % Central frequencies
    
elseif l==1
    
    i=0;
    fspaced = (fhigh-flow)/nbanks;
    maxfspaced = fhigh;
    minfspaced = 0;

    while (1)
        i = i+1;
        fl = flow:fspaced:flow+(10)*fspaced;

        fmelspaced = 1125*log(1+fl(end)/700)-1125*log(1+fl(end-1)/700);
        fm = 1125*log(1+fl(end)/700):fmelspaced:1125*log(1+fl(end)/700)+(nbanks+1-10)*fmelspaced;

        hertz = [fl(1:end-1) 700*(exp(fm/1125)-1)];

        if hertz(end)>fhigh %Spaced should be decreased
            newfspaced = (fspaced-minfspaced)/2 + minfspaced;
            maxfspaced = fspaced;
        else %Spaced should be increased
            newfspaced = (maxfspaced - fspaced)/2 + fspaced;
            minfspaced = fspaced;
        end
        %stem(i,hertz(end)-fhigh)
        %hold on
        fspaced = newfspaced;
        if ~(0 <= hertz(end)-fhigh || hertz(end)-fhigh <= -50)
            break
        end
    end
else
    error('Error in -Mel scale- or -Mel+Lineal scale- selection')
end



for i = 1:length(hertz)
    indf(i) = find(f>=hertz(i),1);
end

%%% Create the triangles

H = zeros(nbanks,k);

%figure
for j = 1:nbanks
    if n==0
        nor = 1;
    elseif n==1
        nor = 2/(f(indf(j+2))-f(indf(j)));
    else
        msj('Area normalization option has not been correctly chosen')
    end
    
    H(j,:) = [zeros(1,indf(j)-1) ...
        nor*(((indf(j)):indf(j+1))-indf(j))/(indf(j+1)-indf(j))...
        nor*(indf(j+2)-((indf(j+1)+1):indf(j+2)))/(indf(j+2)-indf(j+1))...
        zeros(1,(k-indf(j+2)))];
     %plot(f,H(j,:))
     %hold on
end

%xlabel('Frequency');
%ylabel('|H|');

indf = indf(2:nbanks+1); % To which frequency correspond each Hbank

