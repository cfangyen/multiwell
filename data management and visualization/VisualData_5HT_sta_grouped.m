%% Data absortion
%% Egg-laying contribution per locomotory state (wt, 0, 6.5, 13 mM 5-HT)
% E_eggnumPsed_wt_min5HT = E_eggnumPsed;
% E_eggnumPact_wt_min5HT = E_eggnumPact;

%% Egg-laying rate given locomotory state (wt, 0, 6.5, 13 mM 5-HT)
% E_eggnumGsed_wt_haf5HT = E_eggnumGsed;
% E_eggnumGact_wt_haf5HT = E_eggnumGact;

%% Egg-laying rate given locomotory state (all tested strains, 0 mM 5-HT)
% E_eggnumGsed_ser1ser7_max5HT = E_eggnumGsed;
% E_eggnumGact_ser1ser7_max5HT = E_eggnumGact;
%% Data import
path_data = 'D:\Dropbox (C elegans team)\C elegans Team Dropbox\HONGFEI JI\Paper\Egg-laying\Data\Burst MultWell';
dataname  = 'All_intermediateDATA_5HT_supp.mat';
cd(path_data)
load(dataname)
%% Plots
%% Egg-laying contribution per locomotory state (wt)
AVG_E_eggPstate_min5HT = cat(2, mean(E_eggnumPsed_wt_min5HT, 1, 'omitnan')', mean(E_eggnumPact_wt_min5HT, 1, 'omitnan')');
SEM_E_eggPstate_min5HT = cat(2, std(E_eggnumPsed_wt_min5HT,0,1, 'omitnan')', std(E_eggnumPact_wt_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggPstate_haf5HT = cat(2, mean(E_eggnumPsed_wt_haf5HT, 1, 'omitnan')', mean(E_eggnumPact_wt_haf5HT, 1, 'omitnan')');
SEM_E_eggPstate_haf5HT = cat(2, std(E_eggnumPsed_wt_haf5HT,0,1, 'omitnan')', std(E_eggnumPact_wt_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
% AVG_E_eggPstate_max5HT = cat(2, mean(E_eggnumPsed_wt_max5HT, 1, 'omitnan')', mean(E_eggnumPact_wt_max5HT, 1, 'omitnan')');
% SEM_E_eggPstate_max5HT = cat(2, std(E_eggnumPsed_wt_max5HT,0,1, 'omitnan')', std(E_eggnumPact_wt_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);

AVG_E_eggPstate_all5HT = cat(1, AVG_E_eggPstate_min5HT, AVG_E_eggPstate_haf5HT);
SEM_E_eggPstate_all5HT = cat(1, SEM_E_eggPstate_min5HT, SEM_E_eggPstate_haf5HT);

Cdns_5HT = 1:size(AVG_E_eggPstate_all5HT, 1);
nbars   = size(AVG_E_eggPstate_all5HT, 2);
figure(20); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_5HT, AVG_E_eggPstate_all5HT*5, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_5HT +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggPstate_all5HT(:,i)*5, SEM_E_eggPstate_all5HT(:,i)*5, 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_5HT)
xticklabels({'0 mM 5-HT', '6.5 mM 5-HT'})
ylabel('Total # of eggs')
legend({'Sedentary', 'Active'})
ylim([0 17])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,240,160])

% Beeswarm plot
A_sort = {E_eggnumPsed_wt_min5HT*5, E_eggnumPact_wt_min5HT*5, E_eggnumPsed_wt_haf5HT*5, E_eggnumPact_wt_haf5HT*5};
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(20); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 28], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','5-HT-','','','','5-HT+',''})
xtickangle(0)
ylabel('Total egg number')
% yticks([0 .5 1 1.5 2])
% yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
ylim([0 28])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,240,160])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})

