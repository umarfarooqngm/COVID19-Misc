%% START
clc;
clear all;
close all;


%% START
% loading all the tables one by one..
master = readtable('table_DP02.csv');  %% master table
new_file_1 = readtable('table_age_sex.csv');
new_file_2 = readtable('table_FPL.csv');
new_file_3 = readtable('table_income.csv');
new_file_4 = readtable('table_race.csv');
new_file_5 = readtable('table_population.csv');

%% Merging

% we will merge two tables at a time as matlab function only provides the
% limit of 2 tables using join command...

updated = join( new_file_1,master);  % merging the master table with first table..
updated = join( new_file_2,updated); % merge the updated table with one more table..
updated = join( new_file_3,updated);
updated = join( new_file_4,updated);
updated = join( new_file_5,updated);
% The table "updated" contains the complete merged data....

%% END

[n1, m1] = size(updated);

% Confirmed cases (Y response variable)
confirmed_cases = updated(:,55); %data for confirmed cases as of July 5 from NYTimes data repository

% Population
total_population = updated(:,5);

% Race
white = updated(:,6);
black = updated(:,7);
amer_indian = updated(:,8);
asian = updated(:,9);
hawaiian = updated(:,10);
other_race = updated(:,11);

% Households
total_households = updated(:,13);
total_families = updated(:,14);
non_family = updated(:,15);

% Income
income_less10k = updated(:,16);
income_10to14k = updated(:,17);
income_15to24k = updated(:,18);
income_25to34k = updated(:,19);
income_35to49k = updated(:,20);
income_50to74k = updated(:,21);
income_75to99k = updated(:,22);
income_100to149k = updated(:,23);
income_150to199k = updated(:,24);
income_200k_ormore = updated(:,25);

% Federal Poverty line (FPL)
FPLcheck_total = updated(:,26); %check this over??
FPLcheck_male = updated(:,27); %check this over??
FPLcheck_female = updated(:,28); %check this over??

% Gender
male_population = updated(:,30);
female_population = updated(:,31);

% Age
age_under5 = updated(:,32);
age_5to10 = updated(:,33);
age_10to14 = updated(:,34);
age_15to19 = updated(:,35);
age_20to24 = updated(:,36);
age_20to24 = updated(:,36);
age_25to29 = updated(:,37);
age_30to34 = updated(:,38);
age_35to39 = updated(:,39);
age_40to44 = updated(:,40);
age_45to49 = updated(:,41);
age_50to54 = updated(:,42);
age_55to59 = updated(:,43);
age_60to64 = updated(:,44);
age_65to69 = updated(:,45);
age_70to74 = updated(:,46);
age_75to79 = updated(:,47);
age_80to84 = updated(:,48);
age_85over = updated(:,49);

% Education attainment
pop_25older = updated(:,68);
pop_25older_less9thgrad = updated(:,69);
pop_25older_noHSdipl = updated(:,70);
pop_25older_HSgraduate= updated(:,71);
pop_25older_somecollege= updated(:,72);
pop_25older_bachelors= updated(:,73);
pop_25older_graduate= updated(:,74);
house_computer = updated(:,75);
house_internet = updated(:,76);

%% Plots
% setting random size and color to the plot
% size = linspace(1,100,67);
% % color = linspace(1,10,length(confirmed_cases));
% Scattering the points for graph

% scatter(X2,X1,population/1000,population_norm,'filled')
% 
% xlabel("Distance from NYC (log)");
% ylabel("Confirmed cases (log)");
% grid on
% % title("plot A");

%% Correlation value for counties of 13 states


total_population = table2array(total_population);
confirmed_cases = table2array(confirmed_cases);

corr_matrix = corrcoef(total_population, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for county population is %.4f \n" ,corr_matrix(2));


