-- drop table busorg;                                                   00010007
create table busorg(bus_num char(4) not null,                           00020007
                         bus_stop_tot integer,                          00021007
                         bus_typ char(3) not null,                      00030001
                         constraint pk primary key(bus_num,bus_typ),    00040003
                         constraint ck check(bus_typ in                 00050003
                                             ('AC','DX','UDX','NOR')))  00060004
                                           in dbtchn02.tscep01;         00061005
create unique index buo11x on busorg(bus_num,bus_typ);                  00070007