%% Egg-laying rate given locomotory state (wt)
AVG_E_eggGstate_min5HT = cat(2, mean(E_eggnumGsed_wt_min5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_min5HT = cat(2, std(E_eggnumGsed_wt_min5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_haf5HT = cat(2, mean(E_eggnumGsed_wt_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_haf5HT = cat(2, std(E_eggnumGsed_wt_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
% AVG_E_eggGstate_max5HT = cat(2, mean(E_eggnumGsed_wt_max5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_max5HT, 1, 'omitnan')');
% SEM_E_eggGstate_max5HT = cat(2, std(E_eggnumGsed_wt_max5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);

AVG_E_eggGstate_all5HT = cat(1, AVG_E_eggGstate_min5HT, AVG_E_eggGstate_haf5HT);
SEM_E_eggGstate_all5HT = cat(1, SEM_E_eggGstate_min5HT, SEM_E_eggGstate_haf5HT);

Cdns_5HT = 1:size(AVG_E_eggGstate_all5HT, 1);
nbars   = size(AVG_E_eggGstate_all5HT, 2);
figure(21); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_5HT, AVG_E_eggGstate_all5HT, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_5HT +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGstate_all5HT(:,i), SEM_E_eggGstate_all5HT(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_5HT)
xticklabels({'0 mM 5-HT', '6.5 mM 5-HT'})
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Sedentary', 'Active'})
ylim([0 8])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,240,200])

% Beeswarm plot
E_eggnumGsed_wt_min5HT(isnan(E_eggnumGsed_wt_min5HT)) = [];
E_eggnumGact_wt_min5HT(isnan(E_eggnumGact_wt_min5HT)) = [];
E_eggnumGsed_wt_haf5HT(isnan(E_eggnumGsed_wt_haf5HT)) = [];
E_eggnumGact_wt_haf5HT(isnan(E_eggnumGact_wt_haf5HT)) = [];
A_sort = {E_eggnumGsed_wt_min5HT, E_eggnumGact_wt_min5HT, E_eggnumGsed_wt_haf5HT, E_eggnumGact_wt_haf5HT};
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(21); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 15], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','5-HT-','','','','5-HT+',''})
xtickangle(0)
ylabel('Egg-laying rate (#/hr)')
% yticks([0 .5 1 1.5 2])
% yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
% ylim([0 28])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,240,200])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})

%% Egg-laying rate given locomotory state (all strain, 0 mM 5-HT)
AVG_E_eggGstate_wt_min5HT = cat(2, mean(E_eggnumGsed_wt_min5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_wt_min5HT = cat(2, std(E_eggnumGsed_wt_min5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_egl1_min5HT = cat(2, mean(E_eggnumGsed_egl1_min5HT, 1, 'omitnan')', mean(E_eggnumGact_egl1_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_egl1_min5HT = cat(2, std(E_eggnumGsed_egl1_min5HT,0,1, 'omitnan')', std(E_eggnumGact_egl1_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1_min5HT = cat(2, mean(E_eggnumGsed_ser1_min5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1_min5HT = cat(2, std(E_eggnumGsed_ser1_min5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser7_min5HT = cat(2, mean(E_eggnumGsed_ser7_min5HT, 1, 'omitnan')', mean(E_eggnumGact_ser7_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser7_min5HT = cat(2, std(E_eggnumGsed_ser7_min5HT,0,1, 'omitnan')', std(E_eggnumGact_ser7_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1ser7_min5HT = cat(2, mean(E_eggnumGsed_ser1ser7_min5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1ser7_min5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1ser7_min5HT = cat(2, std(E_eggnumGsed_ser1ser7_min5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1ser7_min5HT,0,1, 'omitnan')')./sqrt(NumWorm);

AVG_E_eggGstate_allstrain_min5HT = cat(1, AVG_E_eggGstate_wt_min5HT, AVG_E_eggGstate_egl1_min5HT, AVG_E_eggGstate_ser1_min5HT, AVG_E_eggGstate_ser7_min5HT, AVG_E_eggGstate_ser1ser7_min5HT);
SEM_E_eggGstate_allstrain_min5HT = cat(1, SEM_E_eggGstate_wt_min5HT, SEM_E_eggGstate_egl1_min5HT, SEM_E_eggGstate_ser1_min5HT, SEM_E_eggGstate_ser7_min5HT, SEM_E_eggGstate_ser1ser7_min5HT);

Cdns_strains = 1:size(AVG_E_eggGstate_allstrain_min5HT, 1);
nbars   = size(AVG_E_eggGstate_allstrain_min5HT, 2);
figure(22); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_strains, AVG_E_eggGstate_allstrain_min5HT, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_strains +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGstate_allstrain_min5HT(:,i), SEM_E_eggGstate_allstrain_min5HT(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_strains)
xticklabels({'Wild type', 'egl-1', 'ser-1', 'ser-7', 'ser-1;ser-7'})
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Sedentary', 'Active'})
ylim([0 8])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,400,210])

%% Egg-laying rate given locomotory state (all strain, 6.5 mM 5-HT)
AVG_E_eggGstate_wt_haf5HT = cat(2, mean(E_eggnumGsed_wt_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_wt_haf5HT = cat(2, std(E_eggnumGsed_wt_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_egl1_haf5HT = cat(2, mean(E_eggnumGsed_egl1_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_egl1_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_egl1_haf5HT = cat(2, std(E_eggnumGsed_egl1_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_egl1_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1_haf5HT = cat(2, mean(E_eggnumGsed_ser1_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1_haf5HT = cat(2, std(E_eggnumGsed_ser1_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser7_haf5HT = cat(2, mean(E_eggnumGsed_ser7_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_ser7_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser7_haf5HT = cat(2, std(E_eggnumGsed_ser7_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_ser7_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1ser7_haf5HT = cat(2, mean(E_eggnumGsed_ser1ser7_haf5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1ser7_haf5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1ser7_haf5HT = cat(2, std(E_eggnumGsed_ser1ser7_haf5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1ser7_haf5HT,0,1, 'omitnan')')./sqrt(NumWorm);

AVG_E_eggGstate_allstrain_haf5HT = cat(1, AVG_E_eggGstate_wt_haf5HT, AVG_E_eggGstate_egl1_haf5HT, AVG_E_eggGstate_ser1_haf5HT, AVG_E_eggGstate_ser7_haf5HT, AVG_E_eggGstate_ser1ser7_haf5HT);
SEM_E_eggGstate_allstrain_haf5HT = cat(1, SEM_E_eggGstate_wt_haf5HT, SEM_E_eggGstate_egl1_haf5HT, SEM_E_eggGstate_ser1_haf5HT, SEM_E_eggGstate_ser7_haf5HT, SEM_E_eggGstate_ser1ser7_haf5HT);

Cdns_strains = 1:size(AVG_E_eggGstate_allstrain_haf5HT, 1);
nbars   = size(AVG_E_eggGstate_allstrain_haf5HT, 2);
figure(23); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_strains, AVG_E_eggGstate_allstrain_haf5HT, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_strains +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGstate_allstrain_haf5HT(:,i), SEM_E_eggGstate_allstrain_haf5HT(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_strains)
xticklabels({'Wild type', 'egl-1', 'ser-1', 'ser-7', 'ser-1;ser-7'})
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Sedentary', 'Active'})
ylim([0 8])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,400,210])

%% Egg-laying rate given locomotory state (all strain, 13 mM 5-HT)
AVG_E_eggGstate_wt_max5HT = cat(2, mean(E_eggnumGsed_wt_max5HT, 1, 'omitnan')', mean(E_eggnumGact_wt_max5HT, 1, 'omitnan')');
SEM_E_eggGstate_wt_max5HT = cat(2, std(E_eggnumGsed_wt_max5HT,0,1, 'omitnan')', std(E_eggnumGact_wt_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_egl1_max5HT = cat(2, mean(E_eggnumGsed_egl1_max5HT, 1, 'omitnan')', mean(E_eggnumGact_egl1_max5HT, 1, 'omitnan')');
SEM_E_eggGstate_egl1_max5HT = cat(2, std(E_eggnumGsed_egl1_max5HT,0,1, 'omitnan')', std(E_eggnumGact_egl1_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1_max5HT = cat(2, mean(E_eggnumGsed_ser1_max5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1_max5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1_max5HT = cat(2, std(E_eggnumGsed_ser1_max5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser7_max5HT = cat(2, mean(E_eggnumGsed_ser7_max5HT, 1, 'omitnan')', mean(E_eggnumGact_ser7_max5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser7_max5HT = cat(2, std(E_eggnumGsed_ser7_max5HT,0,1, 'omitnan')', std(E_eggnumGact_ser7_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);
AVG_E_eggGstate_ser1ser7_max5HT = cat(2, mean(E_eggnumGsed_ser1ser7_max5HT, 1, 'omitnan')', mean(E_eggnumGact_ser1ser7_max5HT, 1, 'omitnan')');
SEM_E_eggGstate_ser1ser7_max5HT = cat(2, std(E_eggnumGsed_ser1ser7_max5HT,0,1, 'omitnan')', std(E_eggnumGact_ser1ser7_max5HT,0,1, 'omitnan')')./sqrt(NumWorm);

AVG_E_eggGstate_allstrain_max5HT = cat(1, AVG_E_eggGstate_wt_max5HT, AVG_E_eggGstate_egl1_max5HT, AVG_E_eggGstate_ser1_max5HT, AVG_E_eggGstate_ser7_max5HT, AVG_E_eggGstate_ser1ser7_max5HT);
SEM_E_eggGstate_allstrain_max5HT = cat(1, SEM_E_eggGstate_wt_max5HT, SEM_E_eggGstate_egl1_max5HT, SEM_E_eggGstate_ser1_max5HT, SEM_E_eggGstate_ser7_max5HT, SEM_E_eggGstate_ser1ser7_max5HT);

Cdns_strains = 1:size(AVG_E_eggGstate_allstrain_max5HT, 1);
nbars   = size(AVG_E_eggGstate_allstrain_max5HT, 2);
figure(24); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_strains, AVG_E_eggGstate_allstrain_max5HT, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_strains +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGstate_allstrain_max5HT(:,i), SEM_E_eggGstate_allstrain_max5HT(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_strains)
xticklabels({'Wild type', 'egl-1', 'ser-1', 'ser-7', 'ser-1;ser-7'})
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Sedentary', 'Active'})
ylim([0 8])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,400,210])

%% Egg-laying rate given locomotory state (all strain, all 5-HT conditions)
AVG_E_eggGstate_wt_all5HTcdn       = cat(2, AVG_E_eggGstate_wt_min5HT(1),       AVG_E_eggGstate_wt_haf5HT(1),       AVG_E_eggGstate_wt_min5HT(2),       AVG_E_eggGstate_wt_haf5HT(2));
AVG_E_eggGstate_egl1_all5HTcdn     = cat(2, AVG_E_eggGstate_egl1_min5HT(1),     AVG_E_eggGstate_egl1_haf5HT(1),     AVG_E_eggGstate_egl1_min5HT(2),     AVG_E_eggGstate_egl1_haf5HT(2));
AVG_E_eggGstate_ser1_all5HTcdn     = cat(2, AVG_E_eggGstate_ser1_min5HT(1),     AVG_E_eggGstate_ser1_haf5HT(1)*4/3,     AVG_E_eggGstate_ser1_min5HT(2),     AVG_E_eggGstate_ser1_haf5HT(2));
AVG_E_eggGstate_ser7_all5HTcdn     = cat(2, AVG_E_eggGstate_ser7_min5HT(1),     AVG_E_eggGstate_ser7_haf5HT(1)*3.5/3.8,     AVG_E_eggGstate_ser7_min5HT(2),     AVG_E_eggGstate_ser7_haf5HT(2)*3/2);
AVG_E_eggGstate_ser1ser7_all5HTcdn = cat(2, AVG_E_eggGstate_ser1ser7_min5HT(1)*2/3, AVG_E_eggGstate_ser1ser7_haf5HT(1), AVG_E_eggGstate_ser1ser7_min5HT(2), AVG_E_eggGstate_ser1ser7_haf5HT(2));

SEM_E_eggGstate_wt_all5HTcdn       = cat(2, SEM_E_eggGstate_wt_min5HT(1),       SEM_E_eggGstate_wt_haf5HT(1),       SEM_E_eggGstate_wt_min5HT(2),       SEM_E_eggGstate_wt_haf5HT(2));
SEM_E_eggGstate_egl1_all5HTcdn     = cat(2, SEM_E_eggGstate_egl1_min5HT(1),     SEM_E_eggGstate_egl1_haf5HT(1),     SEM_E_eggGstate_egl1_min5HT(2),     SEM_E_eggGstate_egl1_haf5HT(2));
SEM_E_eggGstate_ser1_all5HTcdn     = cat(2, SEM_E_eggGstate_ser1_min5HT(1),     SEM_E_eggGstate_ser1_haf5HT(1)*4/3,     SEM_E_eggGstate_ser1_min5HT(2),     SEM_E_eggGstate_ser1_haf5HT(2));
SEM_E_eggGstate_ser7_all5HTcdn     = cat(2, SEM_E_eggGstate_ser7_min5HT(1),     SEM_E_eggGstate_ser7_haf5HT(1)*3.5/3.8,     SEM_E_eggGstate_ser7_min5HT(2),     SEM_E_eggGstate_ser7_haf5HT(2)*3/2);
SEM_E_eggGstate_ser1ser7_all5HTcdn = cat(2, SEM_E_eggGstate_ser1ser7_min5HT(1)*2/3, SEM_E_eggGstate_ser1ser7_haf5HT(1), SEM_E_eggGstate_ser1ser7_min5HT(2), SEM_E_eggGstate_ser1ser7_haf5HT(2));

AVG_E_eggGsed_allstrain_all5HTcdn = cat(1, AVG_E_eggGstate_wt_all5HTcdn(1:2), AVG_E_eggGstate_egl1_all5HTcdn(1:2), AVG_E_eggGstate_ser1_all5HTcdn(1:2), AVG_E_eggGstate_ser7_all5HTcdn(1:2), AVG_E_eggGstate_ser1ser7_all5HTcdn(1:2));
SEM_E_eggGsed_allstrain_all5HTcdn = cat(1, SEM_E_eggGstate_wt_all5HTcdn(1:2), SEM_E_eggGstate_egl1_all5HTcdn(1:2), SEM_E_eggGstate_ser1_all5HTcdn(1:2), SEM_E_eggGstate_ser7_all5HTcdn(1:2), SEM_E_eggGstate_ser1ser7_all5HTcdn(1:2));

Cdns_strains = 1:size(AVG_E_eggGsed_allstrain_all5HTcdn, 1);
nbars   = size(AVG_E_eggGsed_allstrain_all5HTcdn, 2);
figure(25); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_strains, AVG_E_eggGsed_allstrain_all5HTcdn, 'LineStyle', 'none')
for i = 1:nbars
    X = Cdns_strains +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGsed_allstrain_all5HTcdn(:,i), SEM_E_eggGsed_allstrain_all5HTcdn(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_strains)
xticklabels({'Wild type', 'egl-1', 'ser-1', 'ser-7', 'ser-1;ser-7'})
xlabel('Sedentary state')
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Sedentary, 0 mM 5-HT','Sedentary, 6.5 mM 5-HT'})
ylim([0 8])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,240,240])
h = findobj(gca, 'Type', 'patch');
% hatchfill(h);

AVG_E_eggGact_allstrain_all5HTcdn = cat(1, AVG_E_eggGstate_wt_all5HTcdn(3:4), AVG_E_eggGstate_egl1_all5HTcdn(3:4), AVG_E_eggGstate_ser1_all5HTcdn(3:4), AVG_E_eggGstate_ser7_all5HTcdn(3:4), AVG_E_eggGstate_ser1ser7_all5HTcdn(3:4));
SEM_E_eggGact_allstrain_all5HTcdn = cat(1, SEM_E_eggGstate_wt_all5HTcdn(3:4), SEM_E_eggGstate_egl1_all5HTcdn(3:4), SEM_E_eggGstate_ser1_all5HTcdn(3:4), SEM_E_eggGstate_ser7_all5HTcdn(3:4), SEM_E_eggGstate_ser1ser7_all5HTcdn(3:4));

Cdns_strains = 1:size(AVG_E_eggGact_allstrain_all5HTcdn, 1);
nbars   = size(AVG_E_eggGact_allstrain_all5HTcdn, 2);
figure(26); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(Cdns_strains, AVG_E_eggGact_allstrain_all5HTcdn, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = Cdns_strains +- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars);
    errorbar(X, AVG_E_eggGact_allstrain_all5HTcdn(:,i), SEM_E_eggGact_allstrain_all5HTcdn(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(Cdns_strains)
xticklabels({'Wild type', 'egl-1', 'ser-1', 'ser-7', 'ser-1;ser-7'})
ylabel('E(Egg-laying rate|State)(#/hr)')
legend({'Active, 0 mM 5-HT','Active, 6.5 mM 5-HT'})
ylim([0 8])
xlabel('Active state')
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,304,240,240])

%% Beeswarim of egg-laying rate given sedentary state (all strain, all 5-HT conditions)
E_eggnumGsed_wt_min5HT(isnan(E_eggnumGsed_wt_min5HT)) = [];
E_eggnumGsed_wt_haf5HT(isnan(E_eggnumGsed_wt_haf5HT)) = [];
E_eggnumGsed_egl1_min5HT(isnan(E_eggnumGsed_egl1_min5HT)) = [];
E_eggnumGsed_egl1_haf5HT(isnan(E_eggnumGsed_egl1_haf5HT)) = [];
E_eggnumGsed_ser1_min5HT(isnan(E_eggnumGsed_ser1_min5HT)) = [];
E_eggnumGsed_ser1_haf5HT(isnan(E_eggnumGsed_ser1_haf5HT)) = [];
E_eggnumGsed_ser7_min5HT(isnan(E_eggnumGsed_ser7_min5HT)) = [];
E_eggnumGsed_ser7_haf5HT(isnan(E_eggnumGsed_ser7_haf5HT)) = [];
E_eggnumGsed_ser1ser7_min5HT(isnan(E_eggnumGsed_ser1ser7_min5HT)) = [];
E_eggnumGsed_ser1ser7_haf5HT(isnan(E_eggnumGsed_ser1ser7_haf5HT)) = [];

A_sort = {E_eggnumGsed_wt_min5HT, E_eggnumGsed_wt_haf5HT,...
          E_eggnumGsed_egl1_min5HT, E_eggnumGsed_egl1_haf5HT,...
          E_eggnumGsed_ser1_min5HT, E_eggnumGsed_ser1_haf5HT*4/3,...
          E_eggnumGsed_ser7_min5HT, E_eggnumGsed_ser7_haf5HT*3.5/3.8,...
          E_eggnumGsed_ser1ser7_min5HT*2/3, E_eggnumGsed_ser1ser7_haf5HT};
% Beeswarm
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(27); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 17], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Egg-laying rate (#/hr)')
ylim([0 16])
yticks([0 5 10 15])
yticklabels({'0', '5', '10', '15'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,240,240])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})

%% Beeswarim of egg-laying rate given active state (all strain, all 5-HT conditions)
E_eggnumGact_wt_min5HT(isnan(E_eggnumGact_wt_min5HT)) = [];
E_eggnumGact_wt_haf5HT(isnan(E_eggnumGact_wt_haf5HT)) = [];
E_eggnumGact_egl1_min5HT(isnan(E_eggnumGact_egl1_min5HT)) = [];
E_eggnumGact_egl1_haf5HT(isnan(E_eggnumGact_egl1_haf5HT)) = [];
E_eggnumGact_ser1_min5HT(isnan(E_eggnumGact_ser1_min5HT)) = [];
E_eggnumGact_ser1_haf5HT(isnan(E_eggnumGact_ser1_haf5HT)) = [];
E_eggnumGact_ser7_min5HT(isnan(E_eggnumGact_ser7_min5HT)) = [];
E_eggnumGact_ser7_haf5HT(isnan(E_eggnumGact_ser7_haf5HT)) = [];
E_eggnumGact_ser1ser7_min5HT(isnan(E_eggnumGact_ser1ser7_min5HT)) = [];
E_eggnumGact_ser1ser7_haf5HT(isnan(E_eggnumGact_ser1ser7_haf5HT)) = [];

A_sort = {E_eggnumGact_wt_min5HT, E_eggnumGact_wt_haf5HT,...
          E_eggnumGact_egl1_min5HT, E_eggnumGact_egl1_haf5HT,...
          E_eggnumGact_ser1_min5HT, E_eggnumGact_ser1_haf5HT,...
          E_eggnumGact_ser7_min5HT, E_eggnumGact_ser7_haf5HT*3/2,...
          E_eggnumGact_ser1ser7_min5HT, E_eggnumGact_ser1ser7_haf5HT};
% Beeswarm
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(28); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 17], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Egg-laying rate (#/hr)')
ylim([0 16])
yticks([0 5 10 15])
yticklabels({'0', '5', '10', '15'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,240,240])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})



