function popup(m,fctn)
    fig = uifigure;
    
     % Desired Window width and height
      GuiWidth = 500;
      if contains(fctn,'plot')
          instrumentList = isprop(m.instruments,'extracted');
          n_instruments = sum(instrumentList);
          instrumentList= find(instrumentList==1);
          lblText = 'Indicate which instruments that must be plotted:';
      else
          instrumentList = 1:m.n_instruments;
          n_instruments = m.n_instruments;
          lblText = 'Indicate which instruments that should not be retrieved:';
      end
      if isprop(m,'OAS')
        n_instruments = n_instruments +1;
    end
      GuiHeight = 30+50+n_instruments*30+10;

    % Find Screen Resolution
      temp = figposition([0,0,100,100]);
      ScreenWidth = temp(3);
      ScreenHeight = temp(4);
  
    set (fig, 'position', [ScreenWidth/2 - GuiWidth/2, ScreenHeight/2 - GuiHeight/2, GuiWidth, GuiHeight]);

    fig.Name = 'NOMADe extraction option';
    height= (n_instruments+1)*30+20;
    lbl = uilabel(fig);
    lbl.Text = lblText;
    lbl.FontSize = 14;
    lbl.FontWeight= 'bold';
    lbl.Position = [10 height 400 30];
    cb = gobjects(n_instruments,1);
    for ii = instrumentList
      cb(ii) = uicheckbox('Parent',fig,'Position',[20 height - ii*30 200 30]);
      cb(ii).Text = m.instruments(ii).name; 
    end
    if isprop(m,'OAS')
        cb(ii+1) = uicheckbox('Parent',fig,'Position',[20 height - (ii+1)*30 200 30]);

      cb(ii+1).Text = 'OAS'; 
    end

    % Select all button
    btn = uibutton('Parent',fig,'Position',[10 15 80 30],'Text','Select all',...
        'ButtonPushedFcn', @(btn,event) SelectAll(btn, cb,instrumentList,m));

    % Confirm button
    uibutton('Parent',fig,'Position',[GuiWidth-90 15 80 30],'Text','Confirm','FontWeight','bold',...
                'ButtonPushedFcn', @(btn,event) plotButtonPushed(cb,instrumentList,m));
            uiwait (fig);   
end



% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(cb,instrumentList,m)
    includedInstruments= zeros(1,size(instrumentList,2));
    for i=instrumentList
        includedInstruments(i) = cb(i).Value;
    end
    if isprop(m,'OAS')
     includedInstruments(i+1) = cb(i+1).Value;
    end
     assignin('base','includedInstruments',includedInstruments);
     closereq;
end

function SelectAll(btn,cb,instrumentList,m)
    if btn.Text == "Select all" 
        state = 1;
         btn.Text = "Deselect all";
    else
        state = 0;
        btn.Text = "Select all";
    end
    for ii = instrumentList
          cb(ii).Value =state;
    end
    if isprop(m,'OAS')
        cb(ii+1).Value =state;
    end
    
end
