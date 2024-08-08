USE PRACTICA1;

-- Tabla Temporal
CREATE TABLE FlightTemp (
    PassengerID VARCHAR(15) COLLATE Latin1_General_BIN,
    FirstName VARCHAR(75),
    LastName VARCHAR(75),
    Gender VARCHAR(20),
    Age INT,
    Nationality VARCHAR(150),
    AirportName VARCHAR(150) COLLATE Latin1_General_BIN,
    AirportCountryCode VARCHAR(15),
    CountryName VARCHAR(150),
    AirportContinent VARCHAR(20),
    ContinentName VARCHAR(150),
    DepartureDate DATE,
    ArrivalAirport VARCHAR(150),
    PilotName VARCHAR(150),
    FlightStatus VARCHAR(25)
);

-- Pasajeros
CREATE TABLE Passenger (
    PassengerID VARCHAR(15) COLLATE Latin1_General_BIN PRIMARY KEY,
    FirstName VARCHAR(75),
    LastName VARCHAR(75),
    Gender VARCHAR(20),
    Age INT
);

-- Aeropuerto
CREATE TABLE Airport (
    AirportID INT IDENTITY(1,1) PRIMARY KEY,
    AirportName VARCHAR(150) COLLATE Latin1_General_BIN,
    AirportCountryCode VARCHAR(15),
    AirportContinent VARCHAR(20),
    ArrivalAirport VARCHAR(150),
);

-- Piloto
CREATE TABLE Pilot (
    PilotID INT IDENTITY(1,1) PRIMARY KEY,
    PilotName VARCHAR(150) UNIQUE
);

-- Nacionalidad
CREATE TABLE Nationality (
    NationalityID INT IDENTITY(1,1) PRIMARY KEY,
    Nationality VARCHAR(150)
);

-- Country
CREATE TABLE Country (
    AirportCountryCode VARCHAR(15) PRIMARY KEY,
    CountryName VARCHAR(150)
);

-- Continente
CREATE TABLE Continent (
    AirportContinent VARCHAR(20) PRIMARY KEY,
    ContinentName VARCHAR(150)
);

-- Detalles de Vuelo
CREATE TABLE FlightDetails (
    FlightDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerID VARCHAR(15) COLLATE Latin1_General_BIN,
    AirportID INT,
    PilotID INT,
    AirportCountryCode VARCHAR(15),
    NationalityID INT,
    AirportContinent VARCHAR(20),
    DepartureDate DATE,
    FlightStatus VARCHAR(25),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (PilotID) REFERENCES Pilot(PilotID),
    FOREIGN KEY (AirportCountryCode) REFERENCES Country(AirportCountryCode),
    FOREIGN KEY (NationalityID) REFERENCES Nationality(NationalityID),
    FOREIGN KEY (AirportContinent) REFERENCES Continent(AirportContinent)
);