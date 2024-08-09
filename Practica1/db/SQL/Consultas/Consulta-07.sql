-- Caso 7: Top 5 Paises más visitados
SELECT TOP 5
    c.CountryName,
    COUNT(*) AS TopCountryVisits
FROM FlightDetails fd
JOIN
    Country c ON fd.AirportCountryCode = c.AirportCountryCode
GROUP BY c.CountryName
ORDER BY TopCountryVisits DESC;