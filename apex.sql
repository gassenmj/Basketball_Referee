begin
  wwv_flow_api.set_security_group_id(1962231797035357); --workspace id
  wwv_flow.g_flow_id := 41; --application id
  wwv_flow.g_instance := 16055230273497;   --session id;
end;
/

select * from apex_application_temp_files ;

delete from apex_application_temp_files;

select * from logger.logger_logs_5_min;

--truncate table logger.logger_logs cascade;
    