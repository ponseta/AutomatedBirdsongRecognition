% To extract the characteristic of the MP3 audio recordings, this script has been 
% created. It saves a list of inputs (MFCCs) in a file that will be used in training, 
% as well as a label (1/0) indicating if they belong to the target species or not.
% These data are extracted in data_extract

% It also saves the total duration of the vocalizations used for each species

%% INPUT SET
clear all
nbanks = 41;
N = 11; % Number of classes
lwindow = 1024;
fs = 32000;

% Data needed to resample
FS = 44100;
[P,Q] = rat(fs/FS);


data = {};

%% Falco naumanni
cd C:\Users\carme\OneDrive\Master\TFM\cantos\FalcoNaumani\Segments\-20dB-center
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\FalcoNaumani\Segments\-20dB-center';
matfiles = dir(fullfile(testfiledir, 'f*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(1) = 1;

data_extract
data = [data;bird]; 


tcer = trecord;
ninputscer = ninputsloc;

%% Streptopelia decaocto
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\StreptopeliaDecaocto
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\StreptopeliaDecaocto';
matfiles = dir(fullfile(testfiledir, 'Tors*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(2) = 1;

data_extract
data = [data;bird]; 

ttor = trecord;
ninputstor = ninputsloc;

%% Columba livia
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\ColumbaLivia
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\ColumbaLivia';
matfiles = dir(fullfile(testfiledir, 'Pal*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(3) = 1;

data_extract
data = [data;bird]; 

tpal = trecord;
ninputspal = ninputsloc;

%% Passer domesticus
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\PasserDomesticus
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\PasserDomesticus';
matfiles = dir(fullfile(testfiledir, 'Gor*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(4) = 1;

data_extract
data = [data;bird]; 

tgor = trecord;
ninputsgor = ninputsloc;

%% Falco Tinnunculus
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\FalcoTinnunculus
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\FalcoTinnunculus';
matfiles = dir(fullfile(testfiledir, 'Cer*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(5) = 1;

data_extract
data = [data;bird]; 

tfal = trecord;
ninputsfal = ninputsloc;

%% Coloeus monedula
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\Coloeusmonedula
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\Coloeusmonedula';
matfiles = dir(fullfile(testfiledir, 'Gra*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(6) = 1;

data_extract
data = [data;bird]; 

tgra = trecord;
ninputsgra = ninputsloc;

%% Apus Apus
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\ApusApus
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\ApusApus';
matfiles = dir(fullfile(testfiledir, 'Ven*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(7) = 1;

data_extract
data = [data;bird]; 

tven = trecord; 
ninputsven = ninputsloc;

%% Emberiza Calandra
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\EmberizaCalandra
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\EmberizaCalandra';
matfiles = dir(fullfile(testfiledir, 'Tri*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(8) = 1;

data_extract
data = [data;bird]; 

ttri = trecord;
ninputstri = ninputsloc;

%% Upupa Epops
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\UpupaEpops
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\UpupaEpops';
matfiles = dir(fullfile(testfiledir, 'Abu*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(9) = 1;

data_extract
data = [data;bird]; 

tabu = trecord;
ninputsabu = ninputsloc;

%% Sturnus Unicolor
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\SturnusUnicolor
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras\Segmentos\SturnusUnicolor';
matfiles = dir(fullfile(testfiledir, 'stu*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(10) = 1;

data_extract
data = [data;bird]; 

tstu = trecord;
ninputsstu = ninputsloc;

%%  Background 
cd C:\Users\carme\OneDrive\Master\TFM\cantos\Otras
testfiledir = 'C:\Users\carme\OneDrive\Master\TFM\cantos\Otras';
matfiles = dir(fullfile(testfiledir, 'no-target*'));
nfilesb = length(matfiles);

label = zeros(1,N);
label(11) = 1;

data_extract
data = [data;bird]; 

tback = trecord;
ninputsback = ninputsloc;

%%
ninputs = ninputsback + ninputsstu + ninputsabu + ninputstri + ninputsven + ninputsgra + ninputsfal + ninputsgor + ninputspal + ninputstor + ninputscer;

cd C:\Users\carme\OneDrive\Master\TFM\MATscripts
save('.mat','data','fs','nbanks','ninputs','tcer','tcer','ttor','tpal','tgor','tfal','tgra','tven','ttri','tabu','tstu','tback')
%save('inputsMFCCmat.mat','data','fs','ninputs')
