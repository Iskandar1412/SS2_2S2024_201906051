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