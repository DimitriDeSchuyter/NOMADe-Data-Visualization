classdef data
    % Teste ne
    
    properties
        name, ...
        values, ...
        datatype, ...
        unit
    end
    methods
        function obj = data(name, unit, datatype,maxCycleCount)
            obj.name = name;  
            obj.unit = unit;
            switch datatype %% ENUMERATING to prevent String compares during live loop
                case "boolean"
                    obj.datatype = 0;
                    obj.values = NaN(maxCycleCount,1);
                case "int_8"
                    obj.datatype = 1;
                    obj.values = NaN(maxCycleCount,1);
                case "uint_8"
                    obj.datatype = 2;  
                    obj.values = NaN(maxCycleCount,1);
                case "int_16"
                    obj.datatype = 3;
                    obj.values = NaN(maxCycleCount,1);
                case "uint_16"
                    obj.datatype = 4;
                    obj.values = NaN(maxCycleCount,1);
                case "iint_32"
                    obj.datatype = 5;
                    obj.values = NaN(maxCycleCount,1);
                case "uint_32"
                    obj.datatype = 6;
                    obj.values = NaN(maxCycleCount,1);
                case "float_32"
                    obj.datatype = 7;
                    obj.values = NaN(maxCycleCount,1);
                case "int_64"
                    obj.datatype = 8;
                    obj.values = NaN(maxCycleCount,1);
                case "uint_64"
                    obj.datatype = 9;
                    obj.values = NaN(maxCycleCount,1);
                case "float_64"
                    obj.datatype = 10;
                    obj.values = NaN(maxCycleCount,1);
                otherwise
                    error("MATLAB Datatype not supported")
            end
        end
        
        function obj = add_value(obj,cyclecounter_list, blob)
            switch obj.datatype %% ENUMERATING to prevent String compares during live loop
                case 0 %boolean/already converted
                    obj.values(cyclecounter_list) = blob;
                case 1 %int_8
                    reOut = reshape(blob',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'int8'); 
                case 2 %uint_8
                    reOut = reshape(blob',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'uint8');
                case 3 %int_16
                    reOut = reshape(blob(:,2:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'int16');
                case 4 %uint_16
                    reOut = reshape(blob(:,2:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'uint16');
                case 5 %int_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'int32');
                case 6 %uint_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'uint32');
                case 7 %float_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'single');
                case 8 %int_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'int64');
                case 9 %uint_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'uint64');
                case 10 %float_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values(cyclecounter_list) = typecast(reOut,'double');
                    %obj.values = typecast(blob(8:-1:1),'double');
            end
            %obj.value(cyclecounter).value;
            
            
            
            
        end
        
        function obj = remove_value(obj,cyclecounter_list)

            obj.values= obj.values(cyclecounter_list);
            
        end
        function obj = filteredData(obj,cyclecounter,data)
            obj.values(cyclecounter) = data;
        end
        
        function obj = resize(obj)
            %obj.value = obj.value;
        end
        function obj = plot(obj,startTime,enableTitle,enableXlabel,yEnLim,plotDownSample,downSampleFactor)
            time = seconds(0:(size(obj.values,1)-1))*0.020 + startTime;
             if plotDownSample
                factor = size(obj.values,1)/downSampleFactor;
                plt(time,obj.values,'LineWidth',2,'downsample',factor);
            else
                plot(time,obj.values,'LineWidth',2);
             end
            if enableTitle
                title([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',20);
            end
            if yEnLim && obj.datatype ~= 0
                ylim([min([-0.1; obj.values],[],'all')*1.1 (1.1*max([obj.values;0.1],[],'all'))]);
            elseif obj.datatype == 0
                ylim([-0.1 1.1]);
            end
            xlim(([min(time) (max(time))]));
            if enableXlabel
                tzOffset = tzoffset(startTime);
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
            end
            if strlength(char(obj.name))> 30
                yText = split(extractAfter(char(obj.name),strlength(char(obj.name))/2),['-',' ']);
                yText = char(yText(end));
            else
                yText = char(obj.name);
            end
            ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
        end
    end
end