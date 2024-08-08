USE PRACTICA1;

-- Eliminacion de registros que tengan ArrivalAirport = 0
DELETE FROM FlightTemp WHERE ArrivalAirport = '0';

-- Eliminación de registros que tienen AirportName que inicie con -
DELETE FROM FlightTemp WHERE AirportName LIKE '-%';

-- Eliminación de Registros donde la longitud de ArrivalAirport sea diferente de 3
DELETE FROM FlightTemp WHERE LEN(ArrivalAirport) != 3;

-- Modificación en la que en Nationality se le borra a los registros que encuentre la coma la misma más lo que le sigue
UPDATE FlightTemp
    SET Nationality = LEFT(Nationality, CHARINDEX(',', Nationality + ',') - 1)
WHERE CHARINDEX(',', Nationality) > 0;

-- Modificación en la que en CountryName se le borra a los registros que encuentre la coma la misma más lo que le sigue
UPDATE FlightTemp
    SET CountryName = LEFT(CountryName, CHARINDEX(',', CountryName + ',') - 1)
WHERE CHARINDEX(',', CountryName) > 0;

-- Eliminación de caracteres especiales a excepción de los valores alfanuméricos, tíldes y ñ
UPDATE FlightTemp
    SET AirportName = REPLACE(AirportName, SUBSTRING(AirportName, PATINDEX('%[^a-zA-ZáéíóúÁÉÍÓÚñÑ0-9 ]%', AirportName), LEN(AirportName)), '')
WHERE PATINDEX('%[^a-zA-ZáéíóúÁÉÍÓÚñÑ0-9 ]%', AirportName) > 0;

-- Eliminación de duplicados ArrivalAirport con AirportName
DELETE FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportName) > 1
);

-- Eliminación de duplicados ArrivalAirport AirportCountryCode
DELETE FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportCountryCode) > 1
);

-- Eliminación de duplicados ArrivalAirport con AirportContinent
DELETE FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportContinent) > 1
);

-- Borrar de la tabla los registros que no contengan las siguientes características
DELETE FROM FlightTemp
WHERE NOT (
	UPPER(AirportName) LIKE '%AIR%' 
	OR UPPER(AirportName) LIKE '%NAVAL%'
	OR UPPER(AirportName)  LIKE '%DROM%'
	OR UPPER(AirportName) LIKE '%FIELD%'
	OR UPPER(AirportName) LIKE '%BASE%'
	OR UPPER(AirportName) LIKE '%PLANE%'
	OR UPPER(AirportName) LIKE '%AIRPORT%'
	OR UPPER(AirportName)  LIKE '%PORT%'
	OR UPPER(AirportName)  LIKE '%HELI%'
	OR UPPER(AirportName)  LIKE '%AERO%'
	OR UPPER(AirportName)  LIKE '%RAF%'
);

