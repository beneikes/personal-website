% configuration
pp = 4; % [-] number of pole pairs
img_path = fullfile(fileparts(fileparts(mfilename('fullpath'))),'docs','img');

% example data
phi_r = linspace(0,2*pi,1000);
phi_el_0 = mod(pp*phi_r,2*pi);
phi_el_100 = mod(pp*phi_r+deg2rad(100),2*pi);

% plot results
fig = figure('Position',[100 100 800 300]);
plot(rad2deg(phi_r),rad2deg(phi_el_0),LineWidth=2)
hold all
plot(rad2deg(phi_r),rad2deg(phi_el_100),LineWidth=2)
grid on
grid minor
box on
xlim([0 360])
ylim([0 360])
xticks(0:90:360)
yticks(0:90:360)
xlabel('Rotor Angle / deg')
ylabel('Electrical Angle / deg')
legend('Offset = 0 deg','Offset = 100 deg')
exportgraphics(fig,fullfile(img_path,'enc_offset_02.png'),'Resolution',300)

