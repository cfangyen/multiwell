sss = 1;
TT = struct([]);
%%
path_parent = 'C:\Users\fffei\C elegans Team Dropbox\HONGFEI JI\Paper\Egg-laying\Data\Burst MultWell';
path_expt = '2023-09-11 N2-MT14984_5-HT_6cdn';
group1 = 'wt';
group2 = 'tph-1';

cd(fullfile(path_parent, path_expt));
matdir = dir("*_DATA.mat");
load(matdir(1).name)

% Histogram plot
m = 100;
cm_parula=fake_parula(m);
cm_magma=magma(m);
cm_inferno=inferno(m);
cm_plasma=plasma(m);
cm_viridis=viridis(m);
NumT = size(S,1)/8;

S = S(1:NumT, 1);
%% Locomotion activity
ActAll = cat(3, S.ActVal);
Act1_max = ActAll(1:4,1:4,:);  Act1_max = reshape(Act1_max, [16 NumT]);
Act1_haf = ActAll(1:4,5:8,:);  Act1_haf = reshape(Act1_haf, [16 NumT]);
Act1_min = ActAll(1:4,9:12,:); Act1_min = reshape(Act1_min, [16 NumT]);
Act2_max = ActAll(5:8,1:4,:);  Act2_max = reshape(Act2_max, [16 NumT]);
Act2_haf = ActAll(5:8,5:8,:);  Act2_haf = reshape(Act2_haf, [16 NumT]);
Act2_min = ActAll(5:8,9:12,:); Act2_min = reshape(Act2_min, [16 NumT]);

Act1_avg = [mean(Act1_min,'all'), mean(Act1_haf,'all'), mean(Act1_max,'all')];

Act2_avg = [mean(Act2_min,'all'), mean(Act2_haf,'all'), mean(Act2_max,'all')];

Act1_sem = [std(Act1_min,0,'all'), std(Act1_haf,0,'all'), std(Act1_max,0,'all')]./sqrt(16*NumT);

Act2_sem = [std(Act2_min,0,'all'), std(Act2_haf,0,'all'), std(Act2_max,0,'all')]./sqrt(16*NumT);

T = (0:(NumT-1))/30;
% % Representative traces
CC = linspecer(4);
Vact1_min = Act1_min(1,:);
Vact1_haf = Act1_haf(1,:);
Vact1_max = Act1_max(1,:);
figure(1); clf; hold on
plot(T, Vact1_min, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Vact1_haf, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Vact1_max, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '-.')
hold off
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
ylabel('Activity (A.U.)')
set(gca, 'FontSize', 6)
leg = legend({'0 mM', '6.5 mM', '13 mM'}, 'Location','northeastoutside');
title(leg,'5-HT conc.')
set(gcf, "Position", [418,434,600,150])

% % Kymograph
ActAll = cat(1, Act1_min, Act1_haf, Act1_max,...
                Act2_min, Act2_haf, Act2_max);
G = (1:size(ActAll));
figure(2); clf; hold on
imagesc(T, G, ActAll)
plot([T(1), T(end)], [16.5 16.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [48.5 48.5], '-c',  'LineWidth', 2);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [80.5 80.5], '--c', 'LineWidth', 1);
hold off
colormap(cm_inferno)
title(sprintf('Activity %s vs %s', group1, group2))
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
yyaxis left
ylabel('5HT concentration (mM)')
yticks([8 24 40 56 72 88])
xlim([T(1) T(end)])
ylim([1 96])
yticklabels({sprintf('0'), sprintf('6.5'), sprintf('13'),...
             sprintf('0'), sprintf('6.5'), sprintf('13'), '.'})
set(gca, "YDir", "reverse")
yyaxis right
ylabel('Strain')
yticks([24 72])
ylim([1 96])
yticklabels({group1, group2})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 12, 'Color', 'k')

