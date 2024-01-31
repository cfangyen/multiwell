function [sta, eggrate, frqategg, frqdropategg, tfrqdrop2egg] = STA(stim, spik, winb, wina)
if wina ~= 1
    spik(1:winb-1) = 0; % discard spikes in first window
    spik(end-wina+2:end) = 0; % discard spikes in last window
end
neggs = sum(spik);
spikIdx = find(spik);
nspiks = numel(spikIdx);
sta = zeros(1, winb+wina-1);
eggrate = nan(1, nspiks);
frqategg = nan(1, nspiks);
frqdropategg = nan(1, nspiks);
tfrqdrop2egg = nan(1, nspiks);
for i = 1 : nspiks
    wId = spikIdx(i)-winb+1 : spikIdx(i)+wina-1;
    wId_small = spikIdx(i)-1 : spikIdx(i)+1;
    egglayWin = spik(spikIdx(i));
    stimWin = stim(wId).*egglayWin;
    sta = sta + stimWin;
    eggrate(i)  = spik(spikIdx(i));
    frqategg(i) = mean(stim(spikIdx(i)));
    frqdropategg(i) = (mean(stim(spikIdx(i))))/max(stim);
    tfrqdrop2egg(i) = sum((max(stim)-stim(wId)).*wId)./sum((max(stim)-stim(wId)))-spikIdx(i);
end
sta = sta./neggs;
%     figure(15); clf
%     plot(-winb+1:wina-1, sta)
if neggs~=0
    sta = repmat(sta, [ceil(neggs), 1]);
end
end