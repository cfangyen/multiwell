% Run VisualData_5HT_cat before VisualData_5HT_sta
clc; close all
%% Representative trace of activity overlaid with egg-laying events
% Use behavior of a wild type in liquid NGM
WormID = 7; % For Cdn1, ID=22; Cdn2, ID=7
Act1Cdn1_trace = Act1Cdn2(WormID, :);
Egg1Cdn1_trace = Egg1Cdn2(WormID, :);
Egg1Cdn1_trace(Egg1Cdn1_trace==0) = NaN;
Egg1Cdn1_trace = Egg1Cdn1_trace.^.5*50;
NumT = numel(Act1Cdn1_trace);
T = (0: (NumT-1))/30; % unit: hr
EggEvents = ones(size(T));
figure(1); clf; hold on
scatter(T, EggEvents, Egg1Cdn1_trace, 'red', 'filled')
plot(T, Act1Cdn1_trace, '-k', 'LineWidth', 1);
xlabel('Time (hr)')
ylabel('Activity (A.U.)')
legend({'Egg-laying events', 'Representative activity'})
ylim([0 1000])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,754,300,120])

%% Stacked STA of activity (normalized) and egg-laying behavior
CC = linspecer(3);
ActAll = cell(3,1);
EggAll = cell(3,1);
ActAll{1} = Act1Cdn1;
ActAll{2} = Act1Cdn2;
ActAll{3} = Act1Cdn3;
EggAll{1} = Egg1Cdn1;
EggAll{2} = Egg1Cdn2;
EggAll{3} = Egg1Cdn3;
genotype = 'Wild type';
Ratio_expt = [0 1];
winb = 10;
wina = 10;
lenwin = wina+winb-1;
tt = (-winb+1:wina-1)*2;
sta_avg = cell(3, 1);
sta_sem = cell(3, 1);
normsta = cell(3, 1);
a = 0;
for m = 1 : numel(ActAll)
    Actcurr = ActAll{m};
    NumT = size(Actcurr, 2);
    ActAvgcurr = zeros(size(Actcurr, 1), 1);
    Eggcurr = EggAll{m};
    Actcurr = Actcurr(:, round(1+NumT*Ratio_expt(1)):round(NumT*Ratio_expt(2)));
    Eggcurr = Eggcurr(:, round(1+NumT*Ratio_expt(1)):round(NumT*Ratio_expt(2)));
    staAll = [];
    normstaAll = [];
    for i = 1 : size(Actcurr,1)
        stim = Actcurr(i,:);
        ActAvgcurr(i) = mean(stim);
        if i+a>size(Actcurr,1)
            spik = Eggcurr((i+a)-size(Actcurr,1),:);
        else
            spik = Eggcurr(i+a,:);
        end
        sta  = STA(stim, spik, winb, wina);
        stim95 = mean(prctile(stim, [25 75]));
        nmsta = (sta - stim95)./stim95;
        staAll = cat(1, staAll, sta);
        normstaAll = cat(1, normstaAll, nmsta);
    end
    normsta_avg = mean(normstaAll, 1, 'omitnan');
%     normsta_sem = std(normstaAll,0,1, 'omitnan')./sqrt(size(normstaAll,1));
    normsta_sem = std(normstaAll,0,1, 'omitnan')./sqrt(size(Actcurr,1));
    normsta{m}  = normstaAll;
    sta_avg{m}  = normsta_avg;
    sta_sem{m}  = normsta_sem;
    % sta_avg_abs = mean(staAll, 1, 'omitnan');
    % sta_normfactor = sta_avg_abs(1);
    % sta_normfactor = frq_avg;
    % sta_avg{m} = (sta_avg_abs-sta_normfactor)./sta_normfactor;
    % sta_sem{m} = std(staAll,0,1, 'omitnan')./sqrt(size(staAll,1))./sta_normfactor;
