%% START
clc;
clear all;
close all;


%% START
% loading all the tables one by one..
master = readtable('table_DP02.csv');  %% master table
new_file_1 = readtable('table_population.csv');
new_file_2 = readtable('table_age_sex.csv');
new_file_3 = readtable('table_FPL.csv');
new_file_4 = readtable('table_income.csv');


%% Merging

% we will merge two tables at a time as matlab function only provides the
% limit of 2 tables using join command...

updated = join(new_file_1, master);  % merging the master table with first table..
updated = join(new_file_2, updated); % merge the updated table with one more table..
updated = join(new_file_3, updated);
updated = join(new_file_4, updated);

% updated = join(updated,new_file_5);  % save for accuweather data
% The table "updated" contains the complete merged data....


% updated = join(master, new_file_1);  % merging the master table with first table..
% updated = join(updated, new_file_2); % merge the updated table with one more table..
% updated = join(updated, new_file_3);
% updated = join(updated, new_file_4);


%% END

[n1, m1] = size(updated);


%% Load NYTimes Covid19 Cumulative Confirmed Data Table

data = readtable('us-counties_july8_v2.csv');

[n1, m1] = size(data);

% Reading in the table for NYTimes cumulative confirmed cases for all dates
% and only using the 13 states of interest 

% Converts the columns to categorial for whichever columns you want to use
% as filter.

data.state = categorical(data.state);
data.county = categorical(data.county); 

% Add the confitions below as shown using and (&), or(|) operator..
% index = (data.state=='Texas') &(data.county == 'Sabine');

index = (data.date == '3/15/2020')

% the table new data contains filtered data.. you can extract your choice
% of columns from it.
new_data = data(index,:);

% march31_cases = new_data(:,[1:7]);
% updated = join(march31_cases,updated);


%% End
% Confirmed cases (Y response variable)
confirmed_cases = updated(:,45); %data for confirmed cases as of July 5 from NYTimes data repository

% Population
total_population = updated(:,22);
 
% Households
total_households = updated(:,52);
total_families = updated(:,53);
non_family = updated(:,59);
 
% Income
income_less10k = updated(:,8);
income_10to14k = updated(:,9);
income_15to24k = updated(:,10);
income_25to34k = updated(:,11);
income_35to49k = updated(:,12);
income_50to74k = updated(:,13);
income_75to99k = updated(:,14);
income_100to149k = updated(:,15);
income_150to199k = updated(:,16);
income_200k_ormore = updated(:,17);
 
% Federal Poverty line (FPL)
FPLcheck_total = updated(:,19); %check this over??
FPLcheck_male = updated(:,20); %check this over??
FPLcheck_female = updated(:,21); %check this over??
 
% Gender
male_population = updated(:,23);
female_population = updated(:,24);
 
% Age
age_under5 = updated(:,25);
age_5to10 = updated(:,26);
age_10to14 = updated(:,27);
age_15to19 = updated(:,28);
age_20to24 = updated(:,29);
age_25to29 = updated(:,30);
age_30to34 = updated(:,31);
age_35to39 = updated(:,32);
age_40to44 = updated(:,33);
age_45to49 = updated(:,34);
age_50to54 = updated(:,35);
age_55to59 = updated(:,36);
age_60to64 = updated(:,37);
age_65to69 = updated(:,38);
age_70to74 = updated(:,39);
age_75to79 = updated(:,40);
age_80to84 = updated(:,41);
age_85over = updated(:,42);
 
% Google mobility trends
retail_and_recr = updated(:,46);
grocery_and_pharm = updated(:,47);
parks = updated(:,48);
transit_stations = updated(:,49);
workplaces = updated(:,50);
residential = updated(:,51);


% Education attainment
pop_25older = updated(:,64);
pop_25older_less9thgrad = updated(:,65);
pop_25older_noHSdipl = updated(:,66);
pop_25older_HSgraduate= updated(:,67);
pop_25older_somecollege= updated(:,68);
pop_25older_bachelors= updated(:,69);  
pop_25older_graduate= updated(:,70);   

house_computer = updated(:,71);
house_internet = updated(:,72);


%% Correlation value for counties of 13 states

confirmed_cases = table2array(confirmed_cases);
total_population = table2array(total_population);


% Households
total_households = table2array(total_households);
total_families = table2array(total_families);
non_family = table2array(non_family);

% Income
income_less10k = table2array(income_less10k);
income_10to14k = table2array(income_10to14k);
income_15to24k = table2array(income_15to24k);
income_25to34k = table2array(income_25to34k);
income_35to49k = table2array(income_35to49k);
income_50to74k = table2array(income_50to74k);
income_75to99k = table2array(income_75to99k);
income_100to149k = table2array(income_100to149k);
income_150to199k = table2array(income_150to199k);
income_200k_ormore = table2array(income_200k_ormore);

% Federal Poverty line (FPL)
FPLcheck_total = table2array(FPLcheck_total); %check this over??
FPLcheck_male = table2array(FPLcheck_male); %check this over??
FPLcheck_female = table2array(FPLcheck_female);; %check this over??

% Gender
male_population = table2array(male_population);
female_population = table2array(female_population);

% Age
age_under5 = table2array(age_under5);
age_5to10 = table2array(age_5to10);
age_10to14 = table2array(age_10to14);
age_15to19 = table2array(age_15to19);
age_20to24 = table2array(age_20to24);
age_25to29 = table2array(age_25to29);
age_30to34 = table2array(age_30to34);
age_35to39 = table2array(age_35to39);
age_40to44 = table2array(age_40to44);
age_45to49 = table2array(age_45to49);
age_50to54 = table2array(age_50to54);
age_55to59 = table2array(age_55to59);
age_60to64 = table2array(age_60to64);
age_65to69 = table2array(age_65to69);
age_70to74 = table2array(age_70to74);
age_75to79 = table2array(age_75to79);
age_80to84 = table2array(age_80to84);
age_85over = table2array(age_85over);


