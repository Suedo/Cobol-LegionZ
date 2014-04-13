drop table busorg_det2;                                                 00010006
create table busorg_det2(bus_num char(4) not null,bus_stop_tot integer, 00020001
                         bus_typ char(3) not null,                      00030001
                         constraint pk primary key(bus_num,bus_typ),    00040003
                         constraint ck check(bus_typ in                 00050003
                                             ('AC','DX','UDX','NOR')))  00060004
                                           in dbtchn02.tscep01;         00061005
create unique index buoidx on busorg_det2(bus_num,bus_typ);             00070000
