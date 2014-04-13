--create table TB_employee                                              00010000
 drop table tb_employee;                                                00011001
 CREATE table TB_employee (EMPID smallint NOT NULL primary key,         00020000
                           EMPname varchar(20),                         00030000
                           EMPADDR varchar(20))in                       00040000
                                         DBTCHN02.TSCEP01;              00041000
 create unique index tbempk on tb_employee(empid);                      00050000
