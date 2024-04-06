% Define the folder paths
rootFolder = 'C:\Users\Sajiah Razeen\Documents\MATLAB\Activities';
outputFolder = 'C:\Users\Sajiah Razeen\Documents\MATLAB\PreprocessedImages';

% Create the output folder if it doesn't exist
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Get a list of activity folders
activityFolders = {'jumping', 'running', 'studying'};

% Iterate over each activity folder
for i = 1:length(activityFolders)
    currentFolder = fullfile(rootFolder, activityFolders{i});
    outputSubfolder = fullfile(outputFolder, activityFolders{i});
    
    % Create the output subfolder if it doesn't exist
    if ~exist(outputSubfolder, 'dir')
        mkdir(outputSubfolder);
    end
    
    % Define the file extensions to search for
    extensions = {'jpg', 'png', 'avif', 'jpeg'};
    
    % Initialize an empty array for storing image files
    imageFiles = [];
    
    % Iterate over each extension
    for ext = extensions
        % Get a list of image files for the current extension
        currentFiles = dir(fullfile(currentFolder, ['*.', ext{1}]));
        % Concatenate the current files to the imageFiles array
        imageFiles = [imageFiles; currentFiles];
    end
    
    % Iterate over each image file
    for j = 1:length(imageFiles)
        try
            currentFile = fullfile(currentFolder, imageFiles(j).name);
            
            % Read the image
            image = imread(currentFile);
            
            % Adjust the brightness of the image
            adjustedImage = imadjust(image, [0.2, 0.8], []); % Adjust the brightness levels as desired
            
            % Resize the image
            resizedImage = imresize(adjustedImage, [256, 256]); % Adjust the desired size if necessary
            
            % Convert the preprocessed image to jpg format
            [~, filename, ~] = fileparts(imageFiles(j).name);
            outputFilename = fullfile(outputSubfolder, [filename, '_preprocessed.jpg']); % Save as jpg format
            imwrite(resizedImage, outputFilename, 'jpg');
        catch exception
            fprintf('Error processing image: %s\n', imageFiles(j).name);
            fprintf('Error message: %s\n', exception.message);
        end
    end
end

disp('Preprocessing complete.');