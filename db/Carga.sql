USE PRACTICA1;

DROP TABLE IF EXISTS Temporal;
CREATE TABLE Temporal (
    PassengerID VARCHAR(15) COLLATE Latin1_General_BIN,
    FirstName VARCHAR(75),
    LastName VARCHAR(75),
    Gender VARCHAR(20),
    Age INT,
    Nationality VARCHAR(150),
    AirportName VARCHAR(150) COLLATE Latin1_General_BIN,
    AirportCountryCode VARCHAR(150),
    CountryName VARCHAR(150),
    AirportContinent VARCHAR(150),
    ContinentName VARCHAR(150),
    DepartureDate DATE,
    ArrivalAirport VARCHAR(150),
    PilotName VARCHAR(150),
    FlightStatus VARCHAR(75)
);

INSERT INTO Temporal
SELECT * FROM FlightTemp;

DELETE FROM Temporal WHERE ArrivalAirport = '0';
DELETE FROM Temporal WHERE AirportName LIKE '-%';

UPDATE Temporal
SET Nationality = LEFT(Nationality, CHARINDEX(',', Nationality + ',') - 1)
WHERE CHARINDEX(',', Nationality) > 0;

UPDATE Temporal
SET CountryName = LEFT(CountryName, CHARINDEX(',', CountryName + ',') - 1)
WHERE CHARINDEX(',', CountryName) > 0;

UPDATE Temporal
SET AirportName = 
    REPLACE(AirportName, SUBSTRING(AirportName, PATINDEX('%[^a-zA-Z0-9 ]%', AirportName), LEN(AirportName)), '')
WHERE PATINDEX('%[^a-zA-Z0-9 ]%', AirportName) > 0;


DELETE FROM Temporal
WHERE UPPER(AirportName) NOT LIKE '%AIR%' OR UPPER(AirportName) NOT LIKE '%AIRPORT%';


INSERT INTO Passenger (PassengerID, FirstName, LastName, Gender, Age)
SELECT DISTINCT PassengerID, FirstName, LastName, Gender, Age
FROM Temporal
WHERE PassengerID IS NOT NULL;

INSERT INTO Airport (AirportName, AirportCountryCode, CountryName, AirportContinent)
SELECT DISTINCT AirportName, AirportCountryCode, CountryName, AirportContinent
FROM Temporal
WHERE AirportName IS NOT NULL AND AirportCountryCode IS NOT NULL;

INSERT INTO Flight (ArrivalAirport, FlightStatus)
SELECT DISTINCT ArrivalAirport, FlightStatus
FROM Temporal
WHERE ArrivalAirport IS NOT NULL;

INSERT INTO Pilot (PilotName)
SELECT DISTINCT PilotName
FROM Temporal
WHERE PilotName IS NOT NULL;

INSERT INTO Nationality (Nationality)
SELECT DISTINCT Nationality
FROM Temporal
WHERE Nationality IS NOT NULL;

INSERT INTO Continent (ContinentName)
SELECT DISTINCT ContinentName
FROM Temporal
WHERE ContinentName IS NOT NULL;

INSERT INTO FlightDetails (PassengerID, AirportID, FlightID, PilotID, NationalityID, ContinentID, DepartureDate)
SELECT 
    ft.PassengerID,
    a.AirportID,
    f.FlightID,
    p.PilotID,
    n.NationalityID,
    c.ContinentID,
    ft.DepartureDate
FROM 
    Temporal ft
JOIN
    Airport a ON ft.AirportName = a.AirportName AND ft.AirportCountryCode = a.AirportCountryCode
JOIN
    Flight f ON ft.ArrivalAirport = f.ArrivalAirport AND ft.FlightStatus = f.FlightStatus
JOIN
    Pilot p ON ft.PilotName = p.PilotName
JOIN
    Nationality n ON ft.Nationality = n.Nationality
JOIN
    Continent c ON ft.ContinentName = c.ContinentName;
