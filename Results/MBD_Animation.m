load('MBD.mat')

figure('Renderer', 'painters', 'Position', [10 10 910 180])
grid on

plot(data{1}{1}{1}.Values,'LineWidth',3.5,'Color','#99FF99')
% plot(data{1}{1}{2}.Values,'LineWidth',3.5,'Color','#99FF99')

title("")
xlim([0,12])
xticks(0:1:15)
xlabel("Time (s)")
ylim([-0.59,0.59])
% ylim([-15,15])
ylabel("Steering Angle (rad)")
% ylabel("Wheel Velocity (rad/s)")

mil = animatedline('Color','#0000FF');
mil_time = data{1}{1}{1}.Values.Time;
mil_data = data{1}{1}{1}.Values.Data;
% mil_data = data{1}{1}{2}.Values.Data;

sil = animatedline('Color','#990099');
sil_time = data{2}{1}{1}.Values.Time;
sil_data = data{2}{1}{1}.Values.Data;
% sil_data = data{2}{1}{2}.Values.Data;

pil = animatedline('Color','#FF8000');
pil_time = data{3}{1}{1}.Values.Time;
pil_data = data{3}{1}{1}.Values.Data;
% pil_data = data{3}{1}{2}.Values.Data;

hil = animatedline('Color','#006600');
hil_time = data{4}{1}{1}.Values.Time;
hil_data = data{4}{1}{1}.Values.Data;
% hil_data = data{4}{1}{2}.Values.Data;

vil = animatedline('Color','#FF0000');
vil_time = data{5}{1}{1}.Values.Time;
vil_data = data{5}{1}{1}.Values.Data;
% vil_data = data{5}{1}{2}.Values.Data;

% numpoints = numel(mil_data);
numpoints = numel(sil_data);
% numpoints = numel(pil_data);
% numpoints = numel(hil_data);
% numpoints = numel(vil_data);

frames = cell(numpoints, 1);

for k = 1:numpoints
%     addpoints(mil, mil_time(k), mil_data(k))
    addpoints(sil, sil_time(k), sil_data(k))
%     addpoints(pil, pil_time(k), pil_data(k))
%     addpoints(hil, hil_time(k), hil_data(k))
%     addpoints(vil, vil_time(k), vil_data(k))
    drawnow limitrate
    frames{k} = getframe(gcf);
end

% videl_writer = VideoWriter('MIL Steering Test.avi');
% videl_writer = VideoWriter('MIL Velocity Test.avi');
videl_writer = VideoWriter('SIL Steering Test.avi');
% videl_writer = VideoWriter('SIL Velocity Test.avi');
% videl_writer = VideoWriter('PIL Steering Test.avi');
% videl_writer = VideoWriter('PIL Velocity Test.avi');
% videl_writer = VideoWriter('HIL Steering Test.avi');
% videl_writer = VideoWriter('HIL Velocity Test.avi');
% videl_writer = VideoWriter('VIL Steering Test.avi');
% videl_writer = VideoWriter('VIL Velocity Test.avi');

% Steering
% videl_writer.FrameRate = 1000;
videl_writer.FrameRate = 720;
% videl_writer.FrameRate = 120;
% videl_writer.FrameRate = 30;
% videl_writer.FrameRate = 1000;
% Velocity
% videl_writer.FrameRate = 1000;
% videl_writer.FrameRate = 720;
% videl_writer.FrameRate = 120;
% videl_writer.FrameRate = 30;
% videl_writer.FrameRate = 1000;

open(videl_writer);
for k = 1:numpoints
    writeVideo(videl_writer, frames{k});
end
videl_writer.close;

clear;
close;
clc;

