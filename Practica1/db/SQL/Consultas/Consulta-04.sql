-- Consulta 4: Count de vuelos por pais
SELECT 
    c.CountryName,
    COUNT(*) AS NumberOfFlights
FROM FlightDetails fd
JOIN 
    Country c ON fd.AirportCountryCode = c.AirportCountryCode
GROUP BY c.CountryName
ORDER BY NumberOfFlights DESC;