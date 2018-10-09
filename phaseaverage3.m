%% ----------------------------------
% PHASE AVERAGE - Massimiliano Marino, 18/05/2018
% -----------------------------------
% 
% [pa waves nwaves] = phaseaverage(w)           
% [pa waves nwaves] = phaseaverage(w,setwave)
% 
% from a wave signal returns phase average, single waves and number of waves
% INPUT:	w = array of the wave signal
%           setwave = set a number of samples for the wave (optional argin)
% OUTPUT:	pa = array with the phase average of the signal
%           waves = cell array of the zeroupcrossed waves, every element is a wave
% requires zeroup.m

% edit 17 09 2018: in phaseaverage3 phase average wave is long as
% mean length of all the waves

function [pa waves nwaves] = phaseaverage(w,setwave)

    switch nargin           % choose to set wave a priori or not
        case 1
        [waves nwaves ~] = zeroup(w);             % zero upcrossing function
        
        case 2
        [waves,nwaves,~] = zeroup(w,setwave);             % zero upcrossing function
    end
    
    for i = 1:nwaves
        wlength(i) = length(waves{1,i});      % length of every wave
    end
    
    meanwlength = round(mean(wlength));                % min length of all the waves
    
    for j = 1:nwaves
        waves{1,j}(end:meanwlength) = NaN;
    end
    
for eta = 1:meanwlength
    for wave = 1:nwaves
        eta2avg(wave) = waves{1,wave}(eta,1); 
    end    
    pa(eta) = nanmean(eta2avg);
end
    
    
    