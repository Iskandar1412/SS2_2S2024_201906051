USE PRACTICA1;

-- Consulta 1: SELECT COUNT(*) a las tablas creadas
SELECT COUNT(*) FROM Passenger;
SELECT COUNT(*) FROM Airport;
SELECT COUNT(*) FROM Pilot;
SELECT COUNT(*) FROM Nationality;
SELECT COUNT(*) FROM Country;
SELECT COUNT(*) FROM Continent;
SELECT COUNT(*) FROM FlightDetails;

-- Consulta 2: Porcentaje de pasajeros por género
SELECT 
    Gender, 
    COUNT(*) AS PassengerCount,
    ROUND((COUNT(*) * (100.0 / (SELECT COUNT(*) FROM Passenger))), 2) AS GenderPercentage
FROM Passenger
GROUP BY Gender;

-- Consulta 3: Nacionalidades con su mes-año de mayor fecha de salida
SELECT 
    n.Nationality,
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '01-2022' THEN 1 ELSE 0 END) AS [01-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '02-2022' THEN 1 ELSE 0 END) AS [02-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '03-2022' THEN 1 ELSE 0 END) AS [03-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '04-2022' THEN 1 ELSE 0 END) AS [04-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '05-2022' THEN 1 ELSE 0 END) AS [05-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '06-2022' THEN 1 ELSE 0 END) AS [06-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '07-2022' THEN 1 ELSE 0 END) AS [07-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '08-2022' THEN 1 ELSE 0 END) AS [08-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '09-2022' THEN 1 ELSE 0 END) AS [09-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '10-2022' THEN 1 ELSE 0 END) AS [10-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '11-2022' THEN 1 ELSE 0 END) AS [11-2022],
    SUM(CASE WHEN FORMAT(fd.DepartureDate, 'MM-yyyy') = '12-2022' THEN 1 ELSE 0 END) AS [12-2022]
FROM FlightDetails fd
    JOIN Nationality n ON fd.NationalityID = n.NationalityID
GROUP BY n.Nationality
ORDER BY n.Nationality;

-- Consulta 4: Count de vuelos por pais
SELECT 
    c.CountryName,
    COUNT(*) AS NumberOfFlights
FROM FlightDetails fd
JOIN 
    Country c ON fd.AirportCountryCode = c.AirportCountryCode
GROUP BY c.CountryName
ORDER BY NumberOfFlights DESC;

-- Caso 5: Top 5 Aeropuertos con mayor número de pasajeros
SELECT 
    a.AirportName,
    COUNT(fd.PassengerID) AS PassengerCount
FROM FlightDetails fd
    JOIN Airport a ON fd.AirportID = a.AirportID
GROUP BY a.AirportName
ORDER BY PassengerCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Caso 6: Count dividido por estado de vuelo
SELECT FlightStatus, COUNT(*) AS FlightStateCount
    FROM FlightDetails fd
GROUP BY fd.FlightStatus;

-- Caso 7: Top 5 Paises más visitados
SELECT TOP 5
    c.CountryName,
    COUNT(*) AS TopCountryVisits
FROM FlightDetails fd
JOIN
    Country c ON fd.AirportCountryCode = c.AirportCountryCode
GROUP BY c.CountryName
ORDER BY TopVisits DESC;

-- Caso 8: Top 5 continentes más visitados
SELECT TOP 5
    c.ContinentName,
    COUNT(*) AS TopContinentVisits
FROM FlightDetails fd
JOIN
    Continent c ON fd.AirportContinent = c.AirportContinent
GROUP BY c.ContinentName
ORDER BY TopContinentVisits DESC;

-- Caso 9: Top 5 edades dividido por género que más viajan
WITH AgeGenderCount AS (
    SELECT 
        Gender,
        Age,
        COUNT(*) AS TravelCount
    FROM Passenger
    GROUP BY 
        Gender,
        Age
), RankedAgeGender AS (
    SELECT 
        Gender,
        Age,
        TravelCount,
        ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY TravelCount DESC) AS Rank
    FROM AgeGenderCount
)
SELECT 
    Gender,
    Age,
    TravelCount
FROM RankedAgeGender
WHERE Rank <= 5
ORDER BY Gender, Rank;

-- Caso 10: Count de vuelos por MM-YYYY
SELECT 
    FORMAT(DepartureDate, 'MM-yyyy') AS MonthYear,
    COUNT(*) AS FlightCount
FROM FlightDetails
GROUP BY 
    FORMAT(DepartureDate, 'MM-yyyy')
ORDER BY MonthYear;