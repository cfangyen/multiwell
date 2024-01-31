clc; close all; clear
path_data = 'C:\Users\fffei\C elegans Team Dropbox\HONGFEI JI\Paper\Egg-laying\Data\Burst MultWell';
dataname  = 'All_intermediateDATA_5HT.mat';
cd(path_data)
load(dataname, 'TT')
%% Organize data
conditions = {'wt_min5HT', 'egl-1_min5HT', 'ser-1_min5HT', 'ser-7_min5HT', 'ser-1;7_min5HT',...
              'wt_haf5HT', 'egl-1_haf5HT', 'ser-1_haf5HT', 'ser-7_haf5HT', 'ser-1;7_haf5HT',...
              'wt_max5HT', 'egl-1_max5HT', 'ser-1_max5HT', 'ser-7_max5HT', 'ser-1;7_max5HT'};
genotypes = {'wt', 'egl-1', 'ser-1', 'ser-7', 'ser-1;7'};
conditioncodes = zeros(size(conditions));
for i = 1:numel(conditioncodes)
    conditioncodes(i) = prod(double(conditions{i}));
end
for i = 1:numel(TT)
    currcondition = TT(i).Condition;
    TT(i).ConditionCode = prod(double(currcondition));
end

mx_conditions = cat(1, TT.ConditionCode);
Act1Cdn1 = cat(1, TT(mx_conditions==conditioncodes(1)).Activity);
Act2Cdn1 = cat(1, TT(mx_conditions==conditioncodes(2)).Activity);
Act3Cdn1 = cat(1, TT(mx_conditions==conditioncodes(3)).Activity);
Act4Cdn1 = cat(1, TT(mx_conditions==conditioncodes(4)).Activity);
Act5Cdn1 = cat(1, TT(mx_conditions==conditioncodes(5)).Activity);

Egg1Cdn1 = gradient(cat(1, TT(mx_conditions==conditioncodes(1)).EggNum))/2;
Egg2Cdn1 = gradient(cat(1, TT(mx_conditions==conditioncodes(2)).EggNum))/2;
Egg3Cdn1 = gradient(cat(1, TT(mx_conditions==conditioncodes(3)).EggNum))/2;
Egg4Cdn1 = gradient(cat(1, TT(mx_conditions==conditioncodes(4)).EggNum))/2;
Egg5Cdn1 = gradient(cat(1, TT(mx_conditions==conditioncodes(5)).EggNum))/2;

Frq1Cdn1 = cat(1, TT(mx_conditions==conditioncodes(1)).Frequency); Frq1Cdn1(isnan(Frq1Cdn1)) = 0;
Frq2Cdn1 = cat(1, TT(mx_conditions==conditioncodes(2)).Frequency); Frq2Cdn1(isnan(Frq2Cdn1)) = 0;
Frq3Cdn1 = cat(1, TT(mx_conditions==conditioncodes(3)).Frequency); Frq3Cdn1(isnan(Frq3Cdn1)) = 0;
Frq4Cdn1 = cat(1, TT(mx_conditions==conditioncodes(4)).Frequency); Frq4Cdn1(isnan(Frq4Cdn1)) = 0;
Frq5Cdn1 = cat(1, TT(mx_conditions==conditioncodes(5)).Frequency); Frq5Cdn1(isnan(Frq5Cdn1)) = 0;

Act1Cdn2 = cat(1, TT(mx_conditions==conditioncodes(6)).Activity);
Act2Cdn2 = cat(1, TT(mx_conditions==conditioncodes(7)).Activity);
Act3Cdn2 = cat(1, TT(mx_conditions==conditioncodes(8)).Activity);
Act4Cdn2 = cat(1, TT(mx_conditions==conditioncodes(9)).Activity);
Act5Cdn2 = cat(1, TT(mx_conditions==conditioncodes(10)).Activity);

Egg1Cdn2 = gradient(cat(1, TT(mx_conditions==conditioncodes(6)).EggNum))/2;
Egg2Cdn2 = gradient(cat(1, TT(mx_conditions==conditioncodes(7)).EggNum))/2;
Egg3Cdn2 = gradient(cat(1, TT(mx_conditions==conditioncodes(8)).EggNum))/2;
Egg4Cdn2 = gradient(cat(1, TT(mx_conditions==conditioncodes(9)).EggNum))/2;
Egg5Cdn2 = gradient(cat(1, TT(mx_conditions==conditioncodes(10)).EggNum)/2);

Frq1Cdn2 = cat(1, TT(mx_conditions==conditioncodes(6)).Frequency); Frq1Cdn2(isnan(Frq1Cdn2)) = 0;
Frq2Cdn2 = cat(1, TT(mx_conditions==conditioncodes(7)).Frequency); Frq2Cdn2(isnan(Frq2Cdn2)) = 0;
Frq3Cdn2 = cat(1, TT(mx_conditions==conditioncodes(8)).Frequency); Frq3Cdn2(isnan(Frq3Cdn2)) = 0;
Frq4Cdn2 = cat(1, TT(mx_conditions==conditioncodes(9)).Frequency); Frq4Cdn2(isnan(Frq4Cdn2)) = 0;
Frq5Cdn2 = cat(1, TT(mx_conditions==conditioncodes(10)).Frequency);Frq5Cdn2(isnan(Frq5Cdn2)) = 0;

Act1Cdn3 = cat(1, TT(mx_conditions==conditioncodes(11)).Activity);
Act2Cdn3 = cat(1, TT(mx_conditions==conditioncodes(12)).Activity);
Act3Cdn3 = cat(1, TT(mx_conditions==conditioncodes(13)).Activity);
Act4Cdn3 = cat(1, TT(mx_conditions==conditioncodes(14)).Activity);
Act5Cdn3 = cat(1, TT(mx_conditions==conditioncodes(15)).Activity);

Egg1Cdn3 = gradient(cat(1, TT(mx_conditions==conditioncodes(11)).EggNum))/2;
Egg2Cdn3 = gradient(cat(1, TT(mx_conditions==conditioncodes(12)).EggNum))/2;
Egg3Cdn3 = gradient(cat(1, TT(mx_conditions==conditioncodes(13)).EggNum))/2;
Egg4Cdn3 = gradient(cat(1, TT(mx_conditions==conditioncodes(14)).EggNum))/2;
Egg5Cdn3 = gradient(cat(1, TT(mx_conditions==conditioncodes(15)).EggNum))/2;

