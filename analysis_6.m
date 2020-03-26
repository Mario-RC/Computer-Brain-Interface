% Analisis 6

clear all
close all
clc

addpath('./functions');
load center_out_data

alpha = 0.01;
X.all = [];
X.fold1 = [];
X.fold2 = [];
X.fold3 = [];
X.fold4 = [];
X.fold5 = [];
yx.all = [];
yx.fold1 = [];
yx.fold2 = [];
yx.fold3 = [];
yx.fold4 = [];
yx.fold5 = [];
yy.all = [];
yy.fold1 = [];
yy.fold2 = [];
yy.fold3 = [];
yy.fold4 = [];
yy.fold5 = [];

for i = 1:size(trial_data,2)
    X.all = [X.all; trial_data(i).M1_spikes];
    yx.all = [yx.all; trial_data(i).vel(:,1)];
    yy.all = [yy.all; trial_data(i).vel(:,2)];
end

% Cross Validation
folds = [4452 8905 13358 17811];
X.fold1 = X.all(1:folds(1),:);
yx.fold1 = yx.all(1:folds(1),:);
yy.fold1 = yy.all(1:folds(1),:);
X.fold2 = X.all(folds(1)+1:folds(2),:);
yx.fold2 = yx.all(folds(1)+1:folds(2),:);
yy.fold2 = yy.all(folds(1)+1:folds(2),:);
X.fold3 = X.all(folds(2)+1:folds(3),:);
yx.fold3 = yx.all(folds(2)+1:folds(3),:);
yy.fold3 = yy.all(folds(2)+1:folds(3),:);
X.fold4 = X.all(folds(3)+1:folds(4),:);
yx.fold4 = yx.all(folds(3)+1:folds(4),:);
yy.fold4 = yy.all(folds(3)+1:folds(4),:);
X.fold5 = X.all(folds(4)+1:end,:);
yx.fold5 = yx.all(folds(4)+1:end,:);
yy.fold5 = yy.all(folds(4)+1:end,:);

X.train = [X.fold1; X.fold2; X.fold3; X.fold4];
X.train = [ones(size(X.train,1),1) X.train];
yx.train = [yx.fold1; yx.fold2; yx.fold3; yx.fold4];
yy.train = [yy.fold1; yy.fold2; yy.fold3; yy.fold4];
X.test = [X.fold5];
yx.test = [yx.fold5];
yy.test = [yy.fold5];

[bx,bintx,rx,rintx,statsx] = regress(yx.train,X.train,alpha);
bx = bx(2:end,1);
[by,binty,ry,rinty,statsy] = regress(yy.train,X.train,alpha);
by = by(2:end,1);

for i = 1:5 % Coger 5 Neuronas aleatorias
    rng('shuffle')
    trial_number(1,i) = randi([1 84]);
end

% Mínimo tiempo entre mostrar el objetibo al mono y el final del experimento
% Hallamos la repetición más rápida (20 bins)
maxbin = 3;
minbin = inf;
for i = 1:size(trial_data,2)
    value = trial_data(i).idx_trial_end - trial_data(i).idx_go_cue;
    if value < minbin
        minbin = value;
        ind_min = i;
    end
end

% Restamos 3 bins de tiempo al instante de 'go cue'
start = [trial_data.idx_go_cue]' - maxbin;
% Sumamos (20) la repetición más rápida
finish = [trial_data.idx_go_cue]' + minbin;

figure
for j = 1:size(trial_number,2)

    for i = 1:size(trial_data(trial_number(j)).M1_spikes,1)
        vx(i,1) = trial_data(trial_number(j)).M1_spikes(i,:)*bx;
        vy(i,1) = trial_data(trial_number(j)).M1_spikes(i,:)*by;
    end

    % Empiricamente
    offsetx = 4;
    offsety = 4;
    vx = vx - offsetx;
    vy = vy - offsety;

    t = 1:1:size(trial_data(trial_number(j)).vel(start(trial_number(j)):finish(trial_number(j))),2);
    vx = vx(start(trial_number(j)):finish(trial_number(j)));
    vy = vy(start(trial_number(j)):finish(trial_number(j)));
    
    subplot(2,5,j)
    plot(t,smooth(vx'),t,trial_data(trial_number(j)).vel(start(trial_number(j)):finish(trial_number(j)),1),'LineWidth',2); hold on
    if j == 3
        title('Decodificador velocidad X')
    end
    if j == 5
        legend('Predicción X','Real X','Location','NE')
    end
    axis([0 25 -30 30])
    axis off
    subplot(2,5,j+5)
    plot(t,smooth(vy'),t,trial_data(trial_number(j)).vel(start(trial_number(j)):finish(trial_number(j)),2),'LineWidth',2); hold on
    axis([0 25 -30 30])
    axis off
    if j == 3
      title('Decodificador velocidad Y')
    end
    if j == 5
        legend('Predicción Y','Real Y','Location','SE')
    end

end
