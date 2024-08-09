-- Caso 8: Top 5 continentes más visitados
SELECT TOP 5
    c.ContinentName,
    COUNT(*) AS TopContinentVisits
FROM FlightDetails fd
JOIN
    Continent c ON fd.AirportContinent = c.AirportContinent
GROUP BY c.ContinentName
ORDER BY TopContinentVisits DESC;