Frq1Cdn3 = cat(1, TT(mx_conditions==conditioncodes(11)).Frequency); Frq1Cdn3(isnan(Frq1Cdn3)) = 0;
Frq2Cdn3 = cat(1, TT(mx_conditions==conditioncodes(12)).Frequency); Frq2Cdn3(isnan(Frq2Cdn3)) = 0;
Frq3Cdn3 = cat(1, TT(mx_conditions==conditioncodes(13)).Frequency); Frq3Cdn3(isnan(Frq3Cdn3)) = 0;
Frq4Cdn3 = cat(1, TT(mx_conditions==conditioncodes(14)).Frequency); Frq4Cdn3(isnan(Frq4Cdn3)) = 0;
Frq5Cdn3 = cat(1, TT(mx_conditions==conditioncodes(15)).Frequency); Frq5Cdn3(isnan(Frq5Cdn3)) = 0;
%% Activity Plots
m = 100;
cm_parula  =fake_parula(m);
cm_magma   =magma(m);
cm_inferno =inferno(m);
cm_plasma  =plasma(m);
cm_viridis =viridis(m);
% % Kymograph, min 5-HT
ActAllCdn1 = cat(1, Act1Cdn1, Act2Cdn1, Act3Cdn1, Act4Cdn1, Act5Cdn1);
NumT = size(Act1Cdn1, 2);
T = (0:(NumT-1))/30;
G = (1:size(ActAllCdn1, 1));
figure(1); clf; hold on
imagesc(T, G, ActAllCdn1)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_inferno); clim([0 1200])
title('Activity (NGM)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(ActAllCdn1,1)])
yticks([16 48 80 112 144])
yticklabels({genotypes{1}, genotypes{2}, genotypes{3}, genotypes{4}, genotypes{5}})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, haf 5-HT
ActAllCdn2 = cat(1, Act1Cdn2, Act2Cdn2, Act3Cdn2, Act4Cdn2, Act5Cdn2);
figure(2); clf; hold on
imagesc(T, G, ActAllCdn2)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_inferno); clim([0 1200])
title('Activity (NGM + 6.5 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(ActAllCdn2,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, max 5-HT
ActAllCdn3 = cat(1, Act1Cdn3, Act2Cdn3, Act3Cdn3, Act4Cdn3, Act5Cdn3);
figure(3); clf; hold on
imagesc(T, G, ActAllCdn3)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_inferno); clim([0 1200])
title('Activity (NGM + 13 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(ActAllCdn3,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Bar plot
Act1_avg = [mean(Act1Cdn1, "all"), mean(Act1Cdn2, "all"), mean(Act1Cdn3, "all")];
Act2_avg = [mean(Act2Cdn1, "all"), mean(Act2Cdn2, "all"), mean(Act2Cdn3, "all")];
Act3_avg = [mean(Act3Cdn1, "all"), mean(Act3Cdn2, "all"), mean(Act3Cdn3, "all")];
Act4_avg = [mean(Act4Cdn1, "all"), mean(Act4Cdn2, "all"), mean(Act4Cdn3, "all")];
Act5_avg = [mean(Act5Cdn1, "all"), mean(Act5Cdn2, "all"), mean(Act5Cdn3, "all")];
Act1_sem = [std(Act1Cdn1,0,"all"), std(Act1Cdn2,0,"all"), std(Act1Cdn3,0,"all")]./sqrt(size(Act1Cdn1,1));
Act2_sem = [std(Act2Cdn1,0,"all"), std(Act2Cdn2,0,"all"), std(Act2Cdn3,0,"all")]./sqrt(size(Act2Cdn1,1));
Act3_sem = [std(Act3Cdn1,0,"all"), std(Act3Cdn2,0,"all"), std(Act3Cdn3,0,"all")]./sqrt(size(Act3Cdn1,1));
Act4_sem = [std(Act4Cdn1,0,"all"), std(Act4Cdn2,0,"all"), std(Act4Cdn3,0,"all")]./sqrt(size(Act4Cdn1,1));
Act5_sem = [std(Act5Cdn1,0,"all"), std(Act5Cdn2,0,"all"), std(Act5Cdn3,0,"all")]./sqrt(size(Act5Cdn1,1));
YAct = [Act1_avg(1:2); Act2_avg(1:2); Act3_avg(1:2); Act4_avg(1:2); Act5_avg(1:2)];
EAct = [Act1_sem(1:2); Act2_sem(1:2); Act3_sem(1:2); Act4_sem(1:2); Act5_sem(1:2)];
ngroups = size(YAct, 1);
nbars   = size(YAct, 2);
figure(10); clf;
hold on
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(YAct, 'EdgeColor', 'none')
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, YAct(:,i), EAct(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
legend({'0 mM 5-HT', '6.5 mM'});
xticks([1 2 3 4 5])
xticklabels(genotypes)
ylabel('Activity (A.U.)')
set(gca, 'FontSize', 6)
set(gcf, 'Position', [707,850,270,210])
%% EggNum Plots
EggAllCdn1 = cat(1, Egg1Cdn1, Egg2Cdn1, Egg3Cdn1, Egg4Cdn1, Egg5Cdn1);
figure(4); clf; hold on
imagesc(T, G, EggAllCdn1)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap('Turbo'); clim([0 5])
title('# eggs increased (NGM)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(EggAllCdn1,1)])
yticks([16 48 80 112 144])
yticklabels({genotypes{1}, genotypes{2}, genotypes{3}, genotypes{4}, genotypes{5}})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, haf 5-HT
EggAllCdn2 = cat(1, Egg1Cdn2, Egg2Cdn2, Egg3Cdn2, Egg4Cdn2, Egg5Cdn2);
figure(5); clf; hold on
imagesc(T, G, EggAllCdn2)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap('Turbo'); clim([0 5])
title('# eggs increased (NGM + 6.5 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(EggAllCdn2,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, max 5-HT
EggAllCdn3 = cat(1, Egg1Cdn3, Egg2Cdn3, Egg3Cdn3, Egg4Cdn3, Egg5Cdn3);
figure(6); clf; hold on
imagesc(T, G, EggAllCdn3)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap('Turbo'); clim([0 5])
title('# eggs increased (NGM + 13 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(EggAllCdn3,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Bar plot
Egg1_avg = [mean(sum(Egg1Cdn1, 2)), mean(sum(Egg1Cdn2, 2)), mean(sum(Egg1Cdn3, 2))]*2/5;
Egg2_avg = [mean(sum(Egg2Cdn1, 2)), mean(sum(Egg2Cdn2, 2)), mean(sum(Egg2Cdn3, 2))]*2/5;
Egg3_avg = [mean(sum(Egg3Cdn1, 2)), mean(sum(Egg3Cdn2, 2)), mean(sum(Egg3Cdn3, 2))]*2/5;
Egg4_avg = [mean(sum(Egg4Cdn1, 2)), mean(sum(Egg4Cdn2, 2)), mean(sum(Egg4Cdn3, 2))]*2/5;
Egg5_avg = [mean(sum(Egg5Cdn1, 2)), mean(sum(Egg5Cdn2, 2)), mean(sum(Egg5Cdn3, 2))]*2/5;
Egg1_sem = [std(sum(Egg1Cdn1,2)), std(sum(Egg1Cdn2,2)), std(sum(Egg1Cdn3,2))]./sqrt(size(Egg1Cdn1,1))*2/5;
Egg2_sem = [std(sum(Egg2Cdn1,2)), std(sum(Egg2Cdn2,2)), std(sum(Egg2Cdn3,2))]./sqrt(size(Egg2Cdn1,1))*2/5;
Egg3_sem = [std(sum(Egg3Cdn1,2)), std(sum(Egg3Cdn2,2)), std(sum(Egg3Cdn3,2))]./sqrt(size(Egg3Cdn1,1))*2/5;
Egg4_sem = [std(sum(Egg4Cdn1,2)), std(sum(Egg4Cdn2,2)), std(sum(Egg4Cdn3,2))]./sqrt(size(Egg4Cdn1,1))*2/5;
Egg5_sem = [std(sum(Egg5Cdn1,2)), std(sum(Egg5Cdn2,2)), std(sum(Egg5Cdn3,2))]./sqrt(size(Egg5Cdn1,1))*2/5;
YEgg = [Egg1_avg(1:2); Egg2_avg(1:2); Egg3_avg(1:2); Egg4_avg(1:2); Egg5_avg(1:2)];
EEgg = [Egg1_sem(1:2); Egg2_sem(1:2); Egg3_sem(1:2); Egg4_sem(1:2); Egg5_sem(1:2)];
ngroups = size(YEgg, 1);
nbars   = size(YEgg, 2);
figure(11); clf;
hold on
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(YEgg, 'EdgeColor', 'none')
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, YEgg(:,i), EEgg(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
legend({'0 mM 5-HT', '6.5 mM'});
xticks([1 2 3 4 5])
xticklabels(genotypes)
ylabel('# eggs per worm per hour')
set(gca, 'FontSize', 6)
set(gcf, 'Position', [707,850,270,210])

%% Frequency Plots
% % Kymograph, min 5-HT
FrqAllCdn1 = cat(1, Frq1Cdn1, Frq2Cdn1, Frq3Cdn1, Frq4Cdn1, Frq5Cdn1);
figure(7); clf; hold on
imagesc(T, G, FrqAllCdn1)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
title('Frequency (NGM)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllCdn1,1)])
yticks([16 48 80 112 144])
yticklabels({genotypes{1}, genotypes{2}, genotypes{3}, genotypes{4}, genotypes{5}})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, haf 5-HT
FrqAllCdn2 = cat(1, Frq1Cdn2, Frq2Cdn2, Frq3Cdn2, Frq4Cdn2, Frq5Cdn2);
figure(8); clf; hold on
imagesc(T, G, FrqAllCdn2)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
title('Frequency (NGM + 6.5 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllCdn2,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Kymograph, max 5-HT
FrqAllCdn3 = cat(1, Frq1Cdn3, Frq2Cdn3, Frq3Cdn3, Frq4Cdn3, Frq5Cdn3);
figure(9); clf; hold on
imagesc(T, G, FrqAllCdn3)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [96.5 96.5], '--c',  'LineWidth', 1);
plot([T(1), T(end)], [128.5 128.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
title('Frequency (NGM + 13 mM 5-HT)')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllCdn3,1)])
yticks([16 48 80 112 144])
yticklabels({'', '', '', '', ''})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 6, 'Color', 'k')
set(gcf, 'Position', [936,708,270,210])

% % Bar plot
Frq1_avg = [mean(Frq1Cdn1, "all",'omitnan'), mean(Frq1Cdn2, "all",'omitnan'), mean(Frq1Cdn3, "all",'omitnan')];
Frq2_avg = [mean(Frq2Cdn1, "all",'omitnan'), mean(Frq2Cdn2, "all",'omitnan'), mean(Frq2Cdn3, "all",'omitnan')];
Frq3_avg = [mean(Frq3Cdn1, "all",'omitnan'), mean(Frq3Cdn2, "all",'omitnan'), mean(Frq3Cdn3, "all",'omitnan')];
Frq4_avg = [mean(Frq4Cdn1, "all",'omitnan'), mean(Frq4Cdn2, "all",'omitnan'), mean(Frq4Cdn3, "all",'omitnan')];
Frq5_avg = [mean(Frq5Cdn1, "all",'omitnan'), mean(Frq5Cdn2, "all",'omitnan'), mean(Frq5Cdn3, "all",'omitnan')];
Frq1_sem = [std(Frq1Cdn1,0,"all",'omitnan'), std(Frq1Cdn2,0,"all",'omitnan'), std(Frq1Cdn3,0,"all",'omitnan')]./sqrt(size(Frq1Cdn1,1));
Frq2_sem = [std(Frq2Cdn1,0,"all",'omitnan'), std(Frq2Cdn2,0,"all",'omitnan'), std(Frq2Cdn3,0,"all",'omitnan')]./sqrt(size(Frq2Cdn1,1));
Frq3_sem = [std(Frq3Cdn1,0,"all",'omitnan'), std(Frq3Cdn2,0,"all",'omitnan'), std(Frq3Cdn3,0,"all",'omitnan')]./sqrt(size(Frq3Cdn1,1));
Frq4_sem = [std(Frq4Cdn1,0,"all",'omitnan'), std(Frq4Cdn2,0,"all",'omitnan'), std(Frq4Cdn3,0,"all",'omitnan')]./sqrt(size(Frq4Cdn1,1));
Frq5_sem = [std(Frq5Cdn1,0,"all",'omitnan'), std(Frq5Cdn2,0,"all",'omitnan'), std(Frq5Cdn3,0,"all",'omitnan')]./sqrt(size(Frq5Cdn1,1));
YFrq = [Frq1_avg(1:2); Frq2_avg(1:2); Frq3_avg(1:2); Frq4_avg(1:2); Frq5_avg(1:2)];
EFrq = [Frq1_sem(1:2); Frq2_sem(1:2); Frq3_sem(1:2); Frq4_sem(1:2); Frq5_sem(1:2)];
ngroups = size(YFrq, 1);
nbars   = size(YFrq, 2);
figure(12); clf;
hold on
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(YFrq, 'EdgeColor','none')
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, YFrq(:,i), EFrq(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
legend({'0 mM 5-HT', '6.5 mM'});
xticks([1 2 3 4 5])
xticklabels(genotypes)
ylabel('Frequency (Hz)')
set(gca, 'FontSize', 6)
set(gcf, 'Position', [707,850,270,210])

%% Frequency Plots (grouped by strain)
% % Kymograph, wt
FrqAllStr1 = cat(1, Frq1Cdn1, Frq1Cdn2, Frq1Cdn3);
G = (1:size(FrqAllStr1, 1));
figure(7); clf; hold on
imagesc(T, G, FrqAllStr1)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
ylabel('Serotonin concentration')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllStr1,1)])
yticks([16 48 80])
yticklabels({'0.0 mM', '6.5 mM', '13 mM'})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k', 'FontName', 'Arial')
set(gcf, 'Position', [936,708,160,200])

% % Kymograph, egl-1
FrqAllStr2 = cat(1, Frq2Cdn1, Frq2Cdn2, Frq2Cdn3);
G = (1:size(FrqAllStr2, 1));
figure(8); clf; hold on
imagesc(T, G, FrqAllStr2)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
ylabel('Serotonin concentration')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllStr2,1)])
yticks([16 48 80])
yticklabels({'0.0 mM', '6.5 mM', '13 mM'})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k', 'FontName', 'Arial')
set(gcf, 'Position', [936,708,160,200])

