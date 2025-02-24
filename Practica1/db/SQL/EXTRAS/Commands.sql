USE PRACTICA1;
SELECT * FROM FlightTemp;

SELECT COUNT(*) FROM FlightTemp;
DELETE FROM FlightTemp;

SELECT * 
FROM FlightTemp
WHERE CountryName = 'Venezuela, Bolivarian Republic of';

SELECT *
FROM FlightTemp
WHERE AirportName = 'Cheongju International Airport/Cheongju Air Base (K-59/G-513)'; 

SELECT *
FROM FlightTemp
WHERE AirportName LIKE '+%-%';

SELECT *
FROM FlightTemp
WHERE AirportName LIKE '%[-]%';

SELECT COUNT(*)
FROM FlightTemp
WHERE AirportName LIKE '%[@\-ç¦+©ªø®]%';

SELECT *
FROM FlightTemp
WHERE Nationality  LIKE '%,%';

SELECT *
FROM FlightTemp
WHERE Nationality LIKE '%,%'
  OR CountryName LIKE '%,%';


SELECT *
FROM FlightTemp
WHERE AirportName LIKE '%,%';

SELECT *
FROM FlightTemp
WHERE AirportName LIKE '%/%';

SELECT *
FROM FlightTemp
WHERE AirportName LIKE '%(%/%)';

SELECT *
FROM FlightTemp
WHERE AirportName LIKE '+%-%,%';

SELECT *
FROM FlightTemp
WHERE ArrivalAirport = '0'
   OR ArrivalAirport LIKE '%,%'
   OR ArrivalAirport LIKE '%,'
   OR ArrivalAirport LIKE ',%';
  
SELECT COUNT(*)
FROM FlightTemp
WHERE ArrivalAirport = '0'
   OR ArrivalAirport LIKE '%,%'
   OR ArrivalAirport LIKE '%,'
   OR ArrivalAirport LIKE ',%';

SELECT *
FROM FlightTemp
WHERE AirportName = '0'
   OR AirportName LIKE '%,%'
   OR AirportName LIKE '%,'
   OR AirportName LIKE ',%';
   
SELECT *
FROM FlightTemp
WHERE AirportCountryCode = '0'
   OR AirportCountryCode LIKE '%,%'
   OR AirportCountryCode LIKE '%,'
   OR AirportCountryCode LIKE ',%';
   
SELECT *
FROM FlightTemp
WHERE ContinentName = '0'
   OR ContinentName LIKE '%,%'
   OR ContinentName LIKE '%,'
   OR ContinentName LIKE ',%';
   
SELECT ArrivalAirport, COUNT(*)
from FlightTemp
where LEN(ArrivalAirport) != 3
group by ArrivalAirport 
HAVING count(*) > 1;

select COUNT(*)
FROM FlightTemp
WHERE (
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
