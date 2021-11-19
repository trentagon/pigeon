
clear all
c1 = load('case1.mat');
c2 = load('case2.mat');
c3 = load('case3.mat');
c4 = load('case4.mat');
c5 = load('case5.mat');

c_data = {c1,c2,c3,c4,c5};

CO2_casegraph(c_data);


function CO2_casegraph(case_data)

%FORMATTING:

blue   = [0 0.4470 0.7410];
red    = [0.6350 0.0780 0.1840];
green  = [0.4660 0.6740 0.1880];
yellow = [0.9290 0.6940 0.1250];
orange = [0.8500 0.3250 0.0980];
black  = [0,0,0];

colors = [red;blue;green;yellow;orange;black];

ticks_font_size = 10;
% box_font_size = 12;
legend_font_size = 12;
line_width = 2;
label_font_size = 18;
% 
% fig_length = 600;
% fig_scale  = 1;
% 
% figure('Renderer', 'painters', 'Position', [10 10 fig_length fig_length*fig_scale]);


case_no = length(case_data);
for i = 1:1:case_no
    crate = case_data{i}.output.trace(:,1);
    times = 4.5 - case_data{i}.output.trace(:,3)/1000;
    r1 = semilogy(times,crate);
    hold on
    set(r1, 'LineWidth', line_width, 'Color', colors(i,:));
    
end

r1_axes = gca; % axes
set(r1_axes,'XMinorTick','on','FontSize',ticks_font_size,'xtick',0:0.5:3.8,'Xlim',[0,3.8],'Ylim',[10^0,3*10^3]);
set(r1_axes, 'Xdir', 'reverse');

r1_ylabel = 'pCO_{2} (mbar)';
r1_xlabel = 'Time before present (Ga)';
legend_cap = {"Case 1: 0.25 bar", "Case 2: 0.5 bar", "Case 3: 1 bar", "Case 4: 1.8 bar", "Case 5: 0.007 bar"};

legend(legend_cap,'FontSize',legend_font_size);
ylabel(r1_ylabel, 'FontSize',label_font_size);
xlabel(r1_xlabel, 'FontSize',label_font_size);
title("pCO_{2} Evolution Scenarios");



end