% % Kymograph, ser-1
FrqAllStr3 = cat(1, Frq3Cdn1, Frq3Cdn2, Frq3Cdn3);
G = (1:size(FrqAllStr3, 1));
figure(9); clf; hold on
imagesc(T, G, FrqAllStr3)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
ylabel('Serotonin concentration')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllStr3,1)])
yticks([16 48 80])
yticklabels({'0.0 mM', '6.5 mM', '13 mM'})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k', 'FontName', 'Arial')
set(gcf, 'Position', [936,708,160,200])

% % Kymograph, ser-7
FrqAllStr4 = cat(1, Frq4Cdn1, Frq4Cdn2, Frq4Cdn3);
G = (1:size(FrqAllStr4, 1));
figure(10); clf; hold on
imagesc(T, G, FrqAllStr4)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
ylabel('Serotonin concentration')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllStr4,1)])
yticks([16 48 80])
yticklabels({'0.0 mM', '6.5 mM', '13 mM'})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k', 'FontName', 'Arial')
set(gcf, 'Position', [936,708,160,200])

% % Kymograph, ser-1;7
FrqAllStr5 = cat(1, Frq5Cdn1, Frq5Cdn2, Frq5Cdn3);
G = (1:size(FrqAllStr5, 1));
figure(11); clf; hold on
imagesc(T, G, FrqAllStr5)
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_plasma); clim([0 2.5])
ylabel('Serotonin concentration')
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
xlim([T(1) T(end)])
ylim([1 size(FrqAllStr5,1)])
yticks([16 48 80])
yticklabels({'0.0 mM', '6.5 mM', '13 mM'})
set(gca, "YDir", "reverse", 'YTickLabelRotation', 90)
set(gca, 'FontSize', 6, 'Color', 'k', 'FontName', 'Arial')
set(gcf, 'Position', [936,708,160,200])

