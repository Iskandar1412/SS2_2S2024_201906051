-- Caso 5: Top 5 Aeropuertos con mayor número de pasajeros
SELECT 
    a.AirportName,
    COUNT(fd.PassengerID) AS PassengerCount
FROM FlightDetails fd
    JOIN Airport a ON fd.AirportID = a.AirportID
GROUP BY a.AirportName
ORDER BY PassengerCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;