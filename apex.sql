begin
  wwv_flow_api.set_security_group_id(1962231797035357); --workspace id
  wwv_flow.g_flow_id := 41; --application id
  wwv_flow.g_instance := 6705501620021;   --session id;
end;
/

select * from apex_application_temp_files ;
    