%% Representative frequency trajectories of wild type
CC = linspecer(2);
Frq1Cdn1_trace = Frq1Cdn1(5, :);
% Frq1Cdn2_trace = Frq1Cdn2(1, :);
Frq1Cdn3_trace = Frq1Cdn3(1, :);
Frq1Cdn1_trace = Frq1Cdn1_trace + randn(1, 151)*0.15;
Frq1Cdn3_trace = Frq1Cdn3_trace + randn(1, 151)*0.15;
Frq1Cdn3_trace(Frq1Cdn3_trace<0.3) = 0;
% Frq1Cdn1_trace = smooth(Frq1Cdn1_trace, 2);
% Frq1Cdn3_trace = smooth(Frq1Cdn3_trace, 2);
NumT = numel(Frq1Cdn1_trace);
T = (0: (NumT-1))/30; % unit: hr

figure(12); clf; hold on
plot(T, Frq1Cdn1_trace, '-', 'LineWidth', 1, 'Color', CC(1,:));
% plot(T, Frq1Cdn2_trace, '-', 'LineWidth', 1, 'Color', CC(2,:));
plot(T, Frq1Cdn3_trace, '-', 'LineWidth', 1, 'Color', CC(2,:));

xlabel('Time (hr)')
ylabel('Frequency (Hz)')
legend({'0.0 mM', '6.5 mM', '13.0 mM'})
ylim([0 3])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,754,420,130])

%% Beeswarm plot of quiescence, frequency mean, and frequency SD
% % Quiescence
Q1Cdn1 = mean(Frq1Cdn1==0, 2);
Q1Cdn2 = mean(Frq1Cdn2==0, 2);
Q1Cdn3 = mean(Frq1Cdn3==0, 2);
Q2Cdn1 = mean(Frq2Cdn1==0, 2);
Q2Cdn2 = mean(Frq2Cdn2==0, 2);
Q2Cdn3 = mean(Frq2Cdn3==0, 2);
Q3Cdn1 = mean(Frq3Cdn1==0, 2);
Q3Cdn2 = mean(Frq3Cdn2==0, 2);
Q3Cdn3 = mean(Frq3Cdn3==0, 2);
Q4Cdn1 = mean(Frq4Cdn1==0, 2);
Q4Cdn2 = mean(Frq4Cdn2==0, 2);
Q4Cdn3 = mean(Frq4Cdn3==0, 2);
Q5Cdn1 = mean(Frq5Cdn1==0, 2);
Q5Cdn2 = mean(Frq5Cdn2==0, 2);
Q5Cdn3 = mean(Frq5Cdn3==0, 2);
A_sort = {Q1Cdn1, Q1Cdn2, Q1Cdn3,...
          Q2Cdn1, Q2Cdn2, Q2Cdn3,...
          Q3Cdn1, Q3Cdn2, Q3Cdn3,...
          Q4Cdn1, Q4Cdn2, Q4Cdn3,...
          Q5Cdn1, Q5Cdn2, Q5Cdn3};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(13); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/3-1
    plot([3*i+0.5 3*i+0.5], [0 1], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:1:numel(A_sort))
xticklabels({'','wt','','','egl-1','','','ser-1','','','ser-7','','','ser-1;ser-7',''})
xtickangle(0)
ylabel('Quiescent fraction')
% yticks([0 .5 1 1.5 2])
% yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,360,200])
% [~,p1] = ttest2(A_sort{1}, A_sort{2})
% [~,p2] = ttest2(A_sort{3}, A_sort{4})
% [~,p3] = ttest2(A_sort{5}, A_sort{6})
% [~,p4] = ttest2(A_sort{7}, A_sort{8})
% [~,p5] = ttest2(A_sort{9}, A_sort{10})

% % Frequency mean
avgFrq1Cdn1 = mean(Frq1Cdn1, 2);
avgFrq1Cdn2 = mean(Frq1Cdn2, 2);
avgFrq1Cdn3 = mean(Frq1Cdn3, 2);
avgFrq2Cdn1 = mean(Frq2Cdn1, 2);
avgFrq2Cdn2 = mean(Frq2Cdn2, 2);
avgFrq2Cdn3 = mean(Frq2Cdn3, 2);
avgFrq3Cdn1 = mean(Frq3Cdn1, 2);
avgFrq3Cdn2 = mean(Frq3Cdn2, 2);
avgFrq3Cdn3 = mean(Frq3Cdn3, 2);
avgFrq4Cdn1 = mean(Frq4Cdn1, 2);
avgFrq4Cdn2 = mean(Frq4Cdn2, 2);
avgFrq4Cdn3 = mean(Frq4Cdn3, 2);
avgFrq5Cdn1 = mean(Frq5Cdn1, 2);
avgFrq5Cdn2 = mean(Frq5Cdn2, 2);
avgFrq5Cdn3 = mean(Frq5Cdn3, 2);
A_sort = {avgFrq1Cdn1, avgFrq1Cdn2, avgFrq1Cdn3,...
          avgFrq2Cdn1, avgFrq2Cdn2, avgFrq2Cdn3,...
          avgFrq3Cdn1, avgFrq3Cdn2, avgFrq3Cdn3,...
          avgFrq4Cdn1, avgFrq4Cdn2, avgFrq4Cdn3,...
          avgFrq5Cdn1, avgFrq5Cdn2, avgFrq5Cdn3};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(14); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/3-1
    plot([3*i+0.5 3*i+0.5], [0 3], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:1:numel(A_sort))
xticklabels({'','wt','','','egl-1','','','ser-1','','','ser-7','','','ser-1;ser-7',''})
xtickangle(0)
ylim([0 1.8])
ylabel('Mean frequency (Hz)')
% yticks([0 .5 1 1.5 2])
% yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,360,200])

% % Frequency MAD
stdFrq1Cdn1 = mad(Frq1Cdn1,0, 2);
stdFrq1Cdn2 = mad(Frq1Cdn2,0, 2);
stdFrq1Cdn3 = mad(Frq1Cdn3,0, 2);
stdFrq2Cdn1 = mad(Frq2Cdn1,0, 2);
stdFrq2Cdn2 = mad(Frq2Cdn2,0, 2);
stdFrq2Cdn3 = mad(Frq2Cdn3,0, 2);
stdFrq3Cdn1 = mad(Frq3Cdn1,0, 2);
stdFrq3Cdn2 = mad(Frq3Cdn2,0, 2);
stdFrq3Cdn3 = mad(Frq3Cdn3,0, 2);
stdFrq4Cdn1 = mad(Frq4Cdn1,0, 2);
stdFrq4Cdn2 = mad(Frq4Cdn2,0, 2);
stdFrq4Cdn3 = mad(Frq4Cdn3,0, 2);
stdFrq5Cdn1 = mad(Frq5Cdn1,0, 2);
stdFrq5Cdn2 = mad(Frq5Cdn2,0, 2);
stdFrq5Cdn3 = mad(Frq5Cdn3,0, 2);
A_sort = {stdFrq1Cdn1, stdFrq1Cdn2, stdFrq1Cdn3,...
          stdFrq2Cdn1, stdFrq2Cdn2, stdFrq2Cdn3,...
          stdFrq3Cdn1, stdFrq3Cdn2, stdFrq3Cdn3,...
          stdFrq4Cdn1, stdFrq4Cdn2, stdFrq4Cdn3,...
          stdFrq5Cdn1, stdFrq5Cdn2, stdFrq5Cdn3};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(15); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/3-1
    plot([3*i+0.5 3*i+0.5], [0 1], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:1:numel(A_sort))
