%% Get information about what's inside your folder.
%% test
myfiles = dir('C:\Users\umarf\OneDrive\Documents\GitHub\COVID19-Misc\test');


%% Get the filenames and folders of all files and folders inside the folder  of your choice.
filenames={myfiles(:).name}';
filefolders={myfiles(:).folder}';

%% Get only those files that have a csv extension and their corresponding folders.
csvfiles=filenames(endsWith(filenames,'.csv'));
csvfolders=filefolders(endsWith(filenames,'.csv'));


%% Make a cell array of strings containing the full file locations of the files.
files=fullfile(csvfolders,csvfiles);

%% Loading the CSV files into 
l = length(files);
CSV_data = cell(l,1)
for i = 1:l
    CSV_data{i,1} = readtable(files{i,1});
end
% We will have all the data from csv file into the variable  CSV_data
% we can access data by calling CSV_data{i,1} for accessing "i th" file.