% % Barplot
figure(3); clf; 
hold on
Y  = [Act1_avg(1,:); Act2_avg(1,:)];
YE = [Act1_sem(1,:); Act2_sem(1,:)];
ngroups = size(Y, 1);
nbars = size(Y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar([Act1_avg(1,:); Act2_avg(1,:)])
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, Y(:,i), YE(:,i), '.');
end
legend({'0 mM 5-HT', '6.5 mM', '13 mM'});
xticks([1 2])
xticklabels({group1 group2})
ylabel('Activity (A.U.)')
set(gca, 'FontSize', 12)
%% Egg-laying behavior
SingleEggArea = 35.187;
EggAll = cat(3, S.EggArea)./SingleEggArea;
Egg1_max = EggAll(1:4,1:4,:);  Egg1_max = reshape(Egg1_max, [16 NumT]); Egg1_max = EggNumMod(Egg1_max);
Egg1_haf = EggAll(1:4,5:8,:);  Egg1_haf = reshape(Egg1_haf, [16 NumT]); Egg1_haf = EggNumMod(Egg1_haf);
Egg1_min = EggAll(1:4,9:12,:); Egg1_min = reshape(Egg1_min, [16 NumT]); Egg1_min = EggNumMod(Egg1_min);
Egg2_max = EggAll(5:8,1:4,:);  Egg2_max = reshape(Egg2_max, [16 NumT]); Egg2_max = EggNumMod(Egg2_max);
Egg2_haf = EggAll(5:8,5:8,:);  Egg2_haf = reshape(Egg2_haf, [16 NumT]); Egg2_haf = EggNumMod(Egg2_haf);
Egg2_min = EggAll(5:8,9:12,:); Egg2_min = reshape(Egg2_min, [16 NumT]); Egg2_min = EggNumMod(Egg2_min);

Egg1_avg = [mean(Egg1_min,'all'), mean(Egg1_haf,'all'), mean(Egg1_max,'all')];

Egg2_avg = [mean(Egg2_min,'all'), mean(Egg2_haf,'all'), mean(Egg2_max,'all')];

Egg1_sem = [std(Egg1_min,0,'all'), std(Egg1_haf,0,'all'), std(Egg1_max,0,'all')]./sqrt(16*NumT);

Egg2_sem = [std(Egg2_min,0,'all'), std(Egg2_haf,0,'all'), std(Egg2_max,0,'all')]./sqrt(16*NumT);

T = (0:(NumT-1))/30;
% % Representative traces
CC = linspecer(3);
Vegg1_min = Egg1_min(1,:);
Vegg1_haf = Egg1_haf(3,:);
Vegg1_max = Egg1_max(3,:);
figure(4); clf; hold on
plot(T, Vegg1_min, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, Vegg1_haf, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, Vegg1_max, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '-.')
hold off
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
ylabel('# eggs')
set(gca, 'FontSize', 6)
leg = legend({'0 mM', '6.5 mM', '13 mM'}, 'Location','northeastoutside');
title(leg,'5-HT conc.')
set(gcf, "Position", [418,434,600,150])

figure(5); clf; 
hold on
Y  = [Egg1_avg(1,:); Egg2_avg(1,:)];
YE = [Egg1_sem(1,:); Egg2_sem(1,:)];
ngroups = size(Y, 1);
nbars = size(Y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar([Egg1_avg(1,:); Egg2_avg(1,:)])
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, Y(:,i), YE(:,i), '.');
end
legend({'0 mM 5-HT', '6.5 mM', '13 mM'});
xticks([1 2])
xticklabels({group1 group2})
ylabel('# Eggs')
set(gca, 'FontSize', 12)


EggAll = cat(1, Egg1_min, Egg1_haf, Egg1_max,...
                Egg2_min, Egg2_haf, Egg2_max);
NumW = size(EggAll, 1);
for i = 1 : NumW
    V = EggAll(i, :);
    for j = 2 : NumT
        if V(j)<V(j-1)
            V(j) = V(j-1);
        end
    end
    EggAll(i, :) = V;
end

