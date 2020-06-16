clear all
df = readtable('COV19.csv');
df(table2array(df(:,6))<-127,:)=[];% delete Alaska and Hawaii data
df = table2timetable(df);
D = unique(df.date,'sorted');%date data
% 0date 1county 2state 3cases 4death 5long 6lat
%% test
%for i = unique(df.date,'sorted')
    %test = df(i,:);
    test = df('2020-4-20',:);
    lat = table2array(test(:,6));
    long = table2array(test(:,5));
    cases =  table2array(test(:,3));
    A = 5*log(cases).*log(cases)+4;
    C = zeros(size(A,1),3);
    C(cases<=10,1) = 1;
    C(cases<=10,2) = .70;
    C(cases<=10,3) = .70;
    C((10<cases)&(cases<=100),1) = 1;
    C((10<cases)&(cases<=100),2) = .53;
    C((10<cases)&(cases<=100),3) = .53;
    C((100<cases)&(cases<=500),1) = 1;
    C((100<cases)&(cases<=500),2) = .33;
    C((100<cases)&(cases<=500),3) = .33;
    C((500<cases)&(cases<=2000),1) = 1;
    C((500<cases)&(cases<=2000),2) = .17;
    C((500<cases)&(cases<=2000),3) = .17;
    C(2000<cases,1) = 1;
    C(2000<cases,2) = 0;
    C(2000<cases,3) = 0;
    
    plt = geoscatter(lat,long,A,C,'filled');
    set(gcf, 'Position', get(0, 'Screensize'));
     plt('units','normalized','outerposition',[0 0 1 1]);
    geobasemap('grayland')%darkwater grayland bluegreen grayterrain colorterrain landcover
    geolimits([22.5,50],[-128,-65]);
    set(gcf,'position',[106,188,1299,708])
    %plt.MarkerFaceColor = [.64,.08,.28];
    plt.MarkerFaceAlpha = .5;
    
    
    str = {strcat('Date:',datestr(D(1))),...
        strcat('Cumulative Number of Cases:',num2str(sum(cases)))};
    text(49,-86,str,'FontSize',12,'FontWeight','bold','Color',[0,0,0],...
        'FontName','Arial')%,'EdgeColor',[0,0,0],'LineWidth',3);
%end


%% avi 
for i = 1:size(D,1)
    test = df(D(i),:);
    lat = table2array(test(:,6));
    long = table2array(test(:,5));
    cases =  table2array(test(:,3));
    cum_case = sum(cases);
    
    A = 5*log(cases).*log(cases)+4;
    C = zeros(size(A,1),3);
    C(cases<=10,1) = 1;
    C(cases<=10,2) = .70;
    C(cases<=10,3) = .70;
    C((10<cases)&(cases<=100),1) = 1;
    C((10<cases)&(cases<=100),2) = .53;
    C((10<cases)&(cases<=100),3) = .53;
    C((100<cases)&(cases<=500),1) = 1;
    C((100<cases)&(cases<=500),2) = .33;
    C((100<cases)&(cases<=500),3) = .33;
    C((500<cases)&(cases<=2000),1) = 1;
    C((500<cases)&(cases<=2000),2) = .17;
    C((500<cases)&(cases<=2000),3) = .17;
    C(2000<cases,1) = 1;
    C(2000<cases,2) = 0;
    C(2000<cases,3) = 0;
    h = figure(1);
    
    plt = geoscatter(lat,long,A,C,'filled');
    set(gcf, 'Position', get(0, 'Screensize'));
    plt('units','normalized','outerposition',[0 0 1 1]);
    geobasemap('colorterrain')
    %plt.MarkerFaceColor = [.64,.08,.28];
    plt.MarkerFaceAlpha = 0.5;
    geobasemap('grayland')%darkwater grayland bluegreen grayterrain colorterrain landcover
    geolimits([22.5,50],[-128,-65]);
    set(gcf,'position',[106,188,1299,708]);
    
    str = {strcat('Date:',datestr(D(i))),...
        strcat('Cumulative Number of Cases:',num2str(cum_case))};
    text(49,-86,str,'FontSize',12,'FontWeight','bold','Color',[0,0,0],...
        'FontName','Arial')%,'EdgeColor',[0,0,0],'LineWidth',3);
    
    F(i) = getframe(h);
    drawnow
end

% create the video writer with 1 fps
writerObj = VideoWriter('us_cov19_trend75.avi');
writerObj.FrameRate = 2;
writerObj.Quality = 75;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);


%% gif trial
% h = figure;
% axis tight manual % this ensures that getframe() returns a consistent size
% filename = 'testAnimated.gif';
% for i = unique(df.date,'sorted')
%     test = df(i,:);
%     lat = table2array(test(:,5));
%     long = table2array(test(:,6));
%     cases =  table2array(test(:,3));
%     A = log(cases).*log(cases)+1;
%     plt = geoscatter(lat,long,A,cases,'filled');
%     geobasemap('colorterrain')
%     plt.MarkerFaceColor = [1,0.2,0];
%     plt.MarkerFaceAlpha = 0.7;
% 
%     drawnow 
%       % Capture the plot as an image 
%       frame = getframe(h); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
%       % Write to the GIF File 
%       if i == df.date(end)
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%       else 
%           imwrite(imind,cm,filename,'gif','WriteMode','append'); 
%       end 
% end