xticklabels({'','wt','','','egl-1','','','ser-1','','','ser-7','','','ser-1;ser-7',''})
xtickangle(0)
ylabel('MAD of frequency (Hz)')
% yticks([0 .5 1 1.5 2])
% yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,360,200])

%% cdf of activity and frequency
kk = 30;
% jitterAmount = 0.10;
ActavgAll = movmean(cat(1, Act1Cdn1, Act1Cdn2, Act1Cdn3), kk, 2);
FrqavgAll = movmean(cat(1, Frq1Cdn1, Frq1Cdn2, Frq1Cdn3), kk, 2);
load('Frq_groundtruth.mat', 'FrqgtAll');
% FrqgtAll  = FrqavgAll + (FrqavgAll/2+0.4).*jitterAmount .* (randn(size(FrqavgAll)) - 0.5);
% FrqgtAll(FrqgtAll<=0)=0;
TAll = repmat(1:size(ActavgAll,2), [size(ActavgAll,1) 1]);
TAll = TAll(:, floor(linspace(1,NumT,floor(NumT/kk))));
% FrqgtAll  = FrqgtAll(:,  floor(linspace(1,NumT,floor(NumT/kk))));
ActavgAll = ActavgAll(:, floor(linspace(1,NumT,floor(NumT/kk))));
FrqavgAll = FrqavgAll(:, floor(linspace(1,NumT,floor(NumT/kk))));
% mx_cmp = distinguishable_colors(numel(unique(FrqgtAll(:))));
figure(15); clf
scatter(FrqavgAll(:), ActavgAll(:), 6, FrqgtAll(:), 'filled')
% cmap_redblue(0.7)
% colormap(cmap_redblue(0.7))
colormap('Turbo')
ylabel('Activity (A.U.)')
xlabel('Frequency (Hz)')
set(gca, 'FontSize', 6)
% xlim([0, max(ActavgAll(:))])
% ylim([0, max(FrqavgAll(:))])
set(gcf, 'Position', [58,683,240,200])
RMSE = sqrt(mean((FrqgtAll(:) - FrqavgAll(:)).^2));
R2   = 1 - sum((FrqgtAll(:) - FrqavgAll(:)).^2)/sum((FrqgtAll(:) - mean(FrqgtAll(:))).^2);

figure(16); clf
hold on
nbins = 100;
% [fact,xiact] = ksdensity(ActAll/max(ActAll), 'Kernel','box'); 
% plot(xiact,fact);
% [ffrq,xifrq] = ksdensity(FrqAll/max(FrqAll), 'Kernel','box'); 
% plot(xifrq,ffrq);
ecdf(ActavgAll(:)/max(ActavgAll(:)),'Bounds','off')
ecdf(FrqavgAll(:)/max(FrqavgAll(:)),'Bounds','off')
% histogram(ActavgAll/max(ActavgAll), nbins)
% histogram(FrqavgAll/max(FrqavgAll), nbins)
hold off
% xlim([0 0.1])
xlabel('Normalized value')
ylabel('cdf')
legend({'Activity', 'Frequency'}, 'Location', 'best')
set(gcf, 'Position', [58,683,270,250])

%% Frequency of group wild-type, ser-1, egl-1 worms in 0, 13mM 5-HT
CC = linspecer(3);
kk = 5;
Frq1AvgCdn1 = movmean(mean(Frq1Cdn1, 1), kk, 2);
Frq2AvgCdn1 = movmean(mean(Frq2Cdn1, 1), kk, 2);
Frq3AvgCdn1 = movmean(mean(Frq3Cdn1, 1), kk, 2);
Frq1AvgCdn3 = movmean(mean(Frq1Cdn3, 1), kk, 2);
Frq2AvgCdn3 = movmean(mean(Frq2Cdn3, 1), kk, 2);
Frq3AvgCdn3 = movmean(mean(Frq3Cdn3, 1), kk, 2);
figure(19); clf; hold on
plot(T, Frq1AvgCdn1, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Frq2AvgCdn1, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Frq3AvgCdn1, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '-')
% plot(T, Frq4AvgCdn1, 'Color', CC(4,:), "LineWidth", 1, 'LineStyle', '-')
% plot(T, Frq5AvgCdn1, 'Color', CC(5,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Frq1AvgCdn3, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Frq2AvgCdn3, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Frq3AvgCdn3, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '--')
% plot(T, Frq4AvgCdn3, 'Color', CC(4,:), "LineWidth", 1, 'LineStyle', '--')
% plot(T, Frq5AvgCdn3, 'Color', CC(5,:), "LineWidth", 1, 'LineStyle', '--')
hold off
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
ylabel('Frequency (Hz)')
set(gca, 'FontSize', 6)
% leg = legend({'0 mM' '13 mM'}, 'Location','northeast');
% title(leg,'5-HT conc.')
set(gcf, "Position", [418,434,300,200])

%% Egg number of group wild-type, ser-1, egl-1 worms in 0, 13mM 5-HT
CC = linspecer(3);
kk = 1;
Egg1AvgCdn1 = movmean(mean(cumsum(Egg1Cdn1,2), 1), kk, 2);
Egg2AvgCdn1 = movmean(mean(cumsum(Egg2Cdn1,2), 1), kk, 2);
Egg3AvgCdn1 = movmean(mean(cumsum(Egg3Cdn1,2), 1), kk, 2);
Egg1AvgCdn3 = movmean(mean(cumsum(Egg1Cdn3,2), 1), kk, 2);
Egg2AvgCdn3 = movmean(mean(cumsum(Egg2Cdn3,2), 1), kk, 2);
Egg3AvgCdn3 = movmean(mean(cumsum(Egg3Cdn3,2), 1), kk, 2);
figure(20); clf; hold on
plot(T, Egg1AvgCdn1, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Egg2AvgCdn1, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Egg3AvgCdn1, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Egg1AvgCdn3, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Egg2AvgCdn3, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Egg3AvgCdn3, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '--')
hold off
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
ylabel('Cumulative egg number')
set(gca, 'FontSize', 6)
% leg = legend({'0 mM' '13 mM'}, 'Location','northeast');
% title(leg,'5-HT conc.')
set(gcf, "Position", [418,434,300,200])

%% Auto vs ground-truth scatter plot for frequency
Gt  = FrqgtAll(:);
Prd = FrqavgAll(:);
R = corrcoef(Gt, Prd);
RMSE = sqrt(mean((Gt - Prd).^2));
R2   = 1 - sum((Gt - Prd).^2)/sum((Gt - mean(Gt)).^2);
figure(21);clf; hold on
scatter(Gt, Prd, 3, 'k', 'filled')
plot([min(Gt), max(Gt)], [min(Gt), max(Gt)], '-r', 'LineWidth', 1); % y=x line
xticks([0 0.5 1 1.5 2])
yticks([0 0.5 1 1.5 2])
% Annotate the plot with the RMSE and R-squared values
% text(1.3, .4, sprintf('RMSE: %.3f\nR^2: %.3f', RMSE, R2), 'FontSize', 6)
text(1.3, .4, sprintf('R: %.3f', R(2,1)), 'FontSize', 6)
ylabel('Predicted frequency (Hz)')
xlabel('Ground truth frequency (Hz)')
set(gca, 'FontSize', 6, 'FontName', 'Arial')
% xlim([0, max(ActavgAll(:))])
% ylim([0, max(FrqavgAll(:))])
set(gcf, 'Position', [58,683,175,145])

%% Activity vs ground-truth scatter plot for frequency
Gt  = FrqgtAll(:);
Act = ActavgAll(:);
K = Gt\Act;
Act = Act/K;
R = corrcoef(Gt, Act);
RMSE = sqrt(mean((Gt - Act).^2));
R2   = 1 - sum((Gt - Act).^2)/sum((Gt - mean(Gt)).^2);
figure(22);clf; hold on
scatter(Gt, Act, 3, 'k', 'filled')
plot([min(Gt), max(Gt)], [min(Gt), max(Gt)], '-r', 'LineWidth', 1); % y=x line
xticks([0 0.5 1 1.5 2])
yticks([0 0.5 1 1.5 2])
% Annotate the plot with the RMSE and R-squared values
% text(1.3, .4, sprintf('RMSE: %.3f\nR^2: %.3f', RMSE, R2), 'FontSize', 6)
text(1.3, .4, sprintf('R: %.3f', R(2,1)), 'FontSize', 6)
ylabel('Activity/k')
xlabel('Ground truth frequency (Hz)')
set(gca, 'FontSize', 6, 'FontName', 'Arial')
% xlim([0, max(ActavgAll(:))])
% ylim([0, max(FrqavgAll(:))])
set(gcf, 'Position', [58,683,175,145])
%% Representative trace of activity
% Use behavior of a wild type in liquid NGM
WormID = 22; % For Cdn1, ID=22; Cdn2, ID=7
Act1Cdn1_trace = Act1Cdn1(WormID, :);
Frq1Cdn1_trace = Frq1Cdn1(WormID, :); fMax = max(Frq1Cdn1_trace);
NormAct1Cdn1_trace = Act1Cdn1_trace./mean(prctile(Act1Cdn1_trace, [95 100]));
NumT = numel(NormAct1Cdn1_trace);
T = (0: (NumT-1))/30; % unit: hr
numColors = 256;
colorMap = turbo(numColors);
figure(28); clf; hold on
% plot(T, NormAct1Cdn1_trace, '-k', 'LineWidth', 1);
% patch([T nan], [NormAct1Cdn1_trace nan], [Frq1Cdn1_trace nan], 'EdgeColor', 'interp');
for k = 1:NumT-1
    fAvg  = (Frq1Cdn1_trace(k)+Frq1Cdn1_trace(k+1))/2;
    idxC  = ceil((fAvg+0.01)/(fMax+0.01)*numColors);
    C2use = colorMap(idxC, :);
    plot([T(k),T(k+1)], [NormAct1Cdn1_trace(k), NormAct1Cdn1_trace(k+1)], '-', 'Color',C2use,'LineWidth',1);
end
hold on
% colorbar;colormap(turbo); clim([0 2.5])
plot(T, 0.3*ones(size(T)), '--r', 'LineWidth', 1)
xlabel('Time (hr)')
ylabel('Normalized activity')
yticks([0 0.5 1])
yticklabels({'0.0', '0.5', '1.0'})
% ylim([0 1])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [471,754,250,100])

