function executed = measurementCutting_popup(m)
fig = uifigure;
 fig.CloseRequestFcn = @(fig,event)my_closereq(fig,false);
% Desired Window width and height
GuiWidth = 400;
GuiHeight = 250;

% Find Screen Resolution
temp =get(0,'screensize');
ScreenWidth = temp(3);
ScreenHeight = temp(4);

set (fig, 'position', [ScreenWidth/2 - GuiWidth/2, ScreenHeight/2 - GuiHeight/2, GuiWidth, GuiHeight]);

fig.Name = 'NOMADe measurement option';

lbl = uilabel(fig);
lbl.Text = "Choose start and end time";
lbl.FontSize = 14;
lbl.FontWeight= 'bold';
lbl.Position = [110 220 400 30];

lblStrt = uilabel(fig);
lblStrt.Text = "New start time";
lblStrt.FontSize = 14;
lblStrt.Position = [10 148 100 30];
lblStrtTime = uilabel(fig);
lblStrtTime.Text = "Current start time: " + datestr(m.start_time,'dd/mm/yyyy HH:MM:SS.FFF');
lblStrtTime.FontSize = 14;
lblStrtTime.Position = [10 180 320 20];

strtTime = uieditfield(fig,...
    'Position',[110 150 280 22],...
    'ValueChangedFcn',@(strtTime,event) startTimeChanged(strtTime,m));
strtTime.Value = datestr(m.start_time,'dd/mm/yyyy HH:MM:SS.FFF');

lblEnd = uilabel(fig);
lblEnd.Text = "New end time";
lblEnd.FontSize = 14;
lblEnd.Position = [10 78 100 30];
lblEndTime = uilabel(fig);
lblEndTime.Text = "Current end time: " + datestr(m.end_time,'dd/mm/yyyy HH:MM:SS.FFF');
lblEndTime.FontSize = 14;
lblEndTime.Position = [10 110 320 20];
endTime = uieditfield(fig,...
    'Position',[110 80 280 22],...
    'ValueChangedFcn',@(endTime,event) endTimeChanged(endTime,m));

endTime.Value = datestr(m.end_time,'dd/mm/yyyy HH:MM:SS.FFF');
% plot button
uibutton('Parent',fig,'Position',[(GuiWidth/2-100) 30 80 30],'Text','plot','FontWeight','bold',...
    'ButtonPushedFcn', @(btn,event) plotSignals(m));
% Confirm button
uibutton('Parent',fig,'Position',[(GuiWidth/2+20) 30 80 30],'Text','Confirm','FontWeight','bold',...
    'ButtonPushedFcn', @(btn,event) confirmButtonPushed(fig,m,strtTime,endTime));
uiwait (fig);
end



% Create the function for the ButtonPushedFcn callback
function confirmButtonPushed(fig,m,strtTime,endTime)
            startTimeConv= convertTime(strtTime.Value);
            endTimeConv= convertTime(endTime.Value);
            % start time of measurement to the next sample if start
            % time is not a multiple of 0.02
            startDiff =time2num(startTimeConv  - m.start_time,"seconds");
             endDiff =time2num(m.end_time  - endTimeConv,"seconds");
             ret = false;
            if startDiff <-3.552713678800501e-18
                strtTime.BackgroundColor = 'r';
                ret = true;
            end
             if endDiff <-3.552713678800501e-18
                endTime.BackgroundColor = 'r';
                ret = true;
             end
            if ret 
                return
            end
            
assignin('base','startTime', strtTime.Value);
assignin('base','endTime', endTime.Value);

my_closereq(fig,true);

end


% Create ValueChangedFcn callback
function startTimeChanged(timeField,m)
    startTimeConv= convertTime(timeField.Value);
     startDiff =time2num(startTimeConv  - m.start_time,"seconds");
        if startDiff <0
            timeField.BackgroundColor = 'r';
            return
        else
            timeField.BackgroundColor = 'w';
        end
end

function endTimeChanged(timeField,m)
    endTimeConv= convertTime(timeField.Value);
     endDiff =time2num(m.end_time-endTimeConv,"seconds");
        if endDiff <0
            timeField.BackgroundColor = 'r';
            return
        else
            timeField.BackgroundColor = 'w';
        end
end


function plotSignals(m)
figure;
fontSize= 20;
set(gcf,'Visible','on') % show outside live script
set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
set(0, 'DefaultAxesFontSize', fontSize);
subplotArray(1) = subplot(2,1,1);
m.instruments(1).data(2).plot(m.start_time,true,false,true,false,0);
subplotArray(2) = subplot(2,1,2);
m.instruments(1).data(3).plot(m.start_time,true,false,true,false,0);
linkaxes(subplotArray,'x');
end
function state = my_closereq(fig,st)
assignin('base','cuttingState', st);
delete(fig)
end



function convTime =  convertTime(time)
% split date and reformat the date
            dateSplit = ["00","00","0000","00","00","00","000"];
            splitted = split(time,{'-','/',':','h','m','s','.',' '},2);
            dateSplit(1:size(splitted,2)) = splitted;
            dateSymbols = ["-","-"," ",":",":",".",""];
            dateArray = reshape([dateSplit(1:7) ;dateSymbols(1:7)],1,[]);
            dateConverted = strjoin(dateArray(1:end-1),"");   
            convTime=datetime(dateConverted,'InputFormat','dd-MM-yyyy HH:mm:ss.SSS','TimeZone','local');
end