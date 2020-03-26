% Analisis 4

clear all
close all
clc

addpath('./functions')
load center_out_data

% Obtenemos los idxs de mov. de cada objetivo
[idx] = Todos_intentos([trial_data.target_direction]);

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

% Create Gaussian filter
sigma = 2; % pick sigma value for the gaussian
gaussFilter = gausswin(5*sigma + 1);
gaussFilter = gaussFilter/sum(gaussFilter); % normalize

figure
media_conv_vel(1,trial_data,idx.der,start,finish,gaussFilter);
media_conv_vel(2,trial_data,idx.arriba_der,start,finish,gaussFilter);
media_conv_vel(3,trial_data,idx.arriba,start,finish,gaussFilter);
media_conv_vel(4,trial_data,idx.arriba_izq,start,finish,gaussFilter);
media_conv_vel(5,trial_data,idx.izq,start,finish,gaussFilter);
media_conv_vel(6,trial_data,idx.abajo_izq,start,finish,gaussFilter);
media_conv_vel(7,trial_data,idx.abajo,start,finish,gaussFilter);
media_conv_vel(8,trial_data,idx.abajo_der,start,finish,gaussFilter);
legend('Velocidad X','Velocidad Y','go cue','Location','NW')

[mean_conv_pos.der] = media_conv_pos(1,trial_data,idx.der,start,finish,gaussFilter);
[mean_conv_pos.arriba_der] = media_conv_pos(2,trial_data,idx.arriba_der,start,finish,gaussFilter);
[mean_conv_pos.arriba] = media_conv_pos(3,trial_data,idx.arriba,start,finish,gaussFilter);
[mean_conv_pos.arriba_izq] = media_conv_pos(4,trial_data,idx.arriba_izq,start,finish,gaussFilter);
[mean_conv_pos.izq] = media_conv_pos(5,trial_data,idx.izq,start,finish,gaussFilter);
[mean_conv_pos.abajo_izq] = media_conv_pos(6,trial_data,idx.abajo_izq,start,finish,gaussFilter);
[mean_conv_pos.abajo] = media_conv_pos(7,trial_data,idx.abajo,start,finish,gaussFilter);
[mean_conv_pos.abajo_der] = media_conv_pos(8,trial_data,idx.abajo_der,start,finish,gaussFilter);
legend('Posición X','Posición Y','go cue','Location','NW')

media_conv_pos_relativa(1,mean_conv_pos.der);
media_conv_pos_relativa(2,mean_conv_pos.arriba_der);
media_conv_pos_relativa(3,mean_conv_pos.arriba);
media_conv_pos_relativa(4,mean_conv_pos.arriba_izq);
media_conv_pos_relativa(5,mean_conv_pos.izq);
media_conv_pos_relativa(6,mean_conv_pos.abajo_izq);
media_conv_pos_relativa(7,mean_conv_pos.abajo);
media_conv_pos_relativa(8,mean_conv_pos.abajo_der);
legend('Posición X/Y','Ejes','Location','NW')
