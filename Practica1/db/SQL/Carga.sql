USE PRACTICA1;

INSERT INTO Passenger (PassengerID, FirstName, LastName, Gender, Age)
SELECT DISTINCT PassengerID, FirstName, LastName, Gender, Age
FROM FlightTemp WHERE PassengerID IS NOT NULL;

INSERT INTO Airport (AirportName, AirportCountryCode, AirportContinent, ArrivalAirport)
SELECT DISTINCT AirportName, AirportCountryCode, AirportContinent, ArrivalAirport
FROM FlightTemp
WHERE AirportName IS NOT NULL 
AND AirportCountryCode IS NOT NULL
AND AirportContinent IS NOT NULL
AND ArrivalAirport IS NOT NULL;

INSERT INTO Pilot (PilotName)
SELECT DISTINCT PilotName
FROM FlightTemp WHERE PilotName IS NOT NULL;

INSERT INTO Nationality (Nationality)
SELECT DISTINCT Nationality
FROM FlightTemp WHERE Nationality IS NOT NULL;

INSERT INTO Country (AirportCountryCode, CountryName)
SELECT DISTINCT AirportCountryCode, CountryName
FROM FlightTemp WHERE AirportCountryCode IS NOT NULL AND CountryName IS NOT NULL;

INSERT INTO Continent (AirportContinent, ContinentName)
SELECT DISTINCT AirportContinent, ContinentName
FROM FlightTemp WHERE AirportContinent IS NOT NULL AND ContinentName IS NOT NULL;

INSERT INTO FlightDetails (
    PassengerID, 
    AirportID, 
    PilotID, 
    AirportCountryCode, 
    NationalityID, 
    AirportContinent, 
    DepartureDate, 
    FlightStatus
)
SELECT 
    ft.PassengerID, 
    a.AirportID, 
    p.PilotID, 
    c.AirportCountryCode, 
    n.NationalityID, 
    ct.AirportContinent, 
    ft.DepartureDate, 
    ft.FlightStatus
FROM 
    FlightTemp ft
JOIN 
    Passenger pa ON ft.PassengerID = pa.PassengerID
            AND ft.FirstName = pa.FirstName
            AND ft.LastName = pa.LastName
            AND ft.Gender = pa.Gender
            AND ft.Age = pa.Age
JOIN 
    Airport a ON ft.AirportName = a.AirportName
            AND ft.AirportCountryCode = a.AirportCountryCode
            AND ft.AirportContinent = a.AirportContinent
            AND ft.ArrivalAirport = a.ArrivalAirport
JOIN 
    Pilot p ON ft.PilotName = p.PilotName
JOIN 
    Country c ON ft.AirportCountryCode = c.AirportCountryCode
JOIN 
    Nationality n ON ft.Nationality = n.Nationality
JOIN 
    Continent ct ON ft.AirportContinent = ct.AirportContinent;