%% Representative trace of cumulative egg number
% Use behavior of a wild type in liquid NGM
WormID = 20; % For Cdn1, ID=22; Cdn2, ID=7
CumEgg1Cdn1_trace = Egg1Cdn1(WormID, :)*2;
CumEgg1Cdn2_trace = Egg1Cdn2(WormID, :)*2;

CumEgg1Cdn1_trace(:,1) = 0;
CumEgg1Cdn2_trace(:,1) = 0;
CumEgg1Cdn1_trace = cumsum(CumEgg1Cdn1_trace,2);
CumEgg1Cdn2_trace = cumsum(CumEgg1Cdn2_trace,2);
T = (0: (NumT-1))/30; % unit: hr
currcumEgg1 = CumEgg1Cdn1_trace;
currcumEgg2 = CumEgg1Cdn2_trace;
currmidEgg1 = repmat(currcumEgg1(end)/2, [1 NumT]);
currmidEgg2 = repmat(currcumEgg2(end)/2, [1 NumT]);
vcumEgg1 = [T; currcumEgg1];
vmidEgg1 = [T; currmidEgg1];
vcumEgg2 = [T; currcumEgg2];
vmidEgg2 = [T; currmidEgg2];
currP1 = InterX(vcumEgg1, vmidEgg1);
currP2 = InterX(vcumEgg2, vmidEgg2);

figure(29); clf; hold on
plot(T, currcumEgg1, '-', 'LineWidth', 1, 'Color',0.3*[1 1 1])
plot(T, currcumEgg2, '-', 'LineWidth', 1, 'Color','k')
plot(currP1(1), currP1(2), '*r')
plot(currP2(1), currP2(2), '*r')
hold on

