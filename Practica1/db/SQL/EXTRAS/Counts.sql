SELECT * from Airport;
SELECT count(*) from Flight;

SELECT * from Temporal;

SELECT AirportName , COUNT(*)
FROM FlightTemp
GROUP BY AirportName 
HAVING COUNT(*) > 1;

SELECT AirportName, AirportCountryCode, AirportContinent, COUNT(*)
FROM Airport
GROUP BY AirportName, AirportCountryCode, AirportContinent 
HAVING COUNT(*) > 1;

SELECT ContinentName , COUNT(*)
FROM Continent
GROUP BY ContinentName 
HAVING COUNT(*) > 1;

SELECT ArrivalAirport, FlightStatus , COUNT(*)
FROM Flight
GROUP BY ArrivalAirport, FlightStatus 
HAVING COUNT(*) > 1;

SELECT PassengerID , COUNT(*)
FROM FlightDetails
GROUP BY PassengerID 
HAVING COUNT(*) > 1;

SELECT Nationality, COUNT(*)
FROM Nationality
GROUP BY Nationality  
HAVING COUNT(*) > 1;

SELECT  PilotName , COUNT(*)
FROM Pilot 
GROUP BY PilotName 
HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM FlightTemp
WHERE NOT (
	UPPER(AirportName) LIKE '%AIR%' 
	OR UPPER(AirportName) LIKE '%NAVAL%'
	OR UPPER(AirportName)  LIKE '%DROM%'
	OR UPPER(AirportName) LIKE '%FIELD%'
	OR UPPER(AirportName) LIKE '%BASE%'
	OR UPPER(AirportName) LIKE '%PLANE%'
	OR UPPER(AirportName) LIKE '%AIRPORT%'
	OR UPPER(AirportName) LIKE '%INTER%'
	OR UPPER(AirportName)  LIKE '%PORT%'
	OR UPPER(AirportName)  LIKE '%HELI%'
	OR UPPER(AirportName)  LIKE '%ISLAND%'
	OR UPPER(AirportName)  LIKE '%AREA%'
	OR UPPER(AirportName)  LIKE '%STATION%'
	OR UPPER(AirportName)  LIKE '%AERO%'
	OR UPPER(AirportName)  LIKE '%RAF%'
);

SELECT AirportName,  COUNT(*) 
FROM FlightTemp
WHERE NOT (
	UPPER(AirportName) LIKE '%AIR%' 
	OR UPPER(AirportName) LIKE '%NAVAL%'
	OR UPPER(AirportName)  LIKE '%DROM%'
	OR UPPER(AirportName) LIKE '%FIELD%'
	OR UPPER(AirportName) LIKE '%BASE%'
	OR UPPER(AirportName) LIKE '%PLANE%'
	OR UPPER(AirportName) LIKE '%AIRPORT%'
	OR UPPER(AirportName) LIKE '%INTER%'
	OR UPPER(AirportName)  LIKE '%PORT%'
	OR UPPER(AirportName)  LIKE '%HELI%'
	OR UPPER(AirportName)  LIKE '%ISLAND%'
	OR UPPER(AirportName)  LIKE '%AREA%'
	OR UPPER(AirportName)  LIKE '%STATION%'
	OR UPPER(AirportName)  LIKE '%AERO%'
	OR UPPER(AirportName)  LIKE '%RAF%'
)
GROUP BY AirportName 
HAVING COUNT(*) > 1;

SELECT ArrivalAirport, AirportContinent
FROM FlightTemp AS ft1
WHERE EXISTS (
    SELECT *
    FROM FlightTemp AS ft2
    WHERE ft1.ArrivalAirport = ft2.ArrivalAirport
    AND ft1.AirportContinent = ft2.AirportContinent
    GROUP BY ft2.ArrivalAirport, ft2.AirportContinent
    HAVING COUNT(DISTINCT ft2.AirportContinent) > 1
);

SELECT ArrivalAirport, AirportContinent, COUNT(*) 
FROM FlightTemp
GROUP BY ArrivalAirport, AirportContinent
HAVING COUNT(*) > 1;

SELECT ArrivalAirport, AirportContinent, COUNT(*) 
FROM FlightTemp
GROUP BY ArrivalAirport, AirportContinent
HAVING COUNT(*) > 1;

-- Se eliminan ArrivalAirport CountryName 
-- ArrivalAirport AirportName

SELECT ArrivalAirport, AirportName FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportName) > 1
);

SELECT ArrivalAirport, AirportCountryCode FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportCountryCode) > 1
);

SELECT ArrivalAirport, AirportContinent FROM FlightTemp
WHERE ArrivalAirport IN (
    SELECT ArrivalAirport
    FROM FlightTemp
    GROUP BY ArrivalAirport
    HAVING COUNT(DISTINCT AirportContinent) > 1
);