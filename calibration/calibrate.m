addpath('OpticalFlow');
addpath('OpticalFlow/mex');

scenes = {
    {'CanadaWater', 3},...
    {'CanaryWharf', 2},...
    {'ChandlerHouse', 2},...
    {'FitzroySquare', 1},...
    {'FlaxmanGallery', 4},...
    {'GreatPortlandStreet', 2}...
    {'HampsteadHeath', 6},...
    {'RussellSquare', 1},...
    {'SenateHouse', 1},...
    {'TottenhamCourtRoad', 2},...
    {'UCL', 5},...
    {'VictoriaHouse', 3}
};

process_image = @(I) imresize(im2double(I), 0.0333333333);

input_path = '';

for index = 1:length(scenes)
    for video = 1:scenes{index}{2}
        top_image = process_image(imread(fullfile(input_path, 'top', scenes{index}{1}, num2str(video), '000100.jpg')));
        bottom_image = process_image(imread(fullfile(input_path, 'bottom', scenes{index}{1}, num2str(video), '000100.jpg')));
        tic;
        r_opt = optimise(top_image, bottom_image);
        toc;
        file_ID = fopen(fullfile(input_path, 'top', scenes{index}{1}, num2str(video), 'calibration.txt'), 'w');
        fprintf(file_ID, '%f %f %f', r_opt(1), r_opt(2), r_opt(3));
        fclose(file_ID);
    end
end