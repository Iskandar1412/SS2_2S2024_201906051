USE PRACTICA1;

BULK INSERT FlightTemp
FROM 'C:\CSV\DataSet.csv'
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', -- \n
    CODEPAGE = 'UFT-8',
    DATAFILETYPE = 'char',
    TABLOCK
);
