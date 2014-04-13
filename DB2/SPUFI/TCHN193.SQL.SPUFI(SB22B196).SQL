drop table bus_det2;                                                    00001007
create table bus_det2(bus_num2 char(4) not null,bus_start char(15),     00010002
                      bus_end char(15),per_stop_fare decimal(4,2),      00020005
                      constraint fk primary key(bus_num2)               00030005
                     ) in dbtchn02.tscep01;                             00040006
create unique index budeidx on bus_det2(bus_num2);                      00050000
