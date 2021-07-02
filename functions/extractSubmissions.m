% ------------------------------------------------------------------------------------
%---------------  Extraction of NOMADe submissions  ---------------
% ------------------------------------------------------------------------------------



% create filename
filename =[datestr(now,'yyyy-mm-dd HH-MM')   '_questionnaires.xlsx'];
 filename = fullfile(pwd,filename);
 i=0;
  while exist(filename, 'file') == 2
      i = i+1;
      filename =[datestr(now,'yyyy-mm-dd HH-MM')   '_questionnaires V' int2str(i) '.xlsx'];
        filename = fullfile(pwd,filename);
  end
  
          %% Connection to the database
  
            if isfile("../jdbc/mysql-connector-java-8.0.18.jar")
                javaclasspath("../jdbc/mysql-connector-java-8.0.18.jar");
            elseif isfile("../mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar")
                % legacy jdbc location
                javaclasspath("../mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar");
            else
                error("JDBC MySQL Connector not found, please download the connector from https://dev.mysql.com/downloads/connector/j/ and extract it in the 'jdbc' directory. Note: the mysql-connector-java-8.0.18.jar musn't be placed in a subdirectory, but directly in the root of the jdbc directory.");
            end

            databaseName = "nomade";
            username = "nomade-dev";
            disp([' NOMADe DB username: ' char(username)]);
            if isfile("password.mat")
                load password.mat password;
            end
            if ~exist('password','var')
                password = input(' NOMADe DB password: ','s');
                store_password = input(' store this password (Y/N): ','s');
                if store_password == "Y" || store_password == "y" || store_password == "yes"
                    save password.mat password;
                    warning off backtrace;
                    warning("Password saved to 'password.mat' file");
                    warning on backtrace;
                end
            else
                disp(' NOMADe DB password (retrieved from file)');
            end
            
            jdbcDriver = "com.mysql.cj.jdbc.Driver";
            server = "jdbc:mysql://clouddb.myriade.be:20100/";
            
            
            conn = database(databaseName, username, password, jdbcDriver, server);
            %% Get submissions
         startSubmissionID= 600;
         endSubmissionID= 623;
         
                    sqlquery = ['SELECT TRIM(`submissions`.`id`) AS `submissionID`, '...
                     '               TRIM(`users`.`username`) AS `username`, '...  
                     '               TRIM(`t4`.`name_en`) AS `questionnaire`, '...  
                     '               TRIM(`t`.`question_id`) AS `questionID`, '... 
                     '               TRIM(`t2`.`name_en`) AS `question`, '...        
                     '               TRIM(`t3`.`name_en`) AS `prefix answer`, '...    
                     '              TRIM(`t`.`value`) AS `answer text`, '...    
                     '              TRIM(`submissions`.`created_at`) AS `submission date` '...    
                     '                 FROM `submissions` '...
                     ' INNER JOIN `submission_answers`  AS `t` '...
                     ' ON `submissions`.`id` = `t`.`submission_id` '...
                     ' INNER JOIN `questions`  AS `t2` '...
                     ' ON `t`.`question_id` = `t2`.`id`  '...
                     ' INNER JOIN `answers`  AS `t3` '...
                     ' ON `t`.`answer_id` = `t3`.`id` '...     
                     ' INNER JOIN `users`   '...
                     ' ON `submissions`.`user_id` = `users`.`id` '...
                     ' INNER JOIN `questionnaires` AS `t4`   '...
                     ' ON `submissions`.`questionnaire_id` = `t4`.`id` '...
                     '          WHERE (`submissions`.`id` BETWEEN ' int2str(startSubmissionID) ' AND ' int2str(endSubmissionID) ');'];  
                     
                   extract = select( conn,sqlquery);
             
         

   
        writetable(extract,filename,'Range','A1')