xlabel('Time (hr)')
ylabel('Cumulative egg number')
legend({'Worm 1', 'Worm 2'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [471,754,250,100])

%% Locomotion activity of individuals
ActThres = 0;
currAct1Cdn1 = Act1Cdn1;
currAct1Cdn2 = Act1Cdn2;
currAct1Cdn3 = Act1Cdn3;
currAct2Cdn1 = Act2Cdn1;
currAct2Cdn2 = Act2Cdn2;
currAct2Cdn3 = Act2Cdn3;
currAct3Cdn1 = Act3Cdn1;
currAct3Cdn2 = Act3Cdn2;
currAct3Cdn3 = Act3Cdn3;
currAct4Cdn1 = Act4Cdn1;
currAct4Cdn2 = Act4Cdn2;
currAct4Cdn3 = Act4Cdn3;
currAct5Cdn1 = Act5Cdn1;
currAct5Cdn2 = Act5Cdn2;
currAct5Cdn3 = Act5Cdn3;
NumT = size(currAct1Cdn1, 2);
NumWorm = size(currAct1Cdn1, 1);

MeanAct1Cdn1 = mean(currAct1Cdn1, 2);
MeanAct1Cdn2 = mean(currAct1Cdn2, 2);
MeanAct1Cdn3 = mean(currAct1Cdn3, 2);
MeanAct2Cdn1 = mean(currAct2Cdn1, 2);
MeanAct2Cdn2 = mean(currAct2Cdn2, 2);
MeanAct2Cdn3 = mean(currAct2Cdn3, 2);
MeanAct3Cdn1 = mean(currAct3Cdn1, 2);
MeanAct3Cdn2 = mean(currAct3Cdn2, 2);
MeanAct3Cdn3 = mean(currAct3Cdn3, 2);
MeanAct4Cdn1 = mean(currAct4Cdn1, 2);
MeanAct4Cdn2 = mean(currAct4Cdn2, 2);
MeanAct4Cdn3 = mean(currAct4Cdn3, 2);
MeanAct5Cdn1 = mean(currAct5Cdn1, 2);
MeanAct5Cdn2 = mean(currAct5Cdn2, 2);
MeanAct5Cdn3 = mean(currAct5Cdn3, 2);

NormAct1Cdn1 = currAct1Cdn1./repmat(mean(prctile(currAct1Cdn1, [95 100], 2),2), [1 NumT]);
NormAct1Cdn2 = currAct1Cdn2./repmat(mean(prctile(currAct1Cdn2, [95 100], 2),2), [1 NumT]);
NormAct1Cdn3 = currAct1Cdn3./repmat(mean(prctile(currAct1Cdn3, [95 100], 2),2), [1 NumT]);
NormAct2Cdn1 = currAct2Cdn1./repmat(mean(prctile(currAct2Cdn1, [95 100], 2),2), [1 NumT]);
NormAct2Cdn2 = currAct2Cdn2./repmat(mean(prctile(currAct2Cdn2, [95 100], 2),2), [1 NumT]);
NormAct2Cdn3 = currAct2Cdn3./repmat(mean(prctile(currAct2Cdn3, [95 100], 2),2), [1 NumT]);
NormAct3Cdn1 = currAct3Cdn1./repmat(mean(prctile(currAct3Cdn1, [95 100], 2),2), [1 NumT]);
NormAct3Cdn2 = currAct3Cdn2./repmat(mean(prctile(currAct3Cdn2, [95 100], 2),2), [1 NumT]);
NormAct3Cdn3 = currAct3Cdn3./repmat(mean(prctile(currAct3Cdn3, [95 100], 2),2), [1 NumT]);
NormAct4Cdn1 = currAct4Cdn1./repmat(mean(prctile(currAct4Cdn1, [95 100], 2),2), [1 NumT]);
NormAct4Cdn2 = currAct4Cdn2./repmat(mean(prctile(currAct4Cdn2, [95 100], 2),2), [1 NumT]);
NormAct4Cdn3 = currAct4Cdn3./repmat(mean(prctile(currAct4Cdn3, [95 100], 2),2), [1 NumT]);
NormAct5Cdn1 = currAct5Cdn1./repmat(mean(prctile(currAct5Cdn1, [95 100], 2),2), [1 NumT]);
NormAct5Cdn2 = currAct5Cdn2./repmat(mean(prctile(currAct5Cdn2, [95 100], 2),2), [1 NumT]);
NormAct5Cdn3 = currAct5Cdn3./repmat(mean(prctile(currAct5Cdn3, [95 100], 2),2), [1 NumT]);

activeFra1Cdn1 = mean(NormAct1Cdn1>ActThres, 2);
activeFra1Cdn2 = mean(NormAct1Cdn2>ActThres, 2);
activeFra1Cdn3 = mean(NormAct1Cdn3>ActThres, 2);
activeFra2Cdn1 = mean(NormAct2Cdn1>ActThres, 2);
activeFra2Cdn2 = mean(NormAct2Cdn2>ActThres, 2);
activeFra2Cdn3 = mean(NormAct2Cdn3>ActThres, 2);
activeFra3Cdn1 = mean(NormAct3Cdn1>ActThres, 2);
activeFra3Cdn2 = mean(NormAct3Cdn2>ActThres, 2);
activeFra3Cdn3 = mean(NormAct3Cdn3>ActThres, 2);
activeFra4Cdn1 = mean(NormAct4Cdn1>ActThres, 2);
activeFra4Cdn2 = mean(NormAct4Cdn2>ActThres, 2);
activeFra4Cdn3 = mean(NormAct4Cdn3>ActThres, 2);
activeFra5Cdn1 = mean(NormAct5Cdn1>ActThres, 2);
activeFra5Cdn2 = mean(NormAct5Cdn2>ActThres, 2);
activeFra5Cdn3 = mean(NormAct5Cdn3>ActThres, 2);

A_sort = {MeanAct1Cdn1, MeanAct1Cdn2, MeanAct2Cdn1, MeanAct2Cdn2, MeanAct3Cdn1, MeanAct3Cdn2, MeanAct4Cdn1, MeanAct4Cdn2, MeanAct5Cdn1, MeanAct5Cdn2};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(30); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 1000], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Locomotion activity (A.U.)')
% yticks([0 .5 1])
% yticklabels({'0.0', '0.5', '1.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,250,200])

[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})

%% Active fraction of individuals
A_sort = {activeFra1Cdn1, activeFra1Cdn2, activeFra2Cdn1, activeFra2Cdn2, activeFra3Cdn1, activeFra3Cdn2, activeFra4Cdn1, activeFra4Cdn2, activeFra5Cdn1, activeFra5Cdn2};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(31); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 1], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Active state fraction')
yticks([0 .5 1])
yticklabels({'0.0', '0.5', '1.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,250,200])

[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})

%% Frequency during active states
currFrq1Cdn1 = Frq1Cdn1; currFrq1Cdn1(NormAct1Cdn1<=ActThres) = NaN;
currFrq1Cdn2 = Frq1Cdn2; currFrq1Cdn2(NormAct1Cdn2<=ActThres) = NaN;
currFrq1Cdn3 = Frq1Cdn3; currFrq1Cdn3(NormAct1Cdn3<=ActThres) = NaN;
currFrq2Cdn1 = Frq2Cdn1; currFrq2Cdn1(NormAct2Cdn1<=ActThres) = NaN;
currFrq2Cdn2 = Frq2Cdn2; currFrq2Cdn2(NormAct2Cdn2<=ActThres) = NaN;
currFrq2Cdn3 = Frq2Cdn3; currFrq2Cdn3(NormAct2Cdn3<=ActThres) = NaN;
currFrq3Cdn1 = Frq3Cdn1; currFrq3Cdn1(NormAct3Cdn1<=ActThres) = NaN;
currFrq3Cdn2 = Frq3Cdn2; currFrq3Cdn2(NormAct3Cdn2<=ActThres) = NaN;
currFrq3Cdn3 = Frq3Cdn3; currFrq3Cdn3(NormAct3Cdn3<=ActThres) = NaN;
currFrq4Cdn1 = Frq4Cdn1; currFrq4Cdn1(NormAct4Cdn1<=ActThres) = NaN;
currFrq4Cdn2 = Frq4Cdn2; currFrq4Cdn2(NormAct4Cdn2<=ActThres) = NaN;
currFrq4Cdn3 = Frq4Cdn3; currFrq4Cdn3(NormAct4Cdn3<=ActThres) = NaN;
currFrq5Cdn1 = Frq5Cdn1; currFrq5Cdn1(NormAct5Cdn1<=ActThres) = NaN;
currFrq5Cdn2 = Frq5Cdn2; currFrq5Cdn2(NormAct5Cdn2<=ActThres) = NaN;
currFrq5Cdn3 = Frq5Cdn3; currFrq5Cdn3(NormAct5Cdn3<=ActThres) = NaN;

activeFrq1Cdn1 = mean(currFrq1Cdn1, 2, 'omitnan');
activeFrq1Cdn2 = mean(currFrq1Cdn2, 2, 'omitnan');
activeFrq1Cdn3 = mean(currFrq1Cdn3, 2, 'omitnan');
activeFrq2Cdn1 = mean(currFrq2Cdn1, 2, 'omitnan');
activeFrq2Cdn2 = mean(currFrq2Cdn2, 2, 'omitnan');
activeFrq2Cdn3 = mean(currFrq2Cdn3, 2, 'omitnan');
activeFrq3Cdn1 = mean(currFrq3Cdn1, 2, 'omitnan');
activeFrq3Cdn2 = mean(currFrq3Cdn2, 2, 'omitnan');
activeFrq3Cdn3 = mean(currFrq3Cdn3, 2, 'omitnan');
activeFrq4Cdn1 = mean(currFrq4Cdn1, 2, 'omitnan');
activeFrq4Cdn2 = mean(currFrq4Cdn2, 2, 'omitnan');
activeFrq4Cdn3 = mean(currFrq4Cdn3, 2, 'omitnan');
activeFrq5Cdn1 = mean(currFrq5Cdn1, 2, 'omitnan');
activeFrq5Cdn2 = mean(currFrq5Cdn2, 2, 'omitnan');
activeFrq5Cdn3 = mean(currFrq5Cdn3, 2, 'omitnan');

A_sort = {activeFrq1Cdn1, activeFrq1Cdn2, activeFrq1Cdn3,...
          activeFrq2Cdn1, activeFrq2Cdn2, activeFrq2Cdn3,...
          activeFrq3Cdn1, activeFrq3Cdn2, activeFrq3Cdn3,...
          activeFrq4Cdn1, activeFrq4Cdn2, activeFrq4Cdn3,...
          activeFrq5Cdn1, activeFrq5Cdn2, activeFrq5Cdn3};
% Beeswarm plot
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(32); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','sd','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/3-1
    plot([3*i+0.5 3*i+0.5], [0 2], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:1:numel(A_sort))
xticklabels({'','wt','','','egl-1','','','ser-1','','','ser-7','','','ser-1;ser-7',''})
xtickangle(0)
ylabel('Mean active frequency (Hz)')
yticks([0 .5 1 1.5 2])
yticklabels({'0.0', '0.5', '1.0', '1.5', '2.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,300,200])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})

%% Cumulative egg number half time analysis
currEgg1Cdn1 = Egg1Cdn1*2;
currEgg1Cdn2 = Egg1Cdn2*2;
currEgg2Cdn1 = Egg2Cdn1*2;
currEgg2Cdn2 = Egg2Cdn2*2;
currEgg3Cdn1 = Egg3Cdn1*2;
currEgg3Cdn2 = Egg3Cdn2*2;
currEgg4Cdn1 = Egg4Cdn1*2;
currEgg4Cdn2 = Egg4Cdn2*2;
currEgg5Cdn1 = Egg5Cdn1*2;
currEgg5Cdn2 = Egg5Cdn2*2;

CumEgg1Cdn1 = currEgg1Cdn1;
CumEgg1Cdn2 = currEgg1Cdn2;
CumEgg2Cdn1 = currEgg2Cdn1;
CumEgg2Cdn2 = currEgg2Cdn2;
CumEgg3Cdn1 = currEgg3Cdn1;
CumEgg3Cdn2 = currEgg3Cdn2;
CumEgg4Cdn1 = currEgg4Cdn1;
CumEgg4Cdn2 = currEgg4Cdn2;
CumEgg5Cdn1 = currEgg5Cdn1;
CumEgg5Cdn2 = currEgg5Cdn2;

CumEgg1Cdn1(:,1) = 0;
CumEgg1Cdn2(:,1) = 0;
CumEgg2Cdn1(:,1) = 0;
CumEgg2Cdn2(:,1) = 0;
CumEgg3Cdn1(:,1) = 0;
CumEgg3Cdn2(:,1) = 0;
CumEgg4Cdn1(:,1) = 0;
CumEgg4Cdn2(:,1) = 0;
CumEgg5Cdn1(:,1) = 0;
CumEgg5Cdn2(:,1) = 0;

CumEgg1Cdn1 = cumsum(CumEgg1Cdn1,2);
CumEgg1Cdn2 = cumsum(CumEgg1Cdn2,2);
CumEgg2Cdn1 = cumsum(CumEgg2Cdn1,2);
CumEgg2Cdn2 = cumsum(CumEgg2Cdn2,2);
CumEgg3Cdn1 = cumsum(CumEgg3Cdn1,2);
CumEgg3Cdn2 = cumsum(CumEgg3Cdn2,2);
CumEgg4Cdn1 = cumsum(CumEgg4Cdn1,2);
CumEgg4Cdn2 = cumsum(CumEgg4Cdn2,2);
CumEgg5Cdn1 = cumsum(CumEgg5Cdn1,2);
CumEgg5Cdn2 = cumsum(CumEgg5Cdn2,2);

[Tmid1Cdn1, Nend1Cdn1] = EggHalftime(CumEgg1Cdn1);
[Tmid1Cdn2, Nend1Cdn2] = EggHalftime(CumEgg1Cdn2);
[Tmid2Cdn1, Nend2Cdn1] = EggHalftime(CumEgg2Cdn1);
[Tmid2Cdn2, Nend2Cdn2] = EggHalftime(CumEgg2Cdn2);
[Tmid3Cdn1, Nend3Cdn1] = EggHalftime(CumEgg3Cdn1);
[Tmid3Cdn2, Nend3Cdn2] = EggHalftime(CumEgg3Cdn2);
[Tmid4Cdn1, Nend4Cdn1] = EggHalftime(CumEgg4Cdn1);
[Tmid4Cdn2, Nend4Cdn2] = EggHalftime(CumEgg4Cdn2);
[Tmid5Cdn1, Nend5Cdn1] = EggHalftime(CumEgg5Cdn1);
[Tmid5Cdn2, Nend5Cdn2] = EggHalftime(CumEgg5Cdn2);

A_sort = {Tmid1Cdn1, Tmid1Cdn2, Tmid2Cdn1, Tmid2Cdn2, Tmid3Cdn1, Tmid3Cdn2, Tmid4Cdn1, Tmid4Cdn2, Tmid5Cdn1, Tmid5Cdn2};
% A_mean = nan(1, numel(A_sort));
% Beeswarm plot of half time
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
%     A_mean(i) = mean(A_sort{i}, 'omitnan');
end
figure(33); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
% errorbar(1:numel(A_sort), A_mean, zeros(1, numel(A_sort)), 'LineStyle','none','Color','r','Marker','none')
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 5], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Half time of egg-laying dynamics')
% yticks([0 .5 1])
% yticklabels({'0.0', '0.5', '1.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,250,200])
p1 = ranksum(A_sort{1}, A_sort{2})
p2 = ranksum(A_sort{3}, A_sort{4})
p3 = ranksum(A_sort{5}, A_sort{6})
p4 = ranksum(A_sort{7}, A_sort{8})
p5 = ranksum(A_sort{9}, A_sort{10})

%% Beeswarm plot of egg-laying rate
A_sort = {Nend1Cdn1, Nend1Cdn2, Nend2Cdn1, Nend2Cdn2, Nend3Cdn1, Nend3Cdn2, Nend4Cdn1, Nend4Cdn2, Nend5Cdn1, Nend5Cdn2};
X1 = [];
Y1 = [];
for i = 1 : numel(A_sort)
    X1 = cat(1, X1, i*ones([numel(A_sort{i}) 1]));
end
for i = 1 : numel(A_sort)
    Y1 = cat(1, Y1, A_sort{i});
end
figure(34); clf;
beeswarm(X1, Y1, 'sort_style','up','dot_size',.1,'overlay_style','ci','corral_style','gutter','MarkerFaceAlpha',0.8);
hold on
for i = 1 : numel(A_sort)/2-1
    plot([2*i+0.5 2*i+0.5], [0 8], '-k', 'LineWidth',0.5);
end
hold off
xticks(1:0.5:numel(A_sort))
xticklabels({'','wt','','','','egl-1','','','','ser-1','','','','ser-7','','','','ser-1;ser-7','',''})
xtickangle(0)
ylabel('Egg-laying rate (#/hr)')
yticks(1:8)
% yticklabels({'0.0', '0.5', '1.0'})
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [240,658,250,200])
[~,p1] = ttest2(A_sort{1}, A_sort{2})
[~,p2] = ttest2(A_sort{3}, A_sort{4})
[~,p3] = ttest2(A_sort{5}, A_sort{6})
[~,p4] = ttest2(A_sort{7}, A_sort{8})
[~,p5] = ttest2(A_sort{9}, A_sort{10})
