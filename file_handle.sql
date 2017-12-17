create or replace package file_handle is 
 procedure ical_file_parser(p_name in varchar2);
end file_handle;
/
create or replace package file_handle is
    procedure ical_file_parser(p_name in varchar2) is 
    
      type t_stringtab is table of varchar2(500);
      l_var t_stringtab;
            
      c_delimiter constant varchar2(1) := '$'; 
      c_delimiter_loc constant varchar2(5) := '\,';
      l_offset number := 1;
      l_end    number;
      l_hit    number;
      l_clob   clob;
      l_len    number ;
      l_end_str    number;
      l_start_str  number;
      l_current_event varchar2(4000);
      l_current_str varchar2(1000);
      c_pattern_begin  constant varchar2(12) := 'BEGIN:VEVENT';
      c_pattern_end  constant varchar2(30) := 
                    'ORGANIZER:'||c_delimiter||c_delimiter||'END:VEVENT';
           
      c_location_pattern varchar2(30) := 'LOCATION:';
      c_startdate_pattern varchar2(30) := 'DTSTART:';
      c_teams_pattern varchar2(30) := 'SUMMARY:';
      c_enddate_pattern varchar2(30) := 'DTEND:';
            
      l_patterns sys.odciVarchar2List :=
                 sys.odciVarchar2List(c_teams_pattern,c_location_pattern,c_startdate_pattern,c_enddate_pattern);
           
      procedure get_start_and_end(p_str in varchar2, p_search in varchar2 , p_start out number, p_end out number)
      is
            
      begin
        p_start := instr(l_current_event,p_search) + length(p_search);
        p_end := instr(l_current_event,c_delimiter,instr(l_current_event,p_search));
      end get_start_and_end;
           
      function string2table ( 
                invarchar     in varchar2, 
                indelimiter   in varchar2 
            ) return t_stringtab is v_return   t_stringtab; 
      begin 
             
              with tab as( 
              --only distinct values, because a precaution is unique 
              select distinct regexp_substr(   invarchar 
                                    , '[^'||indelimiter||']+'   --dash for negiation ("everything except the delimiter") 
                                    , 1                         --always start at 1st character 
                                    , level                     --but return nth occurence 
                                  ) substr ,level lvl
              from dual 
              --basicly repeats the String as long as there is another substring 
              connect by level <= length ( 
                                          --replces all except the delimiters 
                                          regexp_replace (invarchar, '[^'||indelimiter||']+') 
                                          ) + 1 --one more string than number of delimiters 
                          ) 
              select substr 
              bulk collect into v_return 
              from tab 
              where substr is not null
              order by lvl
              ; 
               
              return v_return; 
    
      end string2table; 
           
      procedure make_it_fit(p_pattern varchar2,p_str varchar2)
      is
      begin
            if p_pattern = c_location_pattern then 
             l_var := string2table(p_str,c_delimiter_loc);
             
             for i in l_var.first .. l_var.last loop
              dbms_output.put_line(l_var(i));
             end loop;
            elsif p_pattern = c_teams_pattern then
             l_var := string2table(p_str,c_delimiter_loc);
             dbms_output.put_line('Paarung: '||replace(l_var(2),'-',' vs. '));
            elsif p_pattern in (c_startdate_pattern,c_enddate_pattern) then
             begin
              dbms_output.put_line(to_char(to_date(p_str,'YYYYMMDD"T"hh24miss"Z"')));
             exception when others then
              dbms_output.put_line('SOMETHING WRONG WITH: '||p_str);
             end;
            end if;
           end make_it_fit;
    begin
           
           select BLOB_CONTENT into l_clob 
           from apex_application_temp_files 
           where name = --p_name
           '2362058937104653/Spielplan_DA-BCWI1_14-12-2017_bis_10-03-2018.ics';
    
            l_len := dbms_lob.getlength( l_clob );
            --turning newlines into a space   
            l_clob := translate( l_clob, chr(13)|| chr(10) || chr(9), c_delimiter||c_delimiter||c_delimiter ) ;
             
             loop
                     dbms_output.put_line('--------------------');
                     
                     l_hit := instr( l_clob, c_pattern_begin , l_offset );
                     exit when nvl(l_hit,0) = 0;
                     l_end := instr( l_clob, c_pattern_end , l_hit );
                    
                     l_current_event := substr( l_clob, l_hit+ length(c_pattern_begin) +1, l_end-(l_hit+ length(c_pattern_begin)+1) ) ;
                     
                     --when the initial file contained new line, a space was put in the beginning...
                     --hence we remove it...
                     l_current_event := replace(l_current_event,'$$ ');
                     
                     for i in l_patterns.first..l_patterns.last loop
                         get_start_and_end(l_current_event,l_patterns(i),l_start_str,l_end_str);
                         l_current_str := substr(l_current_event,l_start_str,l_end_str - l_start_str);
                         make_it_fit(l_patterns(i),l_current_str);
                     end loop;
     
                     l_offset := l_end;
             end loop;
    end;
    end ical_file_parser;
end file_handle;
/