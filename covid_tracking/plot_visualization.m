
%% Get information about what's inside your folder.
myfiles = dir('C:\Users\umarf\Downloads\test');


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



%% Below is the now code


CSV_data_single = CSV_data{i,1};

% Load data
a = height(CSV_data_single);


% Remove NaN values from table
CSV_data_single = rmmissing(CSV_data_single);

lat = table2array(CSV_data_single(:,4));
lon = table2array(CSV_data_single(:,5));
deaths = table2array(CSV_data_single(:,7));

A = 5*log(deaths).*log(deaths)+4;


Col = zeros(length(lon),3);


% Adding color to plot according to number of deaths
for i = 1:height(CSV_data_single)
    if CSV_data_single{i,7} < 100
        Col(i,:) = [0 , 1 ,0];
    elseif CSV_data_single{i,7} < 1000
        Col(i,:) = [0.9290, 0.6940, 0.1250];
    else 
        Col(i,:) = [1,0,0]
    end
end
  

% scatter filled plot
geoscatter(lat,lon,A,Col,'o','filled')
set(gcf, 'Position', get(0, 'Screensize'));

