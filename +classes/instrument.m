classdef instrument < dynamicprops
    % instrument summary
    % This object contains all the sensor data
    %
    %
    % Method summary:
    % *	add_data               -    add data to the sensordata object of the instrument
    % * export                 -    Under construction
    % * plot_all               -    plot all the sensordata object of the instrument.
    properties
        id, ...
            name, ...
            description, ...
            data, ...
            datatype , ...
            length
    end
    properties (Hidden)
        filtered
    end
    methods
        %%  *************** constructor *******************
        function obj = instrument(id, name, description, datatype,maxCycleCount,addDistSubs)
            %constructor of the instrument
            %Declaration of the ID, name, description and the datatype of
            %the instrument.
            %Creation of the different sensordata object of each
            %instrument.
            
            obj.id = id;
            obj.name = name;
            obj.description = description;
            obj.datatype = datatype;
            switch obj.datatype
                case 161 % A1 JOYSTICK_DX2_OUTPUT
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(7) = classes.data("Operating time","s","float_64",1);
                case 162 % A2 JOYSTICK_PG_OUTPUT
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Mode","number","int_8",maxCycleCount);
                    obj.data(6) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(7) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(8) = classes.data("Operating time","s","float_64",1);
                case 163 % A3 JOYSTICK_LINX_OUTPUT
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(7) = classes.data("Operating time","s","float_64",1);
                case 177 % B1 IMU_9AXIS_ROT_VEC
                    obj.length = 26;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(7) = classes.data("mx","0.01 µT","int_16",maxCycleCount);
                    obj.data(8) = classes.data("my","0.01 µT","int_16",maxCycleCount);
                    obj.data(9) = classes.data("mz","0.01 µT","int_16",maxCycleCount);
                    obj.data(10) = classes.data("real","0.001","int_16",maxCycleCount);
                    obj.data(11) = classes.data("i","0.001","int_16",maxCycleCount);
                    obj.data(12) = classes.data("j","0.001","int_16",maxCycleCount);
                    obj.data(13) = classes.data("k","0.001","int_16",maxCycleCount);
                case 178 % B2 IMU_6AXIS
                    obj.length = 12;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                 case 180 % B4 IMU_QUAT (Quat only)
                    obj.length = 8;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("real","?","int_16",maxCycleCount);
                    obj.data(2) = classes.data("i","?","int_16",maxCycleCount);
                    obj.data(3) = classes.data("j","?","int_16",maxCycleCount);
                    obj.data(4) = classes.data("k","?","int_16",maxCycleCount);
                 case 181 %  B5	IMU_QUAT_GYRO_ACC
                    obj.length = 20;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("real","?","int_16",maxCycleCount);
                    obj.data(2) = classes.data("i","?","int_16",maxCycleCount);
                    obj.data(3) = classes.data("j","?","int_16",maxCycleCount);
                    obj.data(4) = classes.data("k","?","int_16",maxCycleCount);                    
                    obj.data(5) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(7) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(8) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(9) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(10) = classes.data("az","cm/s^2","int_16",maxCycleCount); 
                 case 182 % B6 IMU_QUAT_GYRO_ACC_100Hz 
                    obj.length = 40;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("real","?","int_16",maxCycleCount);
                    obj.data(2) = classes.data("i","?","int_16",maxCycleCount);
                    obj.data(3) = classes.data("j","?","int_16",maxCycleCount);
                    obj.data(4) = classes.data("k","?","int_16",maxCycleCount);                    
                    obj.data(5) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(7) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(8) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(9) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(10) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(11) = classes.data("real","?","int_16",maxCycleCount);
                    obj.data(12) = classes.data("i","?","int_16",maxCycleCount);
                    obj.data(13) = classes.data("j","?","int_16",maxCycleCount);
                    obj.data(14) = classes.data("k","?","int_16",maxCycleCount);                    
                    obj.data(15) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(16) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(17) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(18) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(19) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(20) = classes.data("az","cm/s^2","int_16",maxCycleCount);    
                 case 186 % BA IMU_GYRO_ACC_MAG
                    obj.length = 18;
                    obj.data = classes.data.empty(0,obj.length);                  
                    obj.data(1) = classes.data("gx","degree/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("gy","degree/s","int_16",maxCycleCount);
                    obj.data(3) = classes.data("gz","degree/s","int_16",maxCycleCount);
                    obj.data(4) = classes.data("ax","m/s^2","int_16",maxCycleCount);
                    obj.data(5) = classes.data("ay","m/s^2","int_16",maxCycleCount);
                    obj.data(6) = classes.data("az","m/s^2","int_16",maxCycleCount);                    
                    obj.data(7) = classes.data("mx","µT","int_16",maxCycleCount);
                    obj.data(8) = classes.data("my","µT","int_16",maxCycleCount);
                    obj.data(9) = classes.data("mz","µT","int_16",maxCycleCount);   
                case 187 % BB IMU_GYRO_ACC_MAG_100Hz 
                    obj.length = 36;
                    obj.data = classes.data.empty(0,obj.length);                  
                    obj.data(1) = classes.data("gx","degree/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("gy","degree/s","int_16",maxCycleCount);
                    obj.data(3) = classes.data("gz","degree/s","int_16",maxCycleCount);
                    obj.data(4) = classes.data("ax","m/s^2","int_16",maxCycleCount);
                    obj.data(5) = classes.data("ay","m/s^2","int_16",maxCycleCount);
                    obj.data(6) = classes.data("az","m/s^2","int_16",maxCycleCount);                    
                    obj.data(7) = classes.data("mx","µT","int_16",maxCycleCount);
                    obj.data(8) = classes.data("my","µT","int_16",maxCycleCount);
                    obj.data(9) = classes.data("mz","µT","int_16",maxCycleCount);             
                    obj.data(10) = classes.data("gx","degree/s","int_16",maxCycleCount);
                    obj.data(11) = classes.data("gy","degree/s","int_16",maxCycleCount);
                    obj.data(12) = classes.data("gz","degree/s","int_16",maxCycleCount);
                    obj.data(13) = classes.data("ax","m/s^2","int_16",maxCycleCount);
                    obj.data(14) = classes.data("ay","m/s^2","int_16",maxCycleCount);
                    obj.data(15) = classes.data("az","m/s^2","int_16",maxCycleCount);                    
                    obj.data(16) = classes.data("mx","µT","int_16",maxCycleCount);
                    obj.data(17) = classes.data("my","µT","int_16",maxCycleCount);
                    obj.data(18) = classes.data("mz","µT","int_16",maxCycleCount);   
                case 193 % C1 GPS_MIN_DATA
                    obj.length = 17;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("longitude","degrees","float_32",maxCycleCount);
                    obj.data(2) = classes.data("latitude","degrees","float_32",maxCycleCount);
                    obj.data(3) = classes.data("hMSL","m","float_32",maxCycleCount);
                    obj.data(4) = classes.data("speed","m/s","float_32",maxCycleCount);
                    obj.data(5) = classes.data("Reception","-","int_8",maxCycleCount);
                case 194 % C2 GPS_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 195 % C3 GPS_DATA_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 209 % D1 AN_DISTANCE_NODES D1 (US)
                    obj.length = 2;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("US","cm","uint_16",maxCycleCount);
                case 210 % D2 CAN_DISTANCE_NODES D2 (IR)
                    obj.length = 1;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("IR","cm","uint_8",maxCycleCount);
                case 211 % D3 CAN_DISTANCE_NODES D3 (US+IR)
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR","cm","uint_8",maxCycleCount);
                    end
                case 212 % D4 CAN_DISTANCE_NODES D4 (US+2IR)
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                    end
                case 213 % D5 CAN_DISTANCE_NODES D5 (US+3IR)
                    obj.length = 7;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                        obj.data(5) = classes.data("IR 3","cm","uint_8",maxCycleCount);
                    end
                case 214 % D6  CAN_DISTANCE_NODES D6(4IR)
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(3) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 3","cm","uint_8",maxCycleCount);
                        obj.data(5) = classes.data("IR 4","cm","uint_8",maxCycleCount);
                    end
                case 215 % D7  CAN_DISTANCE_NODES D7 (4IR) Only Calculated Value
                    obj.length = 2;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated distance","cm","uint_16",maxCycleCount);
                case 216 % D8  CAN_DISTANCE_NODES D8 (US+3IR) Only Calculated Value
                    obj.length = 2;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated distance","cm","uint_16",maxCycleCount);
                case 225 % E1 Real Time Clock
                    obj.length = 8;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("unix_epoch_ms","ms","uint_64",maxCycleCount);
                case 241 % F1 Android Device
                    obj.length = 2;
                    obj.data = classes.data.empty(0,4);
                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);
                    obj.data(2) = classes.data("Buzzer","","boolean",maxCycleCount);
                    obj.data(3) = classes.data("Haptic Feedback","","boolean",maxCycleCount);
                    obj.data(4) = classes.data("Visual Feedback","","boolean",maxCycleCount);
                    
                case 242 % F2 Android Device
                    obj.length = 3;
                    obj.data = classes.data.empty(0,12);
                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);
                    obj.data(2) = classes.data("Buzzer","","boolean",maxCycleCount);
                    obj.data(3) = classes.data("Haptic Feedback","","boolean",maxCycleCount);
                    obj.data(4) = classes.data("Visual Feedback","","boolean",maxCycleCount);
                    obj.data(5) = classes.data("Sensor activate bit - Instrument 1","","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Sensor activate bit - Instrument 2","","boolean",maxCycleCount);
                    obj.data(7) = classes.data("Sensor activate bit - Instrument 3","","boolean",maxCycleCount);
                    obj.data(8) = classes.data("Sensor activate bit - Instrument 4","","boolean",maxCycleCount);
                    obj.data(9) = classes.data("Sensor activate bit - Instrument 5","","boolean",maxCycleCount);
                    obj.data(10) = classes.data("Sensor activate bit - Instrument 6","","boolean",maxCycleCount);
                    obj.data(11) = classes.data("Sensor activate bit - Instrument 7","","boolean",maxCycleCount);
                    obj.data(12) = classes.data("Sensor activate bit - Instrument 8","","boolean",maxCycleCount);
                otherwise
                    error("Datatype unsupported");
            end
        end
        
        %%  *************** add data function *******************
        function obj = add_data(obj, cyclecounter_list, blob, addDistSubs)
            % add data to the sensordata object of the instrument
            switch obj.datatype
                case 161 % A1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,3) ~= 0 | blob(:,4) ~= 0);
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                case 162 % A2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,6));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,3) ~= 0 | blob(:,4) ~= 0);
                    flankDet = [obj.data(6).values ;0]- [0; obj.data(6).values];
                    obj.data(7) = obj.data(7).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(8) = obj.data(8).filteredData(1,sum(rmmissing(obj.data(6).values))*0.02);
                case 163 % A3
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) =  obj.data(6).add_value(cyclecounter_list, blob(:,4) ~= 0 | blob(:,5) ~= 0);
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                case 177 % B1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, blob(:,19:20));
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, blob(:,21:22));
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, blob(:,23:24));
                    obj.data(13) = obj.data(13).add_value(cyclecounter_list, blob(:,25:26));
                case 178 % B2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                case 180 % B4 IMU_QUAT (Quat only)
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                case 181 % B5 IMU_QUAT_GYRO_ACC
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, blob(:,19:20));
                 case 182 % B6 IMU_QUAT_GYRO_ACC_100Hz
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, blob(:,19:20));
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, blob(:,21:22));
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, blob(:,23:24));
                    obj.data(13) = obj.data(13).add_value(cyclecounter_list, blob(:,25:26));
                    obj.data(14) = obj.data(14).add_value(cyclecounter_list, blob(:,27:28));
                    obj.data(15) = obj.data(15).add_value(cyclecounter_list, blob(:,29:30));
                    obj.data(16) = obj.data(16).add_value(cyclecounter_list, blob(:,31:32));
                    obj.data(17) = obj.data(17).add_value(cyclecounter_list, blob(:,33:34));
                    obj.data(18) = obj.data(18).add_value(cyclecounter_list, blob(:,35:36));
                    obj.data(19) = obj.data(19).add_value(cyclecounter_list, blob(:,37:38));
                    obj.data(20) = obj.data(20).add_value(cyclecounter_list, blob(:,39:40));
                 case 186 % BA IMU_GYRO_ACC_MAG 
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                 case 187 % BA IMU_GYRO_ACC_MAG 100HZ
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, blob(:,19:20));
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, blob(:,21:22));
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, blob(:,23:24));
                    obj.data(13) = obj.data(13).add_value(cyclecounter_list, blob(:,25:26));
                    obj.data(14) = obj.data(14).add_value(cyclecounter_list, blob(:,27:28));
                    obj.data(15) = obj.data(15).add_value(cyclecounter_list, blob(:,29:30));
                    obj.data(16) = obj.data(16).add_value(cyclecounter_list, blob(:,31:32));
                    obj.data(17) = obj.data(17).add_value(cyclecounter_list, blob(:,33:34));
                    obj.data(18) = obj.data(18).add_value(cyclecounter_list, blob(:,35:36));
                case 193 % C1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:4));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,5:8));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,9:12));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,13:16));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,17));
                case 194 % C2
                case 195 % C3
                case 209 % D1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 210 % D2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                case 211 % D3
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                    end
                case 212 % D4
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                    end
                case 213 % D5
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                        obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,7));
                    end
                case 214 % D6
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                        obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,6));
                    end
                case 215 % D7
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 216 % D8
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 225 % E1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:8));
                case 241 % F1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1)==1);
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2)==2);
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4)==4);
                case 242 % F2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1)==1);
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2)==2);
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4)==4);
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, bitand(blob(:,3),1)==1);
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, bitand(blob(:,3),2)==2);
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, bitand(blob(:,3),4)==4);
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, bitand(blob(:,3),8)==8);
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, bitand(blob(:,3),16)==16);
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, bitand(blob(:,3),32)==32);
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, bitand(blob(:,3),64)==64);
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, bitand(uint8(blob(:,3)),128)==128);
            end
        end
        
        %%  *************** remove data function *******************
        function obj = remove_data(obj,cyclecounter_Keeplist)
            
            switch obj.datatype
                case 161 % A1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                case 162 % A2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    flankDet = [obj.data(6).values ;0]- [0; obj.data(6).values];
                    obj.data(7) = obj.data(7).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(8) = obj.data(8).filteredData(1,sum(rmmissing(obj.data(6).values))*0.02);
                case 163 % A3
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) =  obj.data(6).remove_value(cyclecounter_Keeplist);
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                case 177 % B1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                    obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);
                    obj.data(12) = obj.data(12).remove_value(cyclecounter_Keeplist);
                    obj.data(13) = obj.data(13).remove_value(cyclecounter_Keeplist);
                case 178 % B2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                case 180 % B4  	IMU_QUAT (Quat only)
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                case 181 % B5  	IMU_QUAT_GYRO_ACC
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                     obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                case 182 % B6  	 IMU_QUAT_GYRO_ACC_100Hz 
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                    obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);
                    obj.data(12) = obj.data(12).remove_value(cyclecounter_Keeplist);
                    obj.data(13) = obj.data(13).remove_value(cyclecounter_Keeplist);
                    obj.data(14) = obj.data(14).remove_value(cyclecounter_Keeplist);
                    obj.data(15) = obj.data(15).remove_value(cyclecounter_Keeplist);
                    obj.data(16) = obj.data(16).remove_value(cyclecounter_Keeplist);
                    obj.data(17) = obj.data(17).remove_value(cyclecounter_Keeplist);
                    obj.data(18) = obj.data(18).remove_value(cyclecounter_Keeplist);
                    obj.data(19) = obj.data(19).remove_value(cyclecounter_Keeplist);
                    obj.data(20) = obj.data(20).remove_value(cyclecounter_Keeplist);
                case 193 % C1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                case 194 % C2
                case 195 % C3
                case 209 % D1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 210 % D2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 211 % D3
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    end
                case 212 % D4
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    end
                case 213 % D5
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                        obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    end
                case 214 % D6
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                        obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    end
                case 215 % D7
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 216 % D8
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 225 % E1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 241 % F1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                case 242 % F2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                    obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);
                    obj.data(12) = obj.data(12).remove_value(cyclecounter_Keeplist);
            end
        end
        
        %% ***************Filtering *******************
        function obj = filter(obj,deadZone,FilterUnit)
            switch obj.datatype
                case 161 % A1 JOYSTICK_DX2_OUTPUT
                    R= 128;
                    % declaration of filtered data
                    
                    if FilterUnit % percentage
                        filter = abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100;
                    else  % value
                        filter = abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone;
                    end
                    
                    if  sum(filter)>0
                        if FilterUnit % percentage
                            obj.data(8) = classes.data("Turn (" + deadZone + "%)" ,"filt. %","int_8",size(obj.data(3).values,1));
                            obj.data(9) = classes.data("Speed (" + deadZone + "%)" ,"filt. %","int_8",size(obj.data(3).values,1));
                        else  % value
                            obj.data(8) = classes.data("Turn (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                            obj.data(9) = classes.data("Speed (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                        end
                        
                        if( ~isprop(obj,'filterSetting'))
                            obj.addprop('filterSetting');
                        end
                        obj.filterSetting.deadZone = deadZone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                    else
                        obj.filtered = false;
                        return;
                    end
                    
                    turn = obj.data(2).values(filter);
                    speed = obj.data(3).values(filter);
                    cycle = find(filter);
                    obj.data(10) = classes.data("Filt. operated","bit","boolean",size(obj.data(3).values,1));
                    obj.data(11) = classes.data("Filt. bouts","bouts/measurement","boolean",1);
                    obj.data(12) = classes.data("Filt. operating time","s","float_64",1);
                    % filtering Turn and speed
                    obj.data(8) = obj.data(8).filteredData(cycle, turn);
                    obj.data(9) = obj.data(9).filteredData(cycle, speed);
                    % Calculate operated bit and baud
                    obj.data(10) = obj.data(10).add_value(1:size(obj.data(3).values,1), (obj.data(8).values ~= 0 & ~isnan(obj.data(8).values))| (obj.data(9).values ~= 0& ~isnan(obj.data(9).values)));
                    flankDet = [obj.data(10).values ;0]- [0; obj.data(10).values];
                    obj.data(11) = obj.data(11).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(12) = obj.data(12).filteredData(1,sum(obj.data(10).values)*0.02);
                    
                case 162 % A2 JOYSTICK_PG_OUTPUT
                    R = 100;
                    % declaration of filtered data
                    if FilterUnit % percentage
                        filter = abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100;
                    else  % value
                        filter = abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone;
                    end
                    
                    if sum(filter)>0
                        if FilterUnit % percentage
                            obj.data(9) = classes.data("Turn (" + deadZone + "%)" ,"filt.","int_8",size(obj.data(3).values,1));
                            obj.data(10) = classes.data("Speed (" + deadZone + "%)" ,"filt.","int_8",size(obj.data(3).values,1));
                        else % value
                            obj.data(9) = classes.data("Turn (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                            obj.data(10) = classes.data("Speed (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                        end
                        if( ~isprop(obj,'filterSetting'))
                            obj.addprop('filterSetting');
                        end
                        obj.filterSetting.deadZone = deadzone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                    else
                        obj.filtered = false;
                        return;
                    end
                    
                    turn = obj.data(2).values(filter);
                    speed = obj.data(3).values(filter);
                    cycle = find(filter);
                    
                    obj.data(11) = classes.data("Filt. operated","bit","boolean",size(obj.data(3).values,1));
                    obj.data(12) = classes.data("Filt. bouts","bouts/measurement","boolean",1);
                    obj.data(13) = classes.data("Filt. operating time","s","float_64",1);
                    % filtering Turn and speed
                    obj.data(9) = obj.data(9).filteredData(cycle, turn);
                    obj.data(10) = obj.data(10).filteredData(cycle, speed);
                    % Calculate operated bit and baud
                    obj.data(11) = obj.data(11).add_value(1:size(obj.data(3).values,1), (obj.data(9).values ~= 0 & ~isnan(obj.data(9).values))| (obj.data(10).values ~= 0& ~isnan(obj.data(10).values)));
                    flankDet = [obj.data(11).values ;0]- [0; obj.data(11).values];
                    obj.data(12) = obj.data(12).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(13) = obj.data(13).filteredData(1,sum(obj.data(11).values)*0.02);
                    
                case 163 % A3 JOYSTICK_LINX_OUTPUT
                    R = 128;
                    
                    if FilterUnit % percentage
                        filter = abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100;
                    else  % value
                        filter = abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone;
                    end
                    
                    if sum(filter)>0
                        % declaration of filtered data
                        
                        if FilterUnit % percentage
                            obj.data(8) = classes.data("Turn (" + deadZone + "%)" ,"filt.","int_8",size(obj.data(3).values,1));
                            obj.data(9) = classes.data("Speed (" + deadZone + "%)" ,"filt.","int_8",size(obj.data(3).values,1));
                        else % value
                            obj.data(8) = classes.data("Turn (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                            obj.data(9) = classes.data("Speed (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                        end
                        if( ~isprop(obj,'filterSetting'))
                            obj.addprop('filterSetting');
                        end
                        obj.filterSetting.deadZone = deadzone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                        
                    else
                        obj.filtered = false;
                        return
                    end
                    
                    turn = obj.data(2).values(filter);
                    speed = obj.data(3).values(filter);
                    cycle = find(filter);
                    
                    obj.data(10) = classes.data("Filt. operated","bit","boolean",size(obj.data(3).values,1));
                    obj.data(11) = classes.data("Filt. bouts","bouts/measurement","boolean",1);
                    obj.data(12) = classes.data("Filt. operating time","s","float_64",1);
                    % filtering Turn and speed
                    obj.data(8) = obj.data(8).filteredData(cycle, turn);
                    obj.data(9) = obj.data(9).filteredData(cycle, speed);
                    % Calculate operated bit and baud
                    obj.data(10) = obj.data(10).add_value(1:size(obj.data(3).values,1), (obj.data(8).values ~= 0 & ~isnan(obj.data(8).values))| (obj.data(9).values ~= 0& ~isnan(obj.data(9).values)));
                    flankDet = [obj.data(10).values ;0]- [0; obj.data(10).values];
                    obj.data(11) = obj.data(11).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(12) = obj.data(12).filteredData(1,sum(obj.data(10).values)*0.02);
                otherwise
                    warning("Not yet programmed");
            end
            obj.filtered = true;
        end
        
        %%  *************** export function *******************
        function out = export(obj)
            % Under construction
            switch obj.datatype
                case 161 % A1
                case 162 % A2
                case 163 % A3
                    out= obj.data(1).values';
                case 177 % B1
                case 178 % B2
                case 193 % C1
                case 194 % C2
                case 195 % C3
                case 209 % D1
                case 210 % D2
                case 211 % D3
                case 212 % D4
                case 213 % D5
                case 214 % D6
                case 215 % D7
                case 225 % E1
                case 241 % F1
                case 242 % F2
            end
        end
        
        
        %%  *************** plot function *******************
        function obj = plot_all(obj,measureID,startTime,showHeatMap,standardHeatmap,variableScale,showJoystickPath,plotDownSample,downSampleFactor, showDistSubs,showGPS)
            % plot all the sensordata object of the instrument.
            % It plots with the following settings:
            % - Font size= 20
            % - Plots on fullscreen figure
            % - X-axis is linked with the other subplots
            % - The axes hava a default axis font size of 18 or 14.
            % - The figures gets a title in the format:
            %   -   starttime - measurement ID: xx -
            fontSize = 20;
            if obj.datatype ==193 && showGPS >0 || obj.datatype ~=193
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
            else
                return
            end
            switch obj.datatype
                case 161 % A1 JOYSTICK DX2
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =  subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(3) =  subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(4) =  subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern(2, 3, fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,128,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,128,gridSize,variableScale,false,fontSize);
                    end
                    % ------ Filtered  ------
                    if showHeatMap(2) && ~isempty(obj.filtered) && obj.filtered
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(8).values,obj.data(9).values,128,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(8).values,obj.data(9).values,128,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(6).values) + " " + obj.data(6).unit ,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  obj.filtered
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(11).values) + " " + obj.data(11).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                case 162 % A2 JOYSTICK PG
                    subplotArray(1) = subplot(2,4,1:4);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(2,4,5);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(2,4,6);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(2,4,7);
                    obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(5) = subplot(2,4,8);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    Title =[obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern(2, 3, fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,100,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,100,gridSize,variableScale,false,fontSize);
                    end
                    
                    % ------ Filtered ------
                    if showHeatMap(2) &&  ~isempty(obj.filtered) && obj.filtered
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(9).values,obj.data(10).values,100,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap --------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(9).values,obj.data(10).values,100,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(8).values) + " " + obj.data(8).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  obj.filtered
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(13).values) + " " + obj.data(13).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(10).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                case 163 % A3 JOYSTICK LINX
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(3) =subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                    subplotArray(4) =subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern(2, 3, fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,128,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(2).values,obj.data(3).values,128,gridSize,variableScale,false,fontSize);
                    end
                    
                    % ------ Filtered ------
                    if showHeatMap(2) && ~isempty(obj.filtered) && obj.filtered
                        % ------ Standard heatmap ------
                        obj.Heatmp(obj.data(8).values,obj.data(9).values,128,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp(obj.data(8).values,obj.data(9).values,128,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(6).values) + " " + obj.data(6).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  obj.filtered
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(11).values) + " " + obj.data(11).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top')
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                case 177 % B1 IMU 9AXIS
                    % accelleration
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    % Magnetometer
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % Quaternion
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(12).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(13).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    
                    
                case 178 % B2 IMU 6AXIS
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    figure();
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) =subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                case 180 % B4 IMU_QUAT (Quat only)    
                    % Quaternion
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');

                case 181 % B5  	IMU_QUAT_GYRO_ACC
                     % Quaternion
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(7).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(10).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');

                case 182 % B6  	IMU_QUAT_GYRO_ACC_100Hz
                     % Quaternion
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');       
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(7).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(10).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                      Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                      % Quaternion
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(12).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(13).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(14).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');       
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(15).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(16).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(17).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(18).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(19).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(20).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                  case 186 % BA  IMU_GYRO_ACC_MAG                                         
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                      Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                      % Magneto
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');       
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                case 187 % BA  IMU_GYRO_ACC_MAG 
                                        
                    
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                      Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                      % Magneto
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');       
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
%                     gyroscope
                   subplotArray(1) = subplot(3,1,1);
                    obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(12).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % accelleration
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(13).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(14).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(15).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                      Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                      % Magneto
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(16).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(17).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(18).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');       
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                case 193 % C1 GPS MIN
                    if showGPS >0
                        subplotArray(1) = subplot(2,1,1);
                        obj.data(1).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(2) = subplot(2,1,2);
                        obj.data(2).plot(startTime,true,true,false,plotDownSample,downSampleFactor);
                        Title = [obj.name newline  '- ' ...
                            datestr(datetime(startTime), ...
                            'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize+2);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                        figure();
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(3) =subplot(3,1,3);
                        obj.data(5).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        linkaxes(subplotArray,'x');
                        Title = [obj.name newline  '- ' ...
                            datestr(datetime(startTime), ...
                            'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize+2);
                        catch
                            suptitle(Title);
                        end
                    end
                    if showGPS == 1 || showGPS == 3
                        figure()
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        if plotDownSample
                            factor = size(obj.data(2).values,1)/downSampleFactor;
                            plt(obj.data(1).values, obj.data(2).values,'+','downsample',factor);
                            xlabel(obj.data(1).name);
                            ylabel(obj.data(2).name);
                        else
                            plot(obj.data(1).values, obj.data(2).values,'+');
                            Title = [obj.name newline  '- ' ...
                                datestr(datetime(startTime), ...
                                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                            try
                                sgtitle(Title,'fontsize',fontSize+2);
                            catch
                                suptitle(Title);
                            end
                            xlabel('Longitude','fontsize',fontSize);
                            ylabel('lattitude','fontsize',fontSize);
                        end
                    end
                    if showGPS == 2 || showGPS == 3
                        % with satelitte view
                        figure()
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        gx =geoscatter(obj.data(2).values(:), obj.data(1).values(:));
                        gx.Parent.FontSize =fontSize;
                        geobasemap satellite
                        [latlim, lonlim] = geolimits;
                        geolimits([latlim(1)-0.0009 latlim(2)+0.0009],[lonlim(1)-0.0009 lonlim(2)+0.0009]) ;
                    end
                    %
                    
                    
                    
                case 194 % C2 GPS STATUS
                    disp([obj.name " is not yet programmed"]);
                case 195 % C3 GPS DATA STATUS
                    disp([obj.name " is not yet programmed"]);
                case 209 % D1 CAN DISTANCE NODES (US)
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                case 210 % D2 CAN DISTANCE NODES (IR)
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                    %                     ylim([0 max(obj.data(1).values)*1.2]);
                case 211 % D3 CAN DISTANCE NODES (US+IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                    else
                        subplotArray(1) =subplot(2,2,1:2);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        subplotArray(2) =subplot(2,2,3);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(3) = subplot(2,2,4);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        linkaxes(subplotArray,'x');
                    end
                case 212 % D4 CAN DISTANCE NODES (US+2IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                    else
                        subplotArray(1) = subplot(2,3,1:3);
                        obj.data(1).plot(startTime,true,true,false,plotDownSample,downSampleFactor);
                        ylim([0 max(obj.data(1).values)*1.2]);
                        subplotArray(2) = subplot(2,3,4);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(3) = subplot(2,3,5);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(4) = subplot(2,3,5);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        linkaxes(subplotArray,'x');
                    end
                case 213 % D5 CAN DISTANCE NODES (US+3IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                    else
                        subplotArray(1) =subplot(2,4,1:4);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        subplotArray(2) = subplot(2,4,5);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(3) = subplot(2,4,6);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(4) = subplot(2,4,7);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(5) = subplot(2,4,8);
                        obj.data(5).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        linkaxes(subplotArray,'x');
                    end
                case 214 % D6 CAN DISTANCE NODES (4IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                    else
                        subplotArray(1) = subplot(2,4,1:4);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                        subplotArray(2) = subplot(2,4,5);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(3) = subplot(2,4,6);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(4) = subplot(2,4,7);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        subplotArray(5) = subplot(2,4,8);
                        obj.data(5).plot(startTime,true,false,false,plotDownSample,downSampleFactor);
                        linkaxes(subplotArray,'x');
                    end
                case 215 % D7 CAN DISTANCE NODES (4IR) Only Calculated Value
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                case 216 % D8 CAN DISTANCE NODES (US+3IR) Only Calculated Value
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor);
                case 225 % E1 Real Time Clock
                    obj.data(1).plot(startTime,false,true,false,plotDownSample,downSampleFactor);
                case 241 % F1 USB AD as Instrument
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    s = get(gca, 'Position');
                    set(gca, 'Position', [s(1), s(2), s(3), s(4) * 0.9])
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    s = get(gca, 'Position');
                    set(gca, 'Position', [s(1), s(2), s(3), s(4) * 0.9])
                    linkaxes(subplotArray,'x');
                case 242 % F2 USB AD as Instrument + Sensor activate bits
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(8).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(12).plot(startTime,true,true,true,plotDownSample,downSampleFactor);
                    linkaxes(subplotArray,'x');
            end
            
            Title = [obj.name newline  '- ' ...
                datestr(datetime(startTime), ...
                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
            if obj.datatype ~= 161 && obj.datatype  ~= 162 && obj.datatype  ~= 163 && obj.datatype  ~= 242
                try
                    sgtitle(Title,'fontsize',fontSize+2);
                catch
                    suptitle(Title);
                end
            end
            
        plotJoystick(obj,measureID,startTime,showJoystickPath)
            
        end
        
        %%  Local plot functions
        
        function Heatmp(~,turn,speed,R,size,variableScale,dataFiltered,fontSize)
            
            tic
            XgridEdges = -R:(R*2)/size:R;
            YgridEdges =-R:(R*2)/size:R;
            
            
            cData = histcounts2(turn,speed,XgridEdges,YgridEdges);
            cData(cData == 0) =nan;
            cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
            cData = cData/length(turn)*100; %
            limit = R-(R/size);
            clusteredSpeed = round(linspace(limit,-limit,size),2);
            clusteredTurn = round(linspace(-limit,limit,size),2);
            % create heatmap
            figure;
            set(gca,'fontsize',20) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', 20);
            h = heatmap(clusteredTurn,clusteredSpeed,cData);
            h.ColorLimits = [0 100];
            if dataFiltered
                h.Title = string(size)+ "x" + string(size) + " filtered Joystick Deflection Heat Map";
            else
                h.Title = string(size)+ "x" + string(size) + " RAW Joystick Deflection Heat Map";
            end
            if variableScale
                h.ColorLimits = [0 max(max(cData))];
            else
                h.ColorLimits = [0 100];
            end
            h.CellLabelFormat = '%.2f';
            h.ColorMethod = 'none';
            h.XLabel = 'turn';
            h.YLabel = 'speed';
            h.FontSize = fontSize;
            h.MissingDataLabel = 0;
            h.MissingDataColor = [1 1 1];
            colormap default
            disp("Elapsed time for " + string(size)+ "x" + string(size) + " heatmap: " + toc + "s")
            
        end
        
        function DeflectionsPattern(obj,xDataNr,yDataNr,fontSize,plotDownSample,downSampleFactor)
            figure()
            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', fontSize);
            try
                sgtitle('Joystick Deflection Pattern','fontsize',fontSize+2);
            catch
                suptitle('Joystick Deflection Pattern');
            end
            if plotDownSample
                factor = size(obj.data(xDataNr).values,1)/downSampleFactor;
                plt(obj.data(xDataNr).values, obj.data(yDataNr).values,'+','downsample',factor);
            else
                plot(obj.data(xDataNr).values, obj.data(yDataNr).values,'+');
            end
            axis equal;
            limValue = max(abs([obj.data(xDataNr).values; obj.data(yDataNr).values]))*1.1;
            if( limValue >0)
                axis ([-limValue limValue -limValue limValue]);
            end
            xlabel(obj.data(xDataNr).name);
            ylabel(obj.data(yDataNr).name);
        end
        
        function plotJoystick(obj,measureID,startTime,showJoystickPath)
            
                % --------------------- Joystick path length ----------------------------
            if( isprop(obj,'pathLength'))
                fontSize = 20;
                time = seconds(0:(size(obj.pathLength.d,1)-1))*0.020 + startTime;
                tzOffset = tzoffset(startTime);
                
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                nrPlots = sum(showJoystickPath);
                subplotArray(1) = subplot(1 + (nrPlots>0),2,1:2);
                plot(time,obj.pathLength.d,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Instantaneous joystick path length [RAW]' ];
                
                title(Title,'fontsize',20);
                
                if showJoystickPath(1)
                    subplotArray(2) = subplot(1 + (nrPlots>0),2,3:3+(nrPlots==1));
                    plot(time,obj.pathLength.dx ,'LineWidth',2)
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                    title('dx [RAW]','fontsize',fontSize)
                    
                end
                
                if showJoystickPath(2)
                    subplotArray(3-(nrPlots==1)) = subplot(1 + (nrPlots>0),2,4-(nrPlots==1):4);
                    plot(time,obj.pathLength.dy,'LineWidth',2 )
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                    title('dy [RAW]','fontsize',fontSize)
                end
                linkaxes(subplotArray,'x');
                % plot cumulative path
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                plot(time,obj.pathLength.cumd,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                
                %                 ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Cumulative joystick path length (CJPL) [RAW]' ];
                
                title(Title,'fontsize',20);
                text(time(50),obj.pathLength.cumd(end), "CJPL score: " + round(obj.pathLength.scoreD),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.pathLength.cumd(end)*0.95, "Smoothness NJS: " + round(obj.pathLength.smoothness),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                
                display( "CJPL score: " + round(obj.pathLength.scoreD));
                display("Smoothness NJS: " + round(obj.pathLength.smoothness)');
                
                % differences plots
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                
                subplotArray(1) = subplot(3,2,1);
                plot(obj.pathLength.diff1.x,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff1.x)]));
                xlabel('Samples','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'X diff 1' ];
                title(Title,'fontsize',20);
                
                subplotArray(2) = subplot(3,2,2);
                plot(obj.pathLength.diff1.y,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff1.y)]));
                xlabel('Samples','fontsize',20);
                title('Y diff 1','fontsize',fontSize)
                
                % 2th diff
                subplotArray(3) = subplot(3,2,3);
                plot(obj.pathLength.diff2.x,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff2.x)]));
                xlabel('Samples','fontsize',20);
                title('X diff 2','fontsize',fontSize)
                
                subplotArray(4) = subplot(3,2,4);
                plot(obj.pathLength.diff2.y,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff2.y)]));
                xlabel('Samples','fontsize',20);
                title('Y diff 2','fontsize',fontSize)
                
                % 3th diff
                subplotArray(5) = subplot(3,2,5);
                plot(obj.pathLength.diff3.x,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff3.x)]));
                xlabel('Samples','fontsize',20);
                title('X diff 3','fontsize',fontSize)
                
                subplotArray(6) = subplot(3,2,6);
                plot(obj.pathLength.diff3.y,'LineWidth',2 )
                xlim(([1 numel(obj.pathLength.diff3.y)]));
                xlabel('Samples','fontsize',20);
                title('Y diff 3','fontsize',fontSize)
                linkaxes(subplotArray,'x');
                subplotArray=[];
            end
            
            % --------------------- Filtered joystick path length ----------------------------
            if( isprop(obj,'filteredPathLength'))
                fontSize = 20;
                time = seconds(0:(size(obj.filteredPathLength.d,1)-1))*0.020 + startTime;
                tzOffset = tzoffset(startTime);
                
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                nrPlots = sum(showJoystickPath);
                subplotArray(1) = subplot(1 + (nrPlots>0),2,1:2);
                plot(time,obj.filteredPathLength.d,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Filtered Instantaneous joystick path length' ];
                
                title(Title,'fontsize',20);
                
                if showJoystickPath(1)
                    subplotArray(2) = subplot(1 + (nrPlots>0),2,3:3+(nrPlots==1));
                    plot(time,obj.filteredPathLength.dx ,'LineWidth',2)
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                    title('Filtered dx','fontsize',fontSize)
                    
                end
                
                if showJoystickPath(2)
                    subplotArray(3-(nrPlots==1)) = subplot(1 + (nrPlots>0),2,4-(nrPlots==1):4);
                    plot(time,obj.filteredPathLength.dy,'LineWidth',2 )
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                    title('Filtered dy','fontsize',fontSize)
                end
                linkaxes(subplotArray,'x');
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                plot(time,obj.filteredPathLength.cumd,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                text(time(50),obj.filteredPathLength.cumd(end), "Filtered CJPL score: " + round(obj.filteredPathLength.scoreD),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.filteredPathLength.cumd(end)*0.95, "Filtered smoothness NJS: " + round(obj.filteredPathLength.smoothness),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                
                %                 ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Filtered Cumulative Joystick Path Length (CJPL)' ];
                
                title(Title,'fontsize',20);
                display( "Filtered CJPL score: " + round(obj.filteredPathLength.scoreD));
                display("Filtered smoothness NJS: " + round(obj.filteredPathLength.smoothness)');
            end
            
        end
        
        %%  Joystick functions
        function obj  = joystickPathLength(obj)
            if sum(obj.datatype == (161:163))
                
                if( ~isprop(obj,'pathLength'))
                    obj.addprop('pathLength');
                end
                
                if( ~isprop(obj,'time'))
                    obj.addprop('time');
                end
                
                obj.pathLength.dx = [0; obj.data(2).values(2:end)-obj.data(2).values(1:end-1)]; % turn
                obj.pathLength.dy = [0; obj.data(3).values(2:end)-obj.data(3).values(1:end-1)]; % speed
                obj.pathLength.d = sqrt(obj.pathLength.dx.^2 + obj.pathLength.dy.^2);
                obj.pathLength.d(isnan(obj.pathLength.d))=0;
                obj.pathLength.cumd = cumsum(obj.pathLength.d);
                obj.pathLength.scoreD = obj.pathLength.cumd(end);
                [obj.pathLength.smoothness, obj.time.effective_raw]= obj.joystickSmoothness(2,obj.pathLength.scoreD);
                x= obj.data(2).values;
                x(isnan(x))=0;
                y= obj.data(2+1).values;
                y(isnan(y))=0;
                obj.pathLength.diff1.x= diff(x,1);
                obj.pathLength.diff1.y= diff(y,1);
                obj.pathLength.diff2.x= diff(x,2);
                obj.pathLength.diff2.y= diff(y,2);
                obj.pathLength.diff3.x= diff(x,3);
                obj.pathLength.diff3.y= diff(y,3);
                
                if  obj.filtered
                    if( ~isprop(obj,'filteredPathLength'))
                        obj.addprop('filteredPathLength');
                    end
                    
                    if obj.datatype == 162
                        obj.filteredPathLength.dx = [0; obj.data(9).values(2:end)-obj.data(9).values(1:end-1)]; % turn
                        obj.filteredPathLength.dy = [0; obj.data(10).values(2:end)-obj.data(10).values(1:end-1)]; % speed
                        obj.filteredPathLength.d = sqrt(obj.filteredPathLength.dx.^2 + obj.filteredPathLength.dy.^2);
                        obj.filteredPathLength.d(isnan(obj.filteredPathLength.d))=0;
                        obj.filteredPathLength.cumd = cumsum(obj.filteredPathLength.d);
                        obj.filteredPathLength.scoreD = obj.filteredPathLength.cumd(end);
                        [obj.filteredPathLength.smoothness, obj.time.effective_filtered] = obj.joystickSmoothness(9,obj.filteredPathLength.scoreD);
                        x= obj.data(9).values;
                        x(isnan(x))=0;
                        y= obj.data(9+1).values;
                        y(isnan(y))=0;
                        obj.filteredPathLength.diff1.x= diff(x,1);
                        obj.filteredPathLength.diff1.y= diff(y,1);
                        obj.filteredPathLength.diff2.x= diff(x,2);
                        obj.filteredPathLength.diff2.y= diff(y,2);
                        obj.filteredPathLength.diff3.x= diff(x,3);
                        obj.filteredPathLength.diff3.y= diff(y,3);
                    else
                        obj.filteredPathLength.dx = [0; obj.data(8).values(2:end)-obj.data(8).values(1:end-1)]; % turn
                        obj.filteredPathLength.dy = [0; obj.data(9).values(2:end)-obj.data(9).values(1:end-1)]; % speed
                        obj.filteredPathLength.d = sqrt(obj.filteredPathLength.dx.^2 + obj.filteredPathLength.dy.^2);
                        obj.filteredPathLength.d(isnan(obj.filteredPathLength.d))=0;
                        obj.filteredPathLength.cumd = cumsum(obj.filteredPathLength.d);
                        obj.filteredPathLength.scoreD = obj.filteredPathLength.cumd(end);
                        [obj.filteredPathLength.smoothness, obj.time.effective_filtered] = obj.joystickSmoothness(8,obj.filteredPathLength.scoreD);
                        x= obj.data(8).values;
                        x(isnan(x))=0;
                        y= obj.data(8+1).values;
                        y(isnan(y))=0;
                        obj.filteredPathLength.diff1.x= diff(x,1);
                        obj.filteredPathLength.diff1.y= diff(y,1);
                        obj.filteredPathLength.diff2.x= diff(x,2);
                        obj.filteredPathLength.diff2.y= diff(y,2);
                        obj.filteredPathLength.diff3.x= diff(x,3);
                        obj.filteredPathLength.diff3.y= diff(y,3);
                    end
                    
                end
            end
        end
        function [NJS_e, t] = joystickSmoothness(obj,startIndex,scoreD)
            x= obj.data(startIndex).values;
            x(isnan(x))=[];
            y= obj.data(startIndex+1).values;
            y(isnan(y))=[];
            t = sum(~isnan(obj.data(startIndex).values))*0.020;
            po_e=(diff(x,3)).^2+(diff(y,3)).^2;
            NJS_e=(0.5*sum(po_e)*(t^5)/(scoreD^2)).^0.5;
            clear x  y
        end
    end
    
    
end