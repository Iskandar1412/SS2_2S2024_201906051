SELECT * from Airport;
SELECT count(*) from Flight;

SELECT * from Temporal;

SELECT PassengerID, COUNT(*)
FROM Temporal
GROUP BY PassengerID
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
HAVING COUNT(*) > 1;1

SELECT Nationality, COUNT(*)
FROM Nationality
GROUP BY Nationality  
HAVING COUNT(*) > 1;

SELECT  PilotName , COUNT(*)
FROM Pilot 
GROUP BY PilotName 
HAVING COUNT(*) > 1;

SELECT Nationality , COUNT(*)
FROM Temporal
GROUP BY Nationality  
HAVING COUNT(*) > 1; 