end
figure(2); clf; hold on
currnormsta = normsta{2};
currsta_avg = sta_avg{2};
currsta_sem = sta_sem{2};
selectedsta = currnormsta(randi(size(currnormsta,1),[1 20]), :);
plot(tt, currsta_avg, 'Color', CC(1,:),'LineWidth',2)
plot(tt, selectedsta, 'Color', 0.5*[1 1 1], 'LineStyle',':','LineWidth',1)
% plot(tt, sta_avg{2}, 'Color', CC(2,:),'LineWidth',2)
% plot(tt, sta_avg{3}, 'Color', CC(3,:),'LineWidth',2)
shadedErrorBar(tt, currsta_avg, currsta_sem,'-k',0, CC(1,:));
plot([0 0], [-0.8 0.4], 'Color', 'r','LineWidth',1, 'LineStyle','--')
% shadedErrorBar(tt, sta_avg{2}, sta_sem{2},'-k',0, CC(2,:));
% shadedErrorBar(tt, sta_avg{3}, sta_sem{3},'-k',0.2, CC(3,:));
% legend({'0 mM','6.5 mM'}, 'Location', 'southeast', 'Box', 'off')
xlim([-16 16])
ylim([-0.6 0.3])
xlabel('Time (min)')
ylabel('Activity change, DAct/Act')
title(sprintf(genotype))
hold off
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,754,270,210])
%% Conditional probability of egg-laying rate given locomotory state
Actcurr = Act4Cdn2;
Eggcurr = Egg4Cdn2*2;
NumWorm = size(Actcurr, 1);
NumT = size(Actcurr, 2);
NormAct = Actcurr./repmat(mean(prctile(Actcurr, [95 100], 2),2), [1 NumT]);
Nbin_eggrate = 2;
mNbin_eggrate = 20;
mEdge_eggrate = linspace(0, 2.5, mNbin_eggrate);
edge_eggrate = [0 .3 Inf];
midv_eggrate = [0.5, 1.5];
widbin_eggrate = 1;
% edge_eggrate = linspace(0, 3, Nbin_eggrate+1);
% midv_eggrate = mean(cat(1, edge_eggrate(1:end-1), edge_eggrate(2:end)),1);
% widbin_eggrate = mean(diff(midv_eggrate));
ActThres = 0.3; % 0.3
P_sedent = nan(NumWorm, 1);
P_active = nan(NumWorm, 1);
P_egg = nan(NumWorm, Nbin_eggrate);
P_noegg = nan(NumWorm, 1);
P_eggGsed = nan(NumWorm, Nbin_eggrate);
P_eggGact = nan(NumWorm, Nbin_eggrate);
mP_eggGsed = nan(NumWorm, mNbin_eggrate);
mP_eggGact = nan(NumWorm, mNbin_eggrate);
eggGsedAll = [];
eggGactAll = [];
P_sedGegg = nan(NumWorm, Nbin_eggrate);
P_actGegg = nan(NumWorm, Nbin_eggrate);
E_eggnumPsed = nan(NumWorm, 1); % Expectation of egglaying rate (#/hr) contributed during sedentary state
E_eggnumPact = nan(NumWorm, 1); % Expectation of egglaying rate (#/hr) contributed during active state
E_eggnumGsed = nan(NumWorm, 1); % Expectation of egglaying rate (#/hr) given sedentary state
E_eggnumGact = nan(NumWorm, 1); % Expectation of egglaying rate (#/hr) given active state
E_eggGsedegg = nan(NumWorm, Nbin_eggrate); % Expectation of egg-laying rate (#/hr) given sedentary state and egg-laying rate
E_eggGactegg = nan(NumWorm, Nbin_eggrate); % Expectation of egg-laying rate (#/hr) given active state and egg-laying rate
for i = 1:NumWorm
    currAct = NormAct(i, :);
    currEgg = Eggcurr(i, :);
    idx_sedent = currAct<=ActThres&currEgg~=0;
    idx_active = currAct> ActThres&currEgg~=0;
    idx_sparse = currEgg< edge_eggrate(2);
    idx_clster = currEgg>=edge_eggrate(2);
    currP_sedent = sum(idx_sedent)./NumT/(sum(currEgg~=0)/NumT);
    currP_active = sum(idx_active)./NumT/(sum(currEgg~=0)/NumT);
    currP_sparse = sum(idx_sparse)./NumT/(sum(currEgg~=0)/NumT);
    currP_clster = sum(idx_clster)./NumT/(sum(currEgg~=0)/NumT);
    currP_noegg  = sum(currEgg==0)/NumT;
    eggGsed = currEgg(idx_sedent);
    eggGact = currEgg(idx_active);
    eggGsedAll = cat(2, eggGsedAll, eggGsed);
    eggGactAll = cat(2, eggGactAll, eggGact);
    figure(3);
    hcurrP_egg = histogram(currEgg(currEgg~=0), edge_eggrate, 'Normalization', 'probability', 'Visible','off');
    currP_egg = (hcurrP_egg.Values)*(1-currP_noegg); currP_egg(isnan(currP_egg)) = 0;
    figure(3);
    hcurrP_eggGsed = histogram(eggGsed, edge_eggrate, 'Normalization', 'probability', 'Visible','off');
    currP_eggGsed = hcurrP_eggGsed.Values*(1-currP_noegg); currP_eggGsed(isnan(currP_eggGsed)) = 0;
    figure(3);
    hcurrP_eggGact = histogram(eggGact, edge_eggrate, 'Normalization', 'probability', 'Visible','off');
    currP_eggGact = hcurrP_eggGact.Values*(1-currP_noegg); currP_eggGact(isnan(currP_eggGact)) = 0;
    currP_sedGegg = currP_eggGsed.*currP_sedent./currP_egg;
    currP_actGegg = currP_eggGact.*currP_active./currP_egg;
    % Expectation of egg-laying rate contribution conditioned by locomotory state
    currE_eggPsed = sum(currEgg(idx_sedent))/5;
    currE_eggPact = sum(currEgg(idx_active))/5;
    % Conditional expectation of egg-laying rate given locomotory state
    currE_eggGsed = currE_eggPsed./currP_sedent;
    currE_eggGact = currE_eggPact./currP_active;
    % Conditional expectation of egg-laying rate given locomotory state and egg-laying rate
    currE_eggGsedegg = [sum(currEgg(idx_sedent&idx_sparse))./5./(currP_sedGegg(1)*currP_sparse),...
                        sum(currEgg(idx_sedent&idx_clster))./5./(currP_sedGegg(1)*currP_clster)];
    currE_eggGactegg = [sum(currEgg(idx_active&idx_sparse))./5./(currP_actGegg(2)*currP_sparse),...
                        sum(currEgg(idx_active&idx_clster))./5./(currP_actGegg(2)*currP_clster)];
    P_sedent(i) = currP_sedent;
    P_active(i) = currP_active;
    P_egg(i, :) = currP_egg;
    P_eggGsed(i, :) = currP_eggGsed;
    P_eggGact(i, :) = currP_eggGact;
    P_sedGegg(i, :) = currP_sedGegg;
    P_actGegg(i, :) = currP_actGegg;
    E_eggnumPsed(i, :) = currE_eggPsed;
    E_eggnumPact(i, :) = currE_eggPact;
    E_eggnumGsed(i, :) = currE_eggGsed;
    E_eggnumGact(i, :) = currE_eggGact;
    E_eggGsedegg(i, :) = currE_eggGsedegg;
    E_eggGactegg(i, :) = currE_eggGactegg;
end
% % Probability of sedentary and active states
AVG_P_sedent = mean(P_sedent, 'omitnan');
SEM_P_sedent = std(P_sedent, 'omitnan')./sqrt(NumWorm);
AVG_P_active = mean(P_active, 'omitnan');
SEM_P_active = std(P_active, 'omitnan')./sqrt(NumWorm);
AVG_P_states = [AVG_P_sedent AVG_P_active];
SEM_P_states = [SEM_P_sedent SEM_P_active];

figure(3); clf;
pie(AVG_P_states)
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,629,120,100])
% figure(3); clf; hold on
% bar([1 2], AVG_P_states, 'LineStyle', 'none', 'EdgeColor', 'none')
% errorbar([1 2], AVG_P_states, SEM_P_states, 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
% xticks([1 2])
% xticklabels({'Sedentary', 'Active'})
% xlabel('State')
% ylabel('State Probility')
% ylim([0 1])
% set(gca, 'FontSize', 6, 'FontName', 'Arial')
% set(gcf, 'Position', [295,529,320,240])

% % Probility of egg-laying rate
AVG_P_egg = mean(P_egg, 1, 'omitnan');
SEM_P_egg = std(P_egg, 0, 1, 'omitnan')./sqrt(NumWorm);
figure(4); clf; hold on
bar(midv_eggrate, AVG_P_egg, 'LineStyle', 'none', 'EdgeColor', 'none')
errorbar(midv_eggrate, AVG_P_egg, SEM_P_egg, 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
xticks(midv_eggrate)
xlabel('Egg-laying rate')
ylabel('Probability')
ylim([1e-4 1])
set(gca, 'FontSize', 6, 'FontName', 'Arial','YScale','log')
set(gcf, 'Position', [471,529,320,240])

% % Conditional probility (2 bins) of egg-laying rate given locomotory state
AVG_P_eggGstate = cat(2, mean(P_eggGsed, 1, 'omitnan')', mean(P_eggGact, 1, 'omitnan')');
SEM_P_eggGstate = cat(2, std(P_eggGsed,0,1, 'omitnan')', std(P_eggGact,0,1, 'omitnan')')./sqrt(NumWorm);
% ngroups = size(AVG_P_eggGstate, 1);
nbars   = size(AVG_P_eggGstate, 2);
figure(5); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(midv_eggrate, AVG_P_eggGstate, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = midv_eggrate +(- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars))*widbin_eggrate;
    errorbar(X, AVG_P_eggGstate(:,i), SEM_P_eggGstate(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(midv_eggrate)
xticklabels({'Sparse', 'Clustered'})
xlabel('Egg-laying rate')
ylabel('Conditional probability of egg-laying rate given locomotory state')
% legend({'Sedentary', 'Active'})
ylim([2e-3 0.3])
set(gca, 'FontSize', 6, 'FontName', 'Arial', 'YScale', 'log')
set(gcf, 'Position', [48,300,175,145])

% % Conditional probility (more bins) of egg-laying rate given locomotory state
figure(6); clf; hold on
hcurrP_eggGsedAll = histogram(eggGsedAll, mNbin_eggrate, 'Normalization', 'probability', 'DisplayStyle','stairs');
P_eggGsedAll = hcurrP_eggGsedAll.Values;
hcurrP_eggGactAll = histogram(eggGactAll, mNbin_eggrate, 'Normalization', 'probability', 'DisplayStyle','stairs');
P_eggGactAll = hcurrP_eggGactAll.Values;
% AVG_mP_eggGstate = cat(2, P_eggGsedAll', P_eggGactAll');
% Mids_gca = mean(cat(1, mEdge_eggrate(1:end-1), mEdge_eggrate(2:end)), 1);
% bar(Mids_gca, AVG_mP_eggGstate, 'LineStyle', 'none', 'EdgeColor', 'none')
% xticks(Mids_gca)
xlabel('Egg-laying rate')
ylabel('Conditional probability of egg-laying rate given locomotory state')
legend({'Sedentary', 'Active'})
% ylim([2e-3 0.3])
% set(gca, 'YScale', 'log')
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [527,800,469,143])

% % Conditional expectation of egg-laying rate given egg-laying rate and locomotory state
E_eggGsedegg(isinf(E_eggGsedegg)) = nan;
E_eggGactegg(isinf(E_eggGactegg)) = nan;
AVG_E_egglayeventGstateegg = cat(2, mean(E_eggGsedegg, 1, 'omitnan')', mean(E_eggGactegg, 1, 'omitnan')');
SEM_E_egglayeventGstateegg = cat(2, std(E_eggGsedegg,0,1, 'omitnan')', std(E_eggGactegg,0,1, 'omitnan')')./sqrt(NumWorm);
% ngroups = size(AVG_P_stateGegg, 1);
nbars   = size(AVG_E_egglayeventGstateegg, 2);
figure(7); clf; hold on
groupwidth = min(0.8, nbars/(nbars + 1.5));
bar(midv_eggrate, AVG_E_egglayeventGstateegg, 'LineStyle', 'none', 'EdgeColor', 'none')
for i = 1:nbars
    X = midv_eggrate +(- groupwidth/2 + (2*i-1)*groupwidth/(2*nbars))*widbin_eggrate;
    errorbar(X, AVG_E_egglayeventGstateegg(:,i), SEM_E_egglayeventGstateegg(:,i), 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none');
end
xticks(midv_eggrate)
xticklabels({'Sparse', 'Clustered'})
xlabel('Egg-laying rate')
ylabel('E(D_{egglay}|State=s & Egglay mode)(#/hr)')
ylim([1e-2 1e2])
% legend({'Sedentary', 'Active'})
set(gca, 'FontSize', 6, 'FontName', 'Arial', 'YScale', 'log')
set(gcf, 'Position', [474,306,175,145])

% % Expectation of egg-laying rate contributed per locomotory state
figure(8);clf; hold on
AVG_E_eggPstate = cat(2, mean(E_eggnumPsed, 1, 'omitnan')', mean(E_eggnumPact, 1, 'omitnan')');
SEM_E_eggPstate = cat(2, std(E_eggnumPsed,0,1, 'omitnan')', std(E_eggnumPact,0,1, 'omitnan')')./sqrt(NumWorm);
bar([1 2], AVG_E_eggPstate*5, 'LineStyle', 'none')
errorbar([1 2], AVG_E_eggPstate*5, SEM_E_eggPstate*5, 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none')
xticks([1 2])
xticklabels({'Sedentary', 'Active'})
ylabel('Total # eggs')
xlabel('State')
ylim([0 20])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,79,175,145])

% % Conditional expectation of egg-laying rate given locomotory state
figure(9);clf; hold on
AVG_E_eggGstate = cat(2, mean(E_eggnumGsed, 1, 'omitnan')', mean(E_eggnumGact, 1, 'omitnan')');
SEM_E_eggGstate = cat(2, std(E_eggnumGsed,0,1, 'omitnan')', std(E_eggnumGact,0,1, 'omitnan')')./sqrt(NumWorm);
bar([1 2], AVG_E_eggGstate, 'LineStyle', 'none')
errorbar([1 2], AVG_E_eggGstate, SEM_E_eggGstate, 'Color','k','Marker', 'none','CapSize',0,'LineStyle','none')
xticks([1 2])
xticklabels({'Sedentary', 'Active'})
ylabel('E(D_{egglay}|State=s)(#/hr)')
xlabel('State')
ylim([0 10])
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [471,79,175,145])
%% Establish the relationship between activity and egg-laying behavior
winb = 1;
wina = 1;
tt = (-winb+1:wina-1)*2;
Actcurr  = Act1Cdn2;
Eggcurr  = Egg1Cdn2; % # eggs released per interval (2 min), which includes zero egg
NumWorms = size(Actcurr,1);
NormActcurr = zeros(size(Actcurr));
ActAvgcurr  = zeros(size(Actcurr, 1), 1);
eggNumPerEventAll  = []; % # eggs released per egg-lay event (2 min), which doesn't include null events
ActateggAll = []; % activity value around egg laying
ActdropateggAll = []; % frequency drop percentage around egg laying
tActdrop2eggAll = []; % time between max frq drop to egg laying
for i = 1 : size(Actcurr,1)
    stim = Actcurr(i,:);
    normstim = stim./mean(prctile(stim, [95 100]));
    NormActcurr(i,:) = normstim;
    ActAvgcurr(i) = mean(stim);
    spik = Eggcurr(i,:);
    [sta, eggrate, actategg, actdropategg, tactdrop2egg]  = STA(normstim, spik, winb, wina);
    eggNumPerEventAll  = cat(2, eggNumPerEventAll, eggrate);
    ActateggAll = cat(2, ActateggAll, actategg);
    ActdropateggAll = cat(2, ActdropateggAll, actdropategg);
    tActdrop2eggAll = cat(2, tActdrop2eggAll, tactdrop2egg);
end
figure(7); clf;

yyaxis right
histogram(NormActcurr(:),20, 'DisplayStyle', 'stairs', 'Normalization', 'probability')
ylabel('Probability of activity')
ylim([0 0.35])
xlim([-0.08 1.18])
yyaxis left
scatter(ActateggAll, eggNumPerEventAll, 3, 'filled')
ylabel('Egg-laying rate (#/min)')
xlabel('Normalized activity')
ylim([0 2.5])
% set(gca, 'YScale','log')
set(gca, 'FontSize', 6, 'FontName', 'Arial')
set(gcf, 'Position', [295,529,240,200])


%% Back up code
%% STA analysis of activity with respect to egg-laying events
% winb = 10;
% wina = 10;
% tt = (-winb+1:wina-1)*2;
% Actcurr = Act1Cdn1;
% NumWorms = size(Actcurr,1);
% NormActcurr = zeros(size(Actcurr));
% FrqAvgcurr = zeros(size(Actcurr, 1), 1);
% Eggcurr = Egg1Cdn1*2;
% staAll = [];
% eggrateAll  = []; % egg-laying rate
% frqateggAll = []; % frequency around egg laying
% frqdropateggAll = []; % frequency drop percentage around egg laying
% tfrqdrop2eggAll = []; % time between max frq drop to egg laying
% for i = 1 : size(Actcurr,1)
%     stim = Actcurr(i,:);
%     stim = stim./max(stim);
%     NormActcurr(i,:) = stim;
%     FrqAvgcurr(i) = mean(stim);
%     spik = Eggcurr(i,:);
%     [sta, eggrate, frqategg, frqdropategg, tfrqdrop2egg]  = STA(stim, spik, winb, wina);
%     staAll = cat(1, staAll, sta);
%     eggrateAll  = cat(2, eggrateAll, eggrate);
%     frqateggAll = cat(2, frqateggAll, frqategg);
%     frqdropateggAll = cat(2, frqdropateggAll, frqdropategg);
%     tfrqdrop2eggAll = cat(2, tfrqdrop2eggAll, tfrqdrop2egg);
% end
% sta_avg = mean(staAll, 1, 'omitnan');
% sta_sem = std(staAll,0,1, 'omitnan')./sqrt(size(staAll,1));
% frq_avg = sta_avg(1);
% % frq_avg = mean(FrqAvgcurr);
% figure(2); clf; hold on
% shadedErrorBar(tt, sta_avg, sta_sem, 'b');
% plot([tt(1) tt(end)], [frq_avg frq_avg], '--r')
% xlim([-16 16])
% xlabel('Time (min)')
% ylabel('Locomotion activity (A.U.)')
% title(sprintf('wt 13 mM 5-HT (%d eggs released)', size(staAll,1)))
% hold off
% set(gca, 'FontSize', 6)
% set(gcf, 'Position', [295,529,175,145])
%% Egg-laying rate vs time of frequency drop (relative to egg laying)
% figure(6); clf
% scatter(tActdrop2eggAll*2,eggNumPerEventAll, 6,'k', 'filled')
% ylabel('Egg-laying rate (#/min)')
% xlabel('Time of activity drop (min)')
% set(gca, 'FontSize', 6, 'FontName', 'Arial')
% set(gcf, 'Position', [823,529,175,145])
%% Egg-laying rate vs frequency at egg laying
% h = histogram(NormActcurr(:),[0 0.3 1],'LineStyle','none','Normalization','probability');
% nbins = h.NumBins;
% BinEdges = h.BinEdges;
% % BinWidth = h.BinWidth;
% % BinMidPoints = mean(cat(1, BinEdges(1:end-1), BinEdges(1:end-1)+BinWidth),1);
% StateProb = h.Values; % Probability of a state defined by thresholding activity
% figure(8); clf
% bar([1 2], StateProb, 'LineStyle', 'none')
% xticks([1 2])
% xticklabels({'Sedentary', 'Active'})
% xlabel('State')
% ylabel('State Probility')
% set(gca, 'FontSize', 6, 'FontName', 'Arial')
% set(gcf, 'Position', [471,529,175,145])