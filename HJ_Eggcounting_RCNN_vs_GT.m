clc; clear;
% Set the Python executable to the one in the virtual environment
pyenv("Version", "C:\Users\fffei\PycharmProjects\pythonProject\venv\Scripts\python.exe");  %--------NEED MODIFY
% Check the Python version and executable used by MATLAB
current_py_env = pyenv;
disp("MATLAB is using Python version: " + string(current_py_env.Version));
disp("Python executable: " + string(current_py_env.Executable));
% Add the path to the Python module
module_path = fullfile('C:\Users\fffei\Dropbox\Paper\Egg-laying\Code\RCNN\Source_code\mask_rcnn');  %--------NEED MODIFY
if count(py.sys.path, module_path) == 0
    insert(py.sys.path, int32(0), module_path);
end
% Import the Python module
Mask_R_CNN = py.importlib.import_module('Tutorial_Mask_R_CNN_PyTorchOfficial');
Mask_R_CNN = py.importlib.reload(Mask_R_CNN);

mfolder_path = 'C:\Users\fffei\Dropbox\Dian Hongfei shared\worm analysis\Matlab code\DC_CountingEggs';
Mask_R_CNN.run_main(pyargs('mfolder_path', mfolder_path));

%% Drawl Scatter Plot
Parentdir = '/Users/hongfei/Library/CloudStorage/Dropbox-Personal/Dian Hongfei shared/worm analysis/Matlab code/DC_CountingEggs';
load(fullfile(Parentdir, 'Eggnumbers_GT.mat'), 'GT')
Subdir = dir(fullfile(Parentdir, 'wt egl-*'));
Area_All = [];
MaskNum_All = [];
for i = 1:numel(Subdir)
    currDirName = Subdir(i).name;
    load(fullfile(Parentdir, currDirName, 'TOTAL_AREAS.mat'), 'TOTAL_AREAS')
    load(fullfile(Parentdir, currDirName, 'TOTAL_MASKNUMS.mat'), 'TOTAL_MASKNUMS')
    Area_All = cat(2, Area_All, double(TOTAL_AREAS));
    MaskNum_All = cat(2, MaskNum_All, double(TOTAL_MASKNUMS));
end

EggArea_lr = GT'\Area_All';
EggNum_prd = Area_All/EggArea_lr;
RMSE = sqrt(mean((GT - EggNum_prd).^2));
R2 = 1 - sum((GT - EggNum_prd).^2)/sum((GT - mean(GT)).^2);

figure(22); clf; hold on
scatter(GT, EggNum_prd, 3, 'k', 'filled')
% Plot the line of perfect prediction
plot([min(GT), max(GT)], [min(GT), max(GT)], '-r', 'LineWidth', 1);
xlim([0 45])
ylim([0 45])
xticks([0 10 20 30 40])
yticks([0 10 20 30 40])
xlabel('# eggs ground truth');
ylabel('# eggs rediction');
set(gca, 'FontSize', 6, 'FontName', 'Arial')
% Annotate the plot with the RMSE and R-squared values
text(25, 8, sprintf('RMSE: %.2f\nR^2: %.3f', RMSE, R2), 'FontSize', 6)
set(gcf, 'Position', [58,683,175,145])

% RMSE = sqrt(mean((GT - MaskNum_All).^2));
% R2 = 1 - sum((GT - MaskNum_All).^2)/sum((GT - mean(GT)).^2);
% figure(2); clf; hold on
% scatter(GT, MaskNum_All, 15, 'filled')
% % Plot the line of perfect prediction
% plot([min(GT), max(GT)], [min(GT), max(GT)], 'r', 'LineWidth', 2);
% xlabel('Ground Truth');
% ylabel('Prediction (Mask Number)');
% set(gca, 'FontSize', 14)
% % Annotate the plot with the RMSE and R-squared values
% text(30, 10, sprintf('R^2: %.3f', R2), 'FontSize', 16)
% text(25, 5, sprintf('RMSE: %.2f', RMSE), 'FontSize', 16)