EggIncreAll = diff(EggAll, 1,2);
figure(6); clf; hold on
idx20 = EggIncreAll<0;
EggIncreAll(idx20) = 0;
imagesc(T, G, EggIncreAll)
plot([T(1), T(end)], [16.5 16.5], '--r', 'LineWidth', 1);
plot([T(1), T(end)], [32.5 32.5], '--r', 'LineWidth', 1);
plot([T(1), T(end)], [48.5 48.5], '-r', 'LineWidth', 2);
plot([T(1), T(end)], [64.5 64.5], '--r', 'LineWidth', 1);
plot([T(1), T(end)], [80.5 80.5], '--r', 'LineWidth', 1);
colormap(cm_magma)
title(sprintf('Egg increments %s vs %s', group1, group2))
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
yyaxis left
ylabel('5HT concentration (mM)')
yticks([8 24 40 56 72 88])
xlim([T(1) T(end)])
ylim([1 96])
yticklabels({sprintf('0'), sprintf('6.5'), sprintf('13'),...
             sprintf('0'), sprintf('6.5'), sprintf('13'), '.'})
set(gca, "YDir", "reverse")
yyaxis right
ylabel('Strain')
yticks([24 72])
ylim([1 96])
yticklabels({group1, group2})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 12, 'Color', 'k')
%% Frequency Activity
FrqAll = cat(3, S.Freq);
PrdAll = cat(3, S.Periodicity);
Frq1_max = FrqAll(1:4,1:4,:);  Frq1_max = reshape(Frq1_max, [16 NumT]);
Frq1_haf = FrqAll(1:4,5:8,:);  Frq1_haf = reshape(Frq1_haf, [16 NumT]);
Frq1_min = FrqAll(1:4,9:12,:); Frq1_min = reshape(Frq1_min, [16 NumT]);
Frq2_max = FrqAll(5:8,1:4,:);  Frq2_max = reshape(Frq2_max, [16 NumT]);
Frq2_haf = FrqAll(5:8,5:8,:);  Frq2_haf = reshape(Frq2_haf, [16 NumT]);
Frq2_min = FrqAll(5:8,9:12,:); Frq2_min = reshape(Frq2_min, [16 NumT]);
Prd1_max = PrdAll(1:4,1:4,:);  Prd1_max = reshape(Prd1_max, [16 NumT]);  Frq1_max = Frq1_max.*(Prd1_max>.3);
Prd1_haf = PrdAll(1:4,5:8,:);  Prd1_haf = reshape(Prd1_haf, [16 NumT]);  Frq1_haf = Frq1_haf.*(Prd1_haf>.3);
Prd1_min = PrdAll(1:4,9:12,:); Prd1_min = reshape(Prd1_min, [16 NumT]);  Frq1_min = Frq1_min.*(Prd1_min>.3);
Prd2_max = PrdAll(5:8,1:4,:);  Prd2_max = reshape(Prd2_max, [16 NumT]);  Frq2_max = Frq2_max.*(Prd2_max>.3);
Prd2_haf = PrdAll(5:8,5:8,:);  Prd2_haf = reshape(Prd2_haf, [16 NumT]);  Frq2_haf = Frq2_haf.*(Prd2_haf>.3);
Prd2_min = PrdAll(5:8,9:12,:); Prd2_min = reshape(Prd2_min, [16 NumT]);  Frq2_min = Frq2_min.*(Prd2_min>.3);

FrqAll = cat(1, Frq1_min, Frq1_haf, Frq1_max,...
                Frq2_min, Frq2_haf, Frq2_max);

Frq1_avg = [mean(Frq1_min,'all','omitnan'), mean(Frq1_haf,'all','omitnan'), mean(Frq1_max,'all','omitnan')];

Frq2_avg = [mean(Frq2_min,'all','omitnan'), mean(Frq2_haf,'all','omitnan'), mean(Frq2_max,'all','omitnan')];

Frq1_sem = [std(Frq1_min,0,'all','omitnan'), std(Frq1_haf,0,'all','omitnan'), std(Frq1_max,0,'all','omitnan')]./sqrt(16*NumT);

Frq2_sem = [std(Frq2_min,0,'all','omitnan'), std(Frq2_haf,0,'all','omitnan'), std(Frq2_max,0,'all','omitnan')]./sqrt(16*NumT);

