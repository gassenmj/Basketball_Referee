insert into person (first_name,last_name,licence_number,birthday) values (
'Jonas','Gassenmeyer','33235',to_date('02.03.1988 00:00:00'));

insert into person (first_name,last_name,licence_number,birthday, is_coach) values (
'Georgina','Joerges','565656',to_date('11.09.1982 00:00:00'),1);

insert into person (first_name,last_name,licence_number,birthday, is_player ) values (
'Vanessa','Korte','445566',to_date('02.06.1990 00:00:00'),1);

insert into person (first_name,last_name,licence_number,birthday,is_player) values (
'Marko','Milavanovic','12345',to_date('19.03.1995 00:00:00'),1);

insert into person (first_name,last_name,licence_number,birthday,is_player,is_coach) values (
'Jens','Gloeser','133345',to_date('11.11.1992 00:00:00'),1,1);

commit;

insert into team ( team_name ) values ('SV Dreicheinhain');
insert into team ( team_name ) values ('TV Langen');
insert into team ( team_name ) values ('Opel Skyliners');
insert into team ( team_name ) values ('FTG Frankfurt');
insert into team ( team_name ) values ('SG Weiterstadt');

insert into team ( team_name ) values ('SV Dreicheinhain U18');
insert into team ( team_name ) values ('SV Dreicheinhain Damen2');
insert into team ( team_name ) values ('SV Dreicheinhain U16M');
insert into team ( team_name ) values ('SV Dreicheinhain Herren1');

commit;

insert into activity_type (activity_name) values ('Referee');
insert into activity_type (activity_name) values ('Coach');
insert into activity_type (activity_name) values ('Player');

commit;

insert into team_membership (person_id,team_id,type_of_membership) values (2,7,2);
insert into team_membership (person_id,team_id,type_of_membership) values (4,6,3);
insert into team_membership (person_id,team_id,type_of_membership) values (3,7,3);
insert into team_membership (person_id,team_id,type_of_membership) values (5,8,2);
insert into team_membership (person_id,team_id,type_of_membership) values (5,9,3);
commit;

insert into location (gym_name,street,zip_code,city) values (
'Weibel-Dome','Am Tauben 14',60555,'Dreieich');

insert into location (gym_name,street,zip_code,city) values (
'Ballsporthalle','Wo der Pfeffer waechst',60445,'Frankfurt');

insert into location (gym_name,street,zip_code,city) values (
'Oracle Arena','Silc Valley',43438,'San Francisco');

commit;

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
6,7,to_date('02.01.2018 14:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
6,3,to_date('03.01.2018 11:00:00'),to_date('01.01.2018 00:00:00'),2);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
8,5,to_date('11.02.2018 18:00:00'),to_date('01.01.2018 00:00:00'),3);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
9,4,to_date('01.03.2018 20:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
1,9,to_date('18.02.2018 17:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
7,3,to_date('20.02.2018 17:00:00'),to_date('01.01.2018 00:00:00'),3);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
1,6,to_date('02.01.2018 14:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
2,8,to_date('03.01.2018 11:00:00'),to_date('01.01.2018 00:00:00'),2);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
4,8,to_date('11.02.2018 18:00:00'),to_date('01.01.2018 00:00:00'),3);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
8,9,to_date('01.03.2018 20:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
7,8,to_date('18.02.2018 17:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
7,6,to_date('20.02.2018 17:00:00'),to_date('01.01.2018 00:00:00'),3);



insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
1,2,to_date('02.01.2018 14:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
2,9,to_date('03.01.2018 11:00:00'),to_date('01.01.2018 00:00:00'),2);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
9,7,to_date('11.02.2018 18:00:00'),to_date('01.01.2018 00:00:00'),3);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
1,3,to_date('01.03.2018 20:00:00'),to_date('01.01.2018 00:00:00'),1);

insert into game (home_team_id,guest_team_id,game_start_date,season,location_id) values (
1,5,to_date('18.02.2018 17:00:00'),to_date('01.01.2018 00:00:00'),1);

commit;

select * 
from game_involvement gi  
join person p on gi.person_id = p.person_id
join game ga on ga.game_id = gi.game_id
join team ht on ga.home_team_id = ht.team_id
join team gt on ga.guest_team_id = gt.team_id;

select ga.game_start_date, l.gym_name , to_char(ga.season,'YYYY') season, ht.team_name ||' vs. '|| gt.team_name pair 
from game ga
join team ht on ga.home_team_id = ht.team_id
join team gt on ga.guest_team_id = gt.team_id
join location l on l.location_id = ga.location_id;



--games that overlap each other
select g1.game_id,g1.game_start_date,g2.game_id 
from game g1
join game g2 on g2.game_id != g1.game_id
where g2.game_start_date between g1.game_start_date - interval '1' hour  
                                       and g1.game_start_date + interval '1' hour  
and g1.game_id = 1
;

--where and how is somebody involved in a game
select p.first_name,g.home_team_id,g.guest_team_id,g.game_start_date
,(select a.activity_name from activity_type a where a.activity_id = m.type_of_membership) do_as
from person p
join team_membership m on m.person_id = p.person_id
join team t on m.team_id = t.team_id
join game g on t.team_id = g.home_team_id or t.team_id = g.guest_team_id;
