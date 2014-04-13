-- select the bus details whose total stops is between 15 and 20        00001000
 SELECT * FROM BUSORG_DET2 WHERE BUS_STOP_TOT BETWEEN 15 AND 20;        00010001
                                                                        00020001
-- select the bus details whose bus type not in {AC, DX}                00030001
 SELECT * FROM BUSORG_DET2 WHERE BUS_TYP NOT IN ('AC','DX');            00040001
