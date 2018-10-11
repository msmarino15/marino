% -----------------------------------------------
% ZEROUP CROSSING - Massimiliano Marino, Mar 2018
% -----------------------------------------------
% INPUT: [w] wave time series, size(w) = [length(w) 1]
% OUTPUT:
% [waves] all the cutted waves
% [nwaves] number of waves of the time series minus 1, equal to size(H)
% [H] wave height for every wave of the time series, size(H) = [nwaves 1]

function [waves nwaves H] = zeroup(w)

dtw = detrend(w);
wlong = numel(dtw);

for j = 2:wlong
    c = dtw(j)*dtw(j-1);
    if c < 0
        crosst(j) = dtw(j);
    else
        crosst(j) = NaN;
    end
end
cross = crosst';                    % punti dove il prod fra i e i-1 è negativo
for j = 1:wlong
    if cross(j) > 0
        zeroupt(j) = 1;
    else
        zeroupt(j) = 0;
    end
end
    windex = [1:wlong]';
    zeroup = zeroupt';              % 1 if there is zeroup crossing, 0 if there is not
    zeroupi = zeroup.*windex;       % indexes of w time series where there is a zeroup crossing
    nwaves = sum(zeroup)-1;         % number of waves
    zeroupi(zeroupi==0) = [];       % delete all zeros in w index
    
% compute H for every wave
for j = 1:numel(zeroupi)-1
    wave_start = zeroupi(j);
    wave_end = zeroupi(j+1)-1;
    wave = w(wave_start:wave_end);
    Ht(j) = max(wave)-min(wave);
    waves{j} = wave;
    clear wave_start wave_end wave
end
H = Ht';
end
