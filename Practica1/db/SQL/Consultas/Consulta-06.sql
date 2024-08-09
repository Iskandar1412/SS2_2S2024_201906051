-- Caso 6: Count dividido por estado de vuelo
SELECT 
    REPLACE(fd.FlightStatus, CHAR(13), '') AS FlightStatus, 
    COUNT(*) AS PassengerCount
FROM FlightDetails fd
JOIN 
    Passenger p ON fd.PassengerID = p.PassengerID
GROUP BY REPLACE(fd.FlightStatus, CHAR(13), '')
ORDER BY PassengerCount DESC;