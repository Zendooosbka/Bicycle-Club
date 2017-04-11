/*

    Запросы на создание базы данных сайта велоклуба
    Таблицы:
        Тип велосипеда
        Велосипед
        Трасса
        Покатушки
        Участник
        Запись на учаситие в покатушках

*/

-- Создание самой базы данных
DROP DATABASE IF EXISTS Bicycle;
CREATE DATABASE IF NOT EXISTS Bicycle CHARACTER SET utf8 COLLATE utf8_general_ci;

USE Bicycle;

-- Создание таблицы "Тип велосипеда""
DROP TABLE IF EXISTS BikeType;
CREATE TABLE IF NOT EXISTS BikeType (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL,
    CONSTRAINT NameOfTypeIsEmpty CHECK(TypeName <> ''),
    CONSTRAINT SameValues UNIQUE(TypeName)
) ENGINE = InnoDB   CHARACTER SET = UTF8;

-- Создание таблицы "Велосипеды"
DROP TABLE IF EXISTS Bicycles;
CREATE TABLE IF NOT EXISTS Bicycles (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    BikeTypeId INT NOT NULL DEFAULT 0,
    BikeName VARCHAR(50) NOT NULL,
    FOREIGN KEY (BikeTypeId) REFERENCES BikeType(id) ON DELETE CASCADE,
    CONSTRAINT BikeNameIsEmpty CHECK(BikeName <> ''),
    CONSTRAINT SameValues UNIQUE(BikeName)
) ENGINE = InnoDB   CHARACTER SET = UTF8;

-- Создание таблицы "Участники клуба"
DROP TABLE IF EXISTS Members;
CREATE TABLE IF NOT EXISTS Members (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    SurName VARCHAR(50) NOT NULL,
    FathName VARCHAR(50) NOT NULL,
    Experience INT NOT NULL DEFAULT 0,
    BikeID INT NOT NULL DEFAULT 0,
    BikeColor VARCHAR(50) NOT NULL,
    EntryDate TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (BikeID) REFERENCES Bicycles(id),
    CONSTRAINT NameIsEmpty CHECK(Name <> ''),
    CONSTRAINT SurNameIsEmpty CHECK(SurName <> ''),
    CONSTRAINT FathNameIsEmpty CHECK(FathName <> ''),
    CONSTRAINT BikeColorIsEmpty CHECK(BikeColor <> '')
) ENGINE = InnoDB   CHARACTER SET = UTF8;

-- Создание таблицы "Трасса"
DROP TABLE IF EXISTS Track;
CREATE TABLE IF NOT EXISTS Track (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TrackName VARCHAR(50) NOT NULL,
    StartAddress VARCHAR(50) NOT NULL,
    EndAddress VARCHAR(50) NOT NULL,
    TrackRange INT NOT NULL DEFAULT 0,
    CreatorID INT NOT NULL DEFAULT 0,
    FOREIGN KEY (CreatorID) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT TrackNameIsEmpty CHECK(TrackName <> ''),
    CONSTRAINT StartAddressIsEmpty CHECK(StartAddress <> ''),
    CONSTRAINT EndAddressIsEmpty CHECK(EndAddress <> ''),
    CONSTRAINT SameValues UNIQUE(TrackName)
) ENGINE = InnoDB   CHARACTER SET = UTF8;

-- Создание таблицы "Покатушки(Событие, Мероприятие)"
DROP TABLE IF EXISTS Events;
CREATE TABLE IF NOT EXISTS Events (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(50) NOT NULL,
    EventDate TIMESTAMP NOT NULL DEFAULT NOW(),
    TrackID INT NOT NULL DEFAULT 0,
    CreatorID INT NOT NULL DEFAULT 0,
    FOREIGN KEY (CreatorID) REFERENCES Members(id) ON DELETE CASCADE,
    FOREIGN KEY (TrackID) REFERENCES Track(id),
    CONSTRAINT EventNameIsEmpty CHECK(EventName <> ''),
    CONSTRAINT SameValues UNIQUE(EventName)
) ENGINE = InnoDB   CHARACTER SET = UTF8;

-- Создание таблицы "Участие в покатушках"
DROP TABLE IF EXISTS MembersEvent;
CREATE TABLE IF NOT EXISTS MembersEvent (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    EventsID INT NOT NULL,
    Number INT NOT NULL DEFAULT 0,
    FOREIGN KEY (MemberID) REFERENCES Members(id),
    FOREIGN KEY (EventsID) REFERENCES Events(id),
    CONSTRAINT SameValuesEvent UNIQUE(MemberID, EventsID)
) ENGINE = InnoDB   CHARACTER SET = UTF8;