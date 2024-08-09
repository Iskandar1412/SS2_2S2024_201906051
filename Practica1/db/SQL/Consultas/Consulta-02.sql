-- Consulta 2: Porcentaje de pasajeros por género
SELECT 
    Gender, 
    COUNT(*) AS PassengerCount,
    ROUND((COUNT(*) * (100.0 / (SELECT COUNT(*) FROM Passenger))), 2) AS GenderPercentage
FROM Passenger
GROUP BY Gender;