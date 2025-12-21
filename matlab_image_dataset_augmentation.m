clc;
clear;

%% -------- ASK USER FOR MAIN FOLDER --------
mainInputFolder = uigetdir(pwd, 'Select the main folder containing subfolders (e.g., Eiffel_Tower, GrandCanal, etc.)');
if mainInputFolder == 0
    error('No folder selected. Exiting.');
end

[~, mainFolderName] = fileparts(mainInputFolder);
mainOutputFolder = [mainFolderName '_augmented'];

%% -------- GET SUBFOLDERS AUTOMATICALLY --------
subFolders = dir(mainInputFolder);
subFolders = subFolders([subFolders.isdir] & ~ismember({subFolders.name}, {'.','..'}));

%% -------- PROCESS EACH SUBFOLDER --------
for s = 1:length(subFolders)
    
    inputFolder = fullfile(mainInputFolder, subFolders(s).name);
    outputBase  = fullfile(mainOutputFolder, subFolders(s).name);
    
    % Create 10 output folders for this subfolder
    for i = 1:10
        folderName = fullfile(outputBase, num2str(i));
        if ~exist(folderName, 'dir')
            mkdir(folderName);
        end
    end
    
    % Read images
    imgFiles = dir(fullfile(inputFolder, '*.*'));
    imgFiles = imgFiles(~[imgFiles.isdir]);
    
    %% -------- PROCESS IMAGES --------
    for k = 1:length(imgFiles)
        imgPath = fullfile(inputFolder, imgFiles(k).name);
        img = imread(imgPath);
        
        [h, w, ~] = size(img);
        
        % Center crop (80%)
        cropRect = [round(0.1 * w), round(0.1 * h), round(0.8 * w), round(0.8 * h)];
        baseImg = imcrop(img, cropRect);
        
        augImgs = cell(10,1);
        cropRatio = 0.5; % default aggressive crop for most
        
        % 1-9 augmentations (rotate/flip + crop)
        angles = [10, -10, 20, -20, 0, 0, 10, -10]; % 1-9 rotation angles
        flips = {'none','none','none','none','h','v','h','v'}; % horizontal or vertical flip
        
        for j = 1:8
            tmpImg = baseImg;
            if flips{j} == 'h'
                tmpImg = tmpImg(:, end:-1:1, :);
            elseif flips{j} == 'v'
                tmpImg = tmpImg(end:-1:1, :, :);
            end
            if angles(j) ~= 0
                tmpImg = imrotate(tmpImg, angles(j), 'bilinear');
            end
            [rh, rw, ~] = size(tmpImg);
            cropW = round(rw*cropRatio); cropH = round(rh*cropRatio);
            x = round((rw-cropW)/2); y = round((rh-cropH)/2);
            augImgs{j} = imcrop(tmpImg,[x,y,cropW,cropH]);
        end
        
        % 9th augmentation (FlipV + Rotate -10° + crop)
        tmpImg = baseImg(end:-1:1, :, :);
        tmpImg = imrotate(tmpImg, -10, 'bilinear');
        [rh, rw, ~] = size(tmpImg);
        cropW = round(rw*cropRatio); cropH = round(rh*cropRatio);
        x = round((rw-cropW)/2); y = round((rh-cropH)/2);
        augImgs{9} = imcrop(tmpImg,[x,y,cropW,cropH]);
        
        % 10th augmentation (FlipH + Rotate +30° + more aggressive crop)
        tmpImg = baseImg(:, end:-1:1, :);
        tmpImg = imrotate(tmpImg, 30, 'bilinear');
        cropRatio10 = 0.4;
        [rh, rw, ~] = size(tmpImg);
        cropW = round(rw*cropRatio10); cropH = round(rh*cropRatio10);
        x = round((rw-cropW)/2); y = round((rh-cropH)/2);
        augImgs{10} = imcrop(tmpImg,[x,y,cropW,cropH]);
        
        %% -------- SAVE OUTPUT --------
        for i = 1:10
            outFolder = fullfile(outputBase, num2str(i));
            outPath = fullfile(outFolder, imgFiles(k).name);
            imwrite(augImgs{i}, outPath);
        end
    end
end

disp('Done: Augmentation for all subfolders completed!');