% Google mobility trends
retail_and_recr = table2array(retail_and_recr);
grocery_and_pharm = table2array(grocery_and_pharm);
parks = table2array(parks);
transit_stations = table2array(transit_stations);
workplaces = table2array(workplaces);
residential = table2array(residential);

% Education attainment
pop_25older = table2array(pop_25older);
pop_25older_less9thgrad = table2array(pop_25older_less9thgrad);
pop_25older_noHSdipl = table2array(pop_25older_noHSdipl);
pop_25older_HSgraduate = table2array(pop_25older_HSgraduate);
pop_25older_somecollege = table2array(pop_25older_somecollege);
pop_25older_bachelors = table2array(pop_25older_bachelors);
pop_25older_graduate = table2array(pop_25older_graduate);
house_computer = table2array(house_computer);
house_internet = table2array(house_internet);

%% Plots
% setting random size and color to the plot
% size = linspace(1,100,67);
% % color = linspace(1,10,length(confirmed_cases));
% Scattering the points for graph


population_norm = total_population/10000
scatter(pop_25older_less9thgrad,confirmed_cases,total_population/10000,population_norm,'filled')
 
xlabel("Population of 25 and older with education of 9th grade or less");
ylabel("Confirmed cases");
grid on
title("Confirmed Cases vs. Population of 25+ with eduction of 9th grade or less");


scatter(age_85over,confirmed_cases,total_population/10000,population_norm,'filled')
 
xlabel("Population of 85 years and older");
ylabel("Confirmed cases");
grid on
title("Confirmed Cases vs. Population of 85 years and older");


scatter(FPLcheck_total,confirmed_cases,total_population/10000,population_norm,'filled')
 
xlabel("Population of Federal Poverty Line (FPL)");
ylabel("Confirmed cases");
grid on
title("Confirmed Cases vs. Population of Federal Poverty Level (FPL)");

%Histograms

%Histogram
figure;
hist(income_less10k , 20); title('Income less than $10K'); %returns bins and counts; can specify #bins= n by doing: hist(households,n)
figure;
hist(income_10to14k);  title('Income between $10K and $14,999');
figure;
hist(income_15to24k); title('Income between $15K and $24,999');
figure;
hist(income_25to34k ); title('Income between $25K and $34,999');
figure;
hist(income_35to49k); title('Income between $35K and $49,999');
figure;
hist(income_50to74k ); title('Income between $50K and $74,999');
figure;
hist(income_75to99k); title('Income between $75K and $99,999');
figure;
hist(income_100to149k); title('Income between $100K and $149,999');
figure;
hist(income_150to199k); title('Income between $150K and $199,999');
figure;
hist(income_200k_ormore); title('Income between $200K and more');




% Correlation of the different predictors to confirmed cases
corr_matrix = corrcoef(total_population, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for county population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(total_households, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for total households is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(total_families, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for total families is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(non_family, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for nonfamily is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_less10k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income less than 10K is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_10to14k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 10k - 14,9999 is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_15to24k , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 15k - 24,9999 is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_25to34k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 25k - 34,9999 is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_35to49k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 35k - 49,9999  is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_50to74k , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 50k - 74,9999  is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_75to99k , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 75k - 99,9999  is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_100to149k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 100k - 149,9999  is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_150to199k, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income between 150k - 199,9999  is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(income_200k_ormore, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for income 200k or more is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(FPLcheck_total , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Federal Poverty line (FPL) population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(FPLcheck_male  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Federal Poverty line (FPL) males is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(FPLcheck_female, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Federal Poverty line (FPL) females is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(male_population , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for male population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(female_population, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for female population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_under5 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age under 5 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_5to10  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 5 to 10 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_10to14  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 10 to 14 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_15to19  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 15 to 19 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_20to24  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 20 to 24 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_25to29 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 25 to 29 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_30to34  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 30 to 34 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_35to39  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 35 to 39 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_40to44  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 40 to 44 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_45to49 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 45 to 49 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_50to54  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 50 to 54 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_55to59 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 55 to 59 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_60to64  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 60 to 64 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_65to69 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 65 to 69 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_70to74  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 70 to 74 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_75to79 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 75 to 79 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_80to84 , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 80 to 84 population is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(age_85over , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for age 85 and older population is %.4f \n" ,corr_matrix(2));


%% Google mobility trends
retail_and_recr = table2array(retail_and_recr);
grocery_and_pharm = table2array(grocery_and_pharm);
parks = table2array(parks);
transit_stations = table2array(transit_stations);
workplaces = table2array(workplaces);
residential = table2array(residential);

corr_matrix = corrcoef(retail_and_recr , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- retail and recreation % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(grocery_and_pharm , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- grocery and pharmacy % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(parks , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- parks % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(transit_stations, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- transit stations % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(workplaces, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- workplaces % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(residential, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for Google mobility- residential % change from baseline is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_less9thgrad , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - with less than 9th grade edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_noHSdipl  , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - 9th to 12 grade edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_HSgraduate , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - with HS edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_somecollege , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - with some college edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_bachelors, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - with bachelors edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(pop_25older_graduate, confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for population 25 and older - with graduate edu is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(house_computer , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for households with a computer is %.4f \n" ,corr_matrix(2));

corr_matrix = corrcoef(house_internet , confirmed_cases,'Rows','complete');
fprintf(" \n The correlation value for households with broadband internet is %.4f \n" ,corr_matrix(2));

% Correlation plots
corr_data = readtable('correlation_results.csv');


