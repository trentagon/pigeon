function pigeon_plot(out)
%Lots of methodology borrowed from std_plot

blue   = [0 0.4470 0.7410];
red    = [0.6350 0.0780 0.1840];
green  = [0.4660 0.6740 0.1880];
yellow = [0.9290 0.6940 0.1250];
orange = [0.8500 0.3250 0.0980];
black  = [0,0,0];

%FORMATTING:

ticks_font_size = 10;
box_font_size = 12;
legend_font_size = 12;
line_width = 2;
label_font_size = 15;

fig_length = 800;
fig_scale  = 1.2;

figure('Renderer', 'painters', 'Position', [10 10 fig_length fig_length*fig_scale]);

fw = 3;
fh = 1;

%Case: N
pressure = out.pressures;
delta    = out.deltas_pm;
time     = out.times/1000;
tsteps   = out.timesteps;

sputtering = -out.rates(:,1);
outgassing = out.rates(:,2);
photochem = -out.rates(:,3)-out.rates(:,4)-out.rates(:,4);
ion = -out.rates(:,6);
nitrate = -out.rates(:,7);

rates = [photochem, sputtering, ion, nitrate, outgassing];
rate_names = {'Photochemical','Sputtering','Ion','Nitrate','Outgassing'};
colors = [blue; red; green; yellow; black];

% rates = [outgassing,sputtering,ion,photochem,nitrate];
% rate_names = {'Outgassing','Sputtering','Ion','Photochemical','Nitrate'};
% colors = [black;yellow;red;blue;green];   

% PRESSURE

subplot(fw,fh,1);
p1 = semilogy(time,pressure,'k');
hold on
p1_axes = gca; % axes
set(p1_axes,'XMinorTick','on','FontSize',ticks_font_size,'xtick',.5:0.5:4.5,'Xlim',[.7,4.5],'Ylim',[10^(-5),10^3]);
set(p1,'LineWidth', line_width);
ylabel('N_2 Partial Pressure (mbar)', 'FontSize',label_font_size);    
hold off

% DELTA

subplot(fw,fh,2);
d1 = plot(time,delta);
hold on
d1_axes = gca; % axes
set(d1_axes,'XMinorTick','on','FontSize',ticks_font_size,'xtick',.5:0.5:4.5,'Xlim',[.7,4.5],'Ylim',[-500,4000]);
set(d1,'LineWidth', line_width);
ylabel('\delta^{15}N (per mil)', 'FontSize',label_font_size);
hold off

% RATES

legend_cap = {};

subplot(fw,fh,3);
for i = 1:1:min(size(rates))
    r1 = semilogy(time,rates(:,i));
    hold on
    set(r1, 'LineWidth', line_width, 'Color', colors(i,:));
    legend_cap{i} = [rate_names{i},': ', num2str(sum(rates(:,i).*tsteps), '%.2f'),' mbar'];
end

r1_axes = gca; % axes
set(r1_axes,'XMinorTick','on','FontSize',ticks_font_size,'xtick',.5:0.5:4.5,'Xlim',[.7,4.5],'Ylim',[10^(-10),10^2]);
r1_ylabel = 'N_2 Flux (mbar Myr^{-1})';
r1_xlabel = 'Time (Myr)';
legend(legend_cap,'FontSize',legend_font_size, 'EdgeColor','none');
ylabel(r1_ylabel, 'FontSize',label_font_size);
xlabel(r1_xlabel, 'FontSize',label_font_size);
hold off

% %POSITIONING:

boxx_coord = 0.84;
boxy_coord = 0.855;
dont_touch = 0.1;

format shortg

p1_caption = {['P_{3.8Ga} = ',num2str(pressure(1), '%.2f')],['P_{current} = ',num2str(pressure(end), '%.3f')]};
p1_box = annotation('textbox');
set(p1_box, 'FontSize', box_font_size, 'String', p1_caption,'EdgeColor','none')
set(p1_box, 'Position', [boxx_coord, boxy_coord, dont_touch, dont_touch]);

d1_caption = {['\delta_{3.8Ga} = ',num2str(delta(1), '%.2f')],['\delta_{current} = ',num2str(delta(end), '%.2f')]};
d1_box = annotation('textbox');
set(d1_box, 'FontSize', box_font_size, 'String', d1_caption,'EdgeColor','none')
set(d1_box, 'Position', [boxx_coord, boxy_coord-.32, dont_touch, dont_touch]);



%FINAL FORMATTING
ha=get(gcf,'children');
set(ha(2),'position',[0.08 0.04 .88 .29]);
set(ha(3),'position',[0.08 0.35 .88 .29]);
set(ha(4),'position',[0.08 0.67 .88 .29]);  

    
end