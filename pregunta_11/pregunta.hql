/*

Pregunta
===========================================================================

Escriba una consulta que retorne la primera columna, la cantidad de 
elementos en la columna 2 y la cantidad de elementos en la columna 3

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

*/

DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;

DROP TABLE IF EXISTS DATOS;
create table DATOS as 
select c1, SIZE(c2) AS c2, SIZE(c3) as c3 from t0;

INSERT OVERWRITE DIRECTORY 'output/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
select c1, c2, c3 from DATOS;