T = (0:(NumT-1))/30;
% % Representative traces
CC = linspecer(3);
VFrq1_min = Frq1_min(4,:);
VFrq1_haf = Frq1_haf(4,:);
VFrq1_max = Frq1_max(4,:);
figure(7); clf; hold on
plot(T, VFrq1_min, 'Color', CC(1,:), "LineWidth", 1, 'LineStyle', '-')
plot(T, VFrq1_haf, 'Color', CC(2,:), "LineWidth", 1, 'LineStyle', '--')
plot(T, VFrq1_max, 'Color', CC(3,:), "LineWidth", 1, 'LineStyle', '-.')
hold off
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
ylabel('Frequency (Hz)')
set(gca, 'FontSize', 6)
leg = legend({'0 mM', '6.5 mM', '13 mM'}, 'Location','northeastoutside');
title(leg,'5-HT conc.')
set(gcf, "Position", [418,434,600,150])

figure(8); clf; hold on
imagesc(T, G, FrqAll)
plot([T(1), T(end)], [16.5 16.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [32.5 32.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [48.5 48.5], '-c', 'LineWidth', 2);
plot([T(1), T(end)], [64.5 64.5], '--c', 'LineWidth', 1);
plot([T(1), T(end)], [80.5 80.5], '--c', 'LineWidth', 1);
colormap(cm_plasma)
title(sprintf('Frequency %s vs %s', group1, group2))
xlabel('Time (hr)')
xticks([0 1 2 3 4 5])
yyaxis left
ylabel('5HT concentration (mM)')
yticks([8 24 40 56 72 88])
xlim([T(1) T(end)])
ylim([1 96])
yticklabels({sprintf('0'), sprintf('6.5'), sprintf('13'),...
             sprintf('0'), sprintf('6.5'), sprintf('13'), '.'})
set(gca, "YDir", "reverse")
yyaxis right
ylabel('Strain')
yticks([24 72])
ylim([1 96])
yticklabels({group1, group2})
set(gca, "YDir", "reverse")
set(gca, 'FontSize', 12, 'Color', 'k')

% % Barplot
figure(9); clf; 
hold on
Y  = [Frq1_avg(1,:); Frq2_avg(1,:)];
YE = [Frq1_sem(1,:); Frq2_sem(1,:)];
ngroups = size(Y, 1);
nbars = size(Y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar([Frq1_avg(1,:); Frq2_avg(1,:)])
for i = 1:nbars
    X = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(X, Y(:,i), YE(:,i), '.');
end
legend({'0 mM 5-HT', '6.5 mM', '13 mM'});
xticks([1 2])
xticklabels({group1 group2})
ylabel('Frequency (Hz)')
set(gca, 'FontSize', 12)
%% Store all processed data
for i = 1 : 16
    TT(sss).Condition = [group1 '_min5HT'];
    TT(sss).Activity  = Act1_min(i, :);
    TT(sss).EggNum    = Egg1_min(i, :);
    TT(sss).Frequency = Frq1_min(i, :);
    sss = sss + 1;
    TT(sss).Condition = [group1 '_haf5HT'];
    TT(sss).Activity  = Act1_haf(i, :);
    TT(sss).EggNum    = Egg1_haf(i, :);
    TT(sss).Frequency = Frq1_haf(i, :);
    sss = sss + 1;
    TT(sss).Condition = [group1 '_max5HT'];
    TT(sss).Activity  = Act1_max(i, :);
    TT(sss).EggNum    = Egg1_max(i, :);
    TT(sss).Frequency = Frq1_max(i, :);
    sss = sss + 1;
    TT(sss).Condition = [group2 '_min5HT'];
    TT(sss).Activity  = Act2_min(i, :);
    TT(sss).EggNum    = Egg2_min(i, :);
    TT(sss).Frequency = Frq2_min(i, :);
    sss = sss + 1;
    TT(sss).Condition = [group2 '_haf5HT'];
    TT(sss).Activity  = Act2_haf(i, :);
    TT(sss).EggNum    = Egg2_haf(i, :);
    TT(sss).Frequency = Frq2_haf(i, :);
    sss = sss + 1;
    TT(sss).Condition = [group2 '_max5HT'];
    TT(sss).Activity  = Act2_max(i, :);
    TT(sss).EggNum    = Egg2_max(i, :);
    TT(sss).Frequency = Frq2_max(i, :);
    sss = sss + 1;
end