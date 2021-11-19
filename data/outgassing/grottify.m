function rates = grottify(old_rates,start)
%Input: the outgassing profile in km3/myr from smooth profile
%Output: Takes the higher of the old profile and grott profile before 3.6 Ga.

grott_rates = load('grott_rates.mat');
grott_rates = grott_rates.grott_rates;

grott_end = 1000;
interp_times = start:0.01:grott_end;
interp_grott = interp1(grott_rates(2,:),grott_rates(1,:),interp_times);
og_grott(1,:) = interp_grott;
og_grott(2,:) = interp_times;

for i = 1:length(og_grott(1,:))
    if old_rates(1,i) > og_grott(1,i)
        mark = i;
        break
    end
end

rates = [og_grott(:,1:mark-1) old_rates(:,mark:end)];

end