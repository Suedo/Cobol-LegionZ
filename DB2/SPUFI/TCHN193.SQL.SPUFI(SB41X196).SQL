    SELECT * FROM COURSE_REG2 WHERE ENTRNCE_SCORE =                     00040000
               ( SELECT MIN(ENTRNCE_SCORE) FROM COURSE_REG2             00050000
        WHERE ENTRNCE_SCORE NOT IN (SELECT MIN(ENTRNCE_SCORE) FROM      00060000
 COURSE_REG2))                                                          00070000
                                                                        00080000
   SELECT * FROM COURSE_REG2                                            00090000
   WHERE (ENTRNCE_SCORE > 65 AND ENTRNCE_SCORE <75) AND                 00100000
   LEFT(UCASE(COURSE_NAME),3) = 'B.E'                                   00110000
