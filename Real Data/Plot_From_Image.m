%% Preliminaries

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 36;
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end

%% Image Processing & Data Extraction

% Read in a standard color image.
folder = 'C:\Users\csamak\OneDrive - Clemson University\Desktop';
baseFileName = 'Throttle.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  % Didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
% Display the original color image.
subplot(2, 2, 1);
imshow(rgbImage);
axis on;
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'WindowState','maximized');
% Extract the individual red, green, and blue color channels.
% redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
% blueChannel = rgbImage(:, :, 3);
% Get the binaryImage
binaryImage = greenChannel < 200;
% Display the original color image.
subplot(2, 2, 2);
imshow(binaryImage);
axis on;
title('Transformed Binary Image', 'FontSize', fontSize);
% Find the baseline
verticalProfile  = sum(binaryImage, 2);
lastLine = find(verticalProfile, 1, 'last');
% Scan across columns finding where the top of the hump is
for col = 1 : columns
  yy = lastLine - find(binaryImage(:, col), 1, 'first');
  if isempty(yy)
    y(col) = 0;
  else
    y(col) = yy;
  end
end
subplot(2,2,[3,4]);
plot(1 : columns, y, 'b-', 'LineWidth', 3);
grid on;
title('Plot Generated from Original Image', 'FontSize', fontSize);
ylabel('Y', 'FontSize', fontSize);
xlabel('X', 'FontSize', fontSize);

%% Data Post-Processing & Logging

clear;  % Erase all existing variables. Or clearvars if you want.
fig = gcf;  % Use current figure handle
axObjs = fig.Children;  % Extract axes
dataObjs = axObjs.Children;  % Extract data
X_Data = dataObjs(1).XData;  % Extract X axis data
Y_Data = dataObjs(1).YData;  % Extract Y axis data
X_Data = normalize(X_Data,'range',[0 12])';  % Normalize X axis data
Y_Data = normalize(Y_Data,'range',[-1 1])';  % Normalize Y axis data
save("Plot_Data","X_Data","Y_Data")  % Save the data as "Plot_Data.mat" file

%% Export Data as XLSX Table

Data = table(X_Data,Y_Data);
writetable(Data,'Plot_Data.xlsx')