--drop table bus;                                                       00001008
create table bus(bus_num2 char(4) not null,bus_start varchar(15),       00010008
                      bus_end varchar(15),per_stop_fare decimal(4,2),   00020008
                      constraint fk primary key(bus_num2)               00030005
                     ) in dbtchn02.tscep01;                             00040006
create unique index budasdx on bus(bus_num2);                           00050008
