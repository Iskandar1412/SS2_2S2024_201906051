USE PRACTICA1;

BULK INSERT Temporal
FROM ''
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    CODEPAGE = 'UTF-8',
    DATAFILETYPE = 'Char',
    TABLOCK
);