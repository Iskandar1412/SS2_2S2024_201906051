-- Caso 10: Count de vuelos por MM-YYYY
SELECT 
    FORMAT(DepartureDate, 'MM-yyyy') AS MonthYear,
    COUNT(*) AS FlightCount
FROM FlightDetails
GROUP BY 
    FORMAT(DepartureDate, 'MM-yyyy')
ORDER BY MonthYear;