-- IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PRACTICA1')
-- BEGIN
--     CREATE DATABASE PRACTICA1;
-- END
USE PRACTICA1;

-- Tabla Temporal
CREATE TABLE Temporal (
    PassengerID VARCHAR(10),
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Gender VARCHAR(10),
    Age INT,
    Nationality VARCHAR(50),
    AirportName VARCHAR(50),
    AirportCountryCode VARCHAR(10),
    CountryName VARCHAR(50),
    AirportContinent VARCHAR(50),
    ContinentName VARCHAR(50),
    DepartureDate DATE,
    ArrivalAirport VARCHAR(50),
    PilotName VARCHAR(100),
    FlightStatus VARCHAR(50)
);

-- Pasajeros
CREATE TABLE Passenger (
    PassengerID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Gender VARCHAR(10),
    Age INT
);

-- Aeropuerto
CREATE TABLE Airport (
    AirportID INT IDENTITY(1,1) PRIMARY KEY,
    AirportName VARCHAR(50),
    AirportCountryCode VARCHAR(10),
    CountryName VARCHAR(50),
    AirportContinent VARCHAR(50)
);

-- Vuelo
CREATE TABLE Flight (
    FlightID INT IDENTITY(1,1) PRIMARY KEY,
    DepartureDate DATE,
    ArrivalAirport VARCHAR(50),
    FlightStatus VARCHAR(50)
);

-- Piloto
CREATE TABLE Pilot (
    PilotID INT IDENTITY(1,1) PRIMARY KEY,
    PilotName VARCHAR(100)
);

-- Nacionalidad
CREATE TABLE Nationality (
    NationalityID INT IDENTITY(1,1) PRIMARY KEY,
    Nationality VARCHAR(50)
);

-- Continente
CREATE TABLE Continent (
    ContinentID INT IDENTITY(1,1) PRIMARY KEY,
    ContinentName VARCHAR(50)
);

-- Salida
CREATE TABLE Timeline (
    TimelineID INT IDENTITY(1,1) PRIMARY KEY,
    DepartureDate DATE
);

-- Detalles de Vuelo
CREATE TABLE Flight_Details (
    FlightDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerID VARCHAR(10),
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
