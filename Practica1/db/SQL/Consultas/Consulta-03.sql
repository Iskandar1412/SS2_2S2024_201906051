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