dir = strcat('C:\Users\jmsta\Box\grp-sas-ees-climatelab\PROJECTS\',...
    'Projects_Ecology_2021\Project_ECOLOGY_SummerSTUDENTS_2021\CPhyto_TK_ROY\');
outdir = "C:\Users\jmsta\Documents\Marinov\";

months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]; %month num for save function

roys = cell(4,12);
tks = cell(4,12);

sizes = ["totC","microC","nanoC","picoC"];

roy13 = 'ROY13_';
tk = 'TK_';

tail = '_2003_07_x5.mat';
for i = 1:12
   
    roy_in = strcat(dir,roy13,months(i),tail);
    tk_in = strcat(dir,tk,months(i),tail);
    
    disp(months(i))

    load(roy_in); disp("roy loaded")
    roys{1,i} = totC;
    roys{2,i} = microC;
    roys{3,i} = nanoC;
    roys{4,i} = picoC;
    
    disp("roys added")
    
    load(tk_in); disp("tk loaded")
    tks{1,i} = totC;
    tks{2,i} = microC;
    tks{3,i} = nanoC;
    tks{4,i} = picoC;
    
    disp("tks added")
end



% image=zeros(300,400,3); %initialize
% image(:,1:100,1)=0.5;   %Red (dark red)
% image(:,101:200,1)=1;   %Red (maximum value)
% image(1:100,:,2)=rand(100,400);  %Green


% nccreate('test5.nc','jan','Dimensions',{'lat',2160,'lon',4320,'year',5},...
%     'FillValue','disable');
% ncwrite('test5.nc','jan',roy_tot{1});


lat = 2160; lon = 4320; year = 5;
for i = 1:12
    
    disp(months(i))
    
    for j = 1:4
        
        roy_name = strcat('data/','roy_',sizes(j),'.nc');
        tk_name = strcat('data/','tk_',sizes(j),'.nc');
        
        nccreate(roy_name,months(i),'Dimensions',...
            {'lat',lat,'lon',lon,'year',year},...
            'FillValue','disable');
        nccreate(tk_name,months(i),'Dimensions',...
            {'lat',lat,'lon',lon,'year',year},...
            'FillValue','disable');

        ncwrite(roy_name,months(i),roys{j,i});
        ncwrite(tk_name,months(i),tks{j,i});
   
        disp(strcat(sizes(j)," written"))
    end
    
end





