USE PRACTICA1;

BULK INSERT Temporal
FROM 'C:/Users/Pacos/Desktop/Proyectos/SS2_2S2024_201906051/Pruebas/DataSet.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    DATAFILETYPE = 'char',
    TABLOCK
);