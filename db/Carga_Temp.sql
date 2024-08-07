USE PRACTICA1;

BULK INSERT FlightTemp
FROM 'C:\CSV\mod.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a', -- \n
    CODEPAGE = 'UFT-8',
    DATAFILETYPE = 'char',
    TABLOCK
);
