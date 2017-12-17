drop sequence activity_type_activity_id_seq;
drop sequence game_game_id_seq ;
drop sequence game_involvement_id_seq;
drop sequence location_location_id_seq;
drop sequence team_team_id_seq ;
drop sequence person_person_id_seq;
drop sequence team_membership_id_seq ;

drop table activity_type cascade constraints;

drop table game cascade constraints;

drop table game_involvement cascade constraints;

drop table location cascade constraints;

drop table person cascade constraints;

drop table team cascade constraints;

drop table team_membership cascade constraints;

create table activity_type (
  activity_id     number(10) not null,
  activity_name   varchar2(50)
);

create unique index activity_type_activity_id_idx on
  activity_type ( activity_id asc );

create unique index activity_type_activity_name_idx on
  activity_type ( activity_name asc );

alter table activity_type add constraint activity_type_pk primary key ( activity_id );

alter table activity_type add constraint activity_type_activity_name_uk unique ( activity_name );

create table game (
  game_id           number(10) not null,
  home_team_id      number not null,
  guest_team_id     number(10) not null,
  game_start_date   date,
  season            date,
  location_id       number(10) not null
);

create unique index game_game_id_idx on
  game ( game_id asc );

create unique index game_home_team_id_guest_team_id_game_start_date_season_idx on
  game (
    home_team_id
  asc,
    guest_team_id
  asc,
    game_start_date
  asc,
    season
  asc );

create index game_guest_team_id_idx on
  game ( guest_team_id asc );

create index game_location_id_idx on
  game ( location_id asc );

alter table game add constraint game_pk primary key ( game_id );

alter table game
  add constraint game_uk unique ( home_team_id,
  guest_team_id,
  game_start_date,
  season );

create table game_involvement (
  id                    number(30) not null,
  game_id               number(10) not null,
  person_id             number(10) not null,
  type_of_involvement   number(10) not null,
  is_active             number not null
);

create unique index game_involvement_id_idx on
  game_involvement ( id asc );

create unique index game_involvement_idx on
  game_involvement (
    game_id
  asc,
    person_id
  asc,
    type_of_involvement
  asc );

create index game_involvement_type_idx on
  game_involvement ( type_of_involvement asc );

create index game_involvement_person_id_idx on
  game_involvement ( person_id asc );

alter table game_involvement add constraint game_involvement_pk primary key ( id );

alter table game_involvement
  add constraint game_involvement_uk unique ( game_id,
  person_id,
  type_of_involvement );

create table location (
  location_id   number(10) not null,
  gym_name      varchar2(100 char),
  street        varchar2(100 char),
  zip_code      number(5),
  city          varchar2(100 char)
);

create unique index location_location_id_idx on
  location ( location_id asc );

create unique index location_gym_name_idx on
  location ( gym_name asc );

alter table location add constraint location_pk primary key ( location_id );

alter table location add constraint location_gym_name_uk unique ( gym_name );

create table person (
  person_id        number(10) not null,
  first_name       varchar2(50 char),
  last_name        varchar2(50 char),
  licence_number   varchar2(6 char),
  birthday         date,
  is_coach         number,
  is_player        number,
  is_active        number
);

create unique index person_person_id_idx on
  person ( person_id asc );

create unique index person_licence_number_idx on
  person ( licence_number asc );

alter table person add constraint person_pk primary key ( person_id );

alter table person add constraint person_licence_number_uk unique ( licence_number );

create table team (
  team_id     number(10) not null,
  team_name   varchar2(50 char)
);

create unique index team_team_id_idx on
  team ( team_id asc );

create unique index team_team_name_idx on
  team ( team_name asc );

alter table team add constraint team_pk primary key ( team_id );

alter table team add constraint team_team_name_uk unique ( team_name );

create table team_membership (
  id                   number(30) not null,
  person_id            number(10) not null,
  team_id              number(10) not null,
  type_of_membership   number(10) not null
);

create unique index team_membership_id_idx on
  team_membership ( id asc );

create index team_membership_person_id_idx on
  team_membership ( person_id asc );

create index team_membership_type_idx on
  team_membership ( type_of_membership asc );

create index team_membership_team_id_idx on
  team_membership ( team_id asc );

alter table team_membership add constraint team_membership_pk primary key ( id );

alter table game_involvement
  add constraint game_involvement_activity_type_fk foreign key ( type_of_involvement )
    references activity_type ( activity_id );

alter table game_involvement
  add constraint game_involvement_game_fk foreign key ( game_id )
    references game ( game_id );

alter table game_involvement
  add constraint game_involvement_person_fk foreign key ( person_id )
    references person ( person_id );

alter table game
  add constraint game_location_fk foreign key ( location_id )
    references location ( location_id );

alter table game
  add constraint game_team_fk foreign key ( guest_team_id )
    references team ( team_id );

alter table team_membership
  add constraint team_membership_activity_type_fk foreign key ( type_of_membership )
    references activity_type ( activity_id );

alter table team_membership
  add constraint team_membership_person_fk foreign key ( person_id )
    references person ( person_id );

alter table team_membership
  add constraint team_membership_team_fk foreign key ( team_id )
    references team ( team_id );

create sequence activity_type_activity_id_seq start with 1 nocache order;

create or replace trigger activity_type_activity_id_trg before
  insert on activity_type
  for each row
  when ( new.activity_id is null )
begin
  :new.activity_id   := activity_type_activity_id_seq.nextval;
end;
/

create sequence game_game_id_seq start with 1 nocache order;

create or replace trigger game_game_id_trg before
  insert on game
  for each row
  when ( new.game_id is null )
begin
  :new.game_id   := game_game_id_seq.nextval;
end;
/

create sequence game_involvement_id_seq start with 1 nocache order;

create or replace trigger game_involvement_id_trg before
  insert on game_involvement
  for each row
  when ( new.id is null )
begin
  :new.id   := game_involvement_id_seq.nextval;
end;
/

create sequence location_location_id_seq start with 1 nocache order;

create or replace trigger location_location_id_trg before
  insert on location
  for each row
  when ( new.location_id is null )
begin
  :new.location_id   := location_location_id_seq.nextval;
end;
/

create sequence person_person_id_seq start with 1 nocache order;

create or replace trigger person_person_id_trg before
  insert on person
  for each row
  when ( new.person_id is null )
begin
  :new.person_id   := person_person_id_seq.nextval;
end;
/

create sequence team_team_id_seq start with 1 nocache order;

create or replace trigger team_team_id_trg before
  insert on team
  for each row
  when ( new.team_id is null )
begin
  :new.team_id   := team_team_id_seq.nextval;
end;
/

create sequence team_membership_id_seq start with 1 nocache order;

create or replace trigger team_membership_id_trg before
  insert on team_membership
  for each row
  when ( new.id is null )
begin
  :new.id   := team_membership_id_seq.nextval;
end;
/
