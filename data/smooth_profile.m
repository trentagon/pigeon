function rates = smooth_profile(totals,times,start,tend,smooth_power)
%INPUTS!
%TOTALS: Array of total amounts corresponding to each epoch
%TIMES: array of start time of each epoch
%Both imputs must be chronological, Myr. e.g. [705, 890, 1000, 3789]

%OUTPUT!
%Array with 2 rows
%rates(1,:) = rates
%rates(2,:) = time of corresponding rate
%Index != time
%To obtain rate at given time, use "find" to get index of desired time
%The desired rate will be at that index.


t_start = start;
t_end   = tend;
tstep = 0.01;
count = 1;
sig_slope = smooth_power;

rates = zeros(2,(t_end-t_start)/tstep);

half_times = zeros(1,length(times));
for i = 1:1:length(times)
    if i == 1
        midpoint = (t_start + times(i+1))/2;
    elseif i == length(times)
        midpoint = (times(i)+t_end)/2;
    else
        midpoint = (times(i)+times(i+1))/2;
    end
    half_times(i) = midpoint;
end

for t = t_start:tstep:tend
    half_top_idx = 0;
    for i = 1:1:length(half_times)
        if t < half_times(i)
            half_top_idx = i;
            break
        end
    end
    if half_top_idx == 1
        interval     = times(2) - times(1);
        rate         = totals(1)/interval;
        rates(1,count) = rate;
        rates(2,count) = t;
        count        = count + 1;
    elseif half_top_idx == 0
        interval     = t_end - times(length(times));
        rate         = totals(length(times))/interval;
        rates(1,count) = rate;
        rates(2,count) = t;
        count        = count + 1;
    else
        %t smaller than h5
        if half_top_idx == length(times)
            next_interval     = t_end - times(length(times));
            next_rate         = totals(length(times))/next_interval;
        else
            next_interval = times(half_top_idx+1) - times(half_top_idx);
            next_rate     = totals(half_top_idx)/next_interval;
        end
        last_interval = times(half_top_idx) - times(half_top_idx-1);
        last_rate     = totals(half_top_idx-1)/last_interval;
        
        dif = next_rate - last_rate;
        o1  = max([next_rate last_rate]);
        o2  = min([next_rate last_rate]);
        
        rate         = (o1-o2)*sigmf(t,[sign(dif)*sig_slope, times(half_top_idx)]) + o2;
        rates(1,count) = rate;
        rates(2,count) = t;
        count        = count + 1;
    end

end
end 