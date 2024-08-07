-- IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PRACTICA1')
-- BEGIN
--     CREATE DATABASE PRACTICA1;
-- END
USE PRACTICA1;

-- Tabla Temporal
CREATE TABLE FlightTemp (
    PassengerID VARCHAR(15),
    FirstName VARCHAR(75),
    LastName VARCHAR(75),
    Gender VARCHAR(20),
    Age INT,
    Nationality VARCHAR(150),
    AirportName VARCHAR(150),
    AirportCountryCode VARCHAR(150),
    CountryName VARCHAR(150),
    AirportContinent VARCHAR(150),
    ContinentName VARCHAR(150),
    DepartureDate DATE,
    ArrivalAirport VARCHAR(150),
    PilotName VARCHAR(150),
    FlightStatus VARCHAR(75)
);

-- Pasajeros
CREATE TABLE Passenger (
    PassengerID VARCHAR(15) PRIMARY KEY,
    FirstName VARCHAR(75),
    LastName VARCHAR(75),
    Gender VARCHAR(20),
    Age INT
);

-- Aeropuerto
CREATE TABLE Airport (
    AirportID INT IDENTITY(1,1) PRIMARY KEY,
    AirportName VARCHAR(150),
    AirportCountryCode VARCHAR(150),
    CountryName VARCHAR(150),
    AirportContinent VARCHAR(150)
);

-- Vuelo
CREATE TABLE Flight (
    FlightID INT IDENTITY(1,1) PRIMARY KEY,
    DepartureDate DATE,
    ArrivalAirport VARCHAR(150),
    FlightStatus VARCHAR(75)
);

-- Piloto
CREATE TABLE Pilot (
    PilotID INT IDENTITY(1,1) PRIMARY KEY,
    PilotName VARCHAR(150)
);

-- Nacionalidad
CREATE TABLE Nationality (
    NationalityID INT IDENTITY(1,1) PRIMARY KEY,
    Nationality VARCHAR(150)
);

-- Continente
CREATE TABLE Continent (
    ContinentID INT IDENTITY(1,1) PRIMARY KEY,
    ContinentName VARCHAR(150)
);

-- Salida
CREATE TABLE Timeline (
    TimelineID INT IDENTITY(1,1) PRIMARY KEY,
    DepartureDate DATE
);

-- Detalles de Vuelo
CREATE TABLE FlightDetails (
    FlightDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerID VARCHAR(15),
    AirportID INT,
    FlightID INT,
    PilotID INT,
    NationalityID INT,
    ContinentID INT,
    TimelineID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (PilotID) REFERENCES Pilot(PilotID),
    FOREIGN KEY (NationalityID) REFERENCES Nationality(NationalityID),
    FOREIGN KEY (ContinentID) REFERENCES Continent(ContinentID),
    FOREIGN KEY (TimelineID) REFERENCES Timeline(TimelineID)
);
