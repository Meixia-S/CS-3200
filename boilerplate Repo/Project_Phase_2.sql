CREATE DATABASE IF NOT EXISTS LoneStarTravel;
USE LoneStarTravel;

CREATE TABLE IF NOT EXISTS Representative(
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    rating     INT(5),
    employeeID INT(10) UNIQUE PRIMARY KEY
);

INSERT INTO Representative
VALUES
('Sarah', 'Miller', 4, 1),
('Kai', 'Garcia', 5, 2);



CREATE TABLE IF NOT EXISTS Customer(
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    zip        INT(5),
    street     VARCHAR(20),
    city       VARCHAR(20),
    state      VARCHAR(20),
    employeeID INT(10),
    customerID INT(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (employeeID) references Representative (employeeID)
                                     ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customer
VALUES('Bill', 'Smith', 02555, 'Apple', 'Boston', 'Massachusetts', 1, 1),
      ('Mary', 'Johnson', 02773, 'Franklin', 'Miami', 'Florida', 2, 2);


CREATE TABLE IF NOT EXISTS Airline(
    name              VARCHAR(20),
    rating            INT(5),
    reliabilityRating INT(5),
    airlineID         VARCHAR(5) UNIQUE PRIMARY KEY
);

INSERT INTO Airline
VALUES('Fly Away', 92, 81, '1'),
      ('Best Flights', 53, 66, '2');


CREATE TABLE IF NOT EXISTS Destination(
    region              VARCHAR(30),
    description         TEXT,
    publicTransitRating INT(5),
    destinationID       VARCHAR(10) UNIQUE PRIMARY KEY
);

INSERT INTO Destination
VALUES('Northwest', 'Lovely city with lots to do', 84, '1'),
      ('Southwest', 'One of the most populous cities in the country', 59, '2');


CREATE TABLE IF NOT EXISTS Flight(
    origin        VARCHAR(15),
    destination   VARCHAR(20),
    hasWifi       BOOLEAN,
    airlineID     VARCHAR(5),
    destinationID VARCHAR(10),
    flightID      VARCHAR(10) UNIQUE PRIMARY KEY ,
    FOREIGN KEY (airlineID) references Airline (airlineID)
                                   ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                   ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Flight
VALUES('Boston', 'Seattle', FALSE, 1, 2, 1),
      ('Miami', 'Los Angeles', TRUE, 2, 1, 2);


CREATE TABLE IF NOT EXISTS Activity(
    cost        INT(20),
    description TEXT,
    activityID  INT(10) UNIQUE PRIMARY KEY
);

INSERT INTO Activity
VALUES(25, 'Swimming in the Pacific Ocean',1),
      (10, 'Movie Theater',2);


CREATE TABLE IF NOT EXISTS Hotel(
    rating        INT(5),
    hasWifi       BOOLEAN,
    zip           INT(5),
    street        VARCHAR(20),
    city          VARCHAR(20),
    state         VARCHAR(20),
    destinationID VARCHAR(10),
    hotelID       INT(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                  ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Hotel
VALUES(5, TRUE, 02893, 'Johns', 'Seattle', 'Washington', '1', 1),
      (2, FALSE, 02914, 'Horse', 'Los Angeles', 'California', '2',2);


CREATE TABLE IF NOT EXISTS Guided_Tours(
    groupSize     INT(3),
    duration      INT(2),
    rating        INT(5),
    destinationID VARCHAR(10),
    tourID        INT(5) UNIQUE PRIMARY KEY,
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                         ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Guided_Tours
VALUES
(15, 2, 5, '1', 1),
(10, 3, 4, '2', 2);


CREATE TABLE IF NOT EXISTS Cultural_Sites(
    name   VARCHAR(20),
    type   VARCHAR(20),
    zip    INT(5),
    street VARCHAR(20),
    city   VARCHAR(20),
    state  VARCHAR(20),
    siteID        INT(5) UNIQUE PRIMARY KEY
);

INSERT INTO Cultural_Sites
VALUES
('Historical Museum', 'Museum', 12345, 'Museum St', 'Springfield', 'Illinois', 1),
('Art Gallery', 'Gallery', 54321, 'Gallery Rd', 'Riverside', 'California', 2);


CREATE TABLE IF NOT EXISTS Cultural_Site_Tours(
    tourID           INT(5) UNIQUE,
    siteID           INT(5) UNIQUE,
    FOREIGN KEY (tourID) references Guided_Tours (tourID)
                                                ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (siteID) references Cultural_Sites (siteID)
                                                ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Cultural_Site_Tours
VALUES
(1, 1),
(2, 2);


CREATE TABLE IF NOT EXISTS Research_Archives(
    collections VARCHAR(20),
    area        VARCHAR(20),
    siteID      INT(10),
    name        VARCHAR(20) UNIQUE PRIMARY KEY,
    FOREIGN KEY (siteID) references Cultural_Sites (siteID)
                                              ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Research_Archives
VALUES
('Capital city map', 'Historical Documents', 1, 'History'),
('The King', 'Art Collections', 2, 'Art');


CREATE TABLE IF NOT EXISTS Activity_Destinations(
    activityID  INT(10),
    destinationID VARCHAR(10),
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                                  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (activityID) references Activity (activityID)
                                                  ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Activity_Destinations
VALUES(1, 1),
      (1, 2),
      (2, 1);


CREATE TABLE IF NOT EXISTS Customer_Flights(
    customerID    INT(10),
    flightID      VARCHAR(10),
    FOREIGN KEY (customerID) references Customer (customerID)
                                             ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (flightID) references Flight (flightID)
                                             ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customer_Flights
VALUES(1, 1),
      (2, 2);


CREATE TABLE IF NOT EXISTS Visit_Memos(
    employeeID INT(10) UNIQUE,
    duration INT(10),
    notes TEXT,
    date DATE,
    memoID INT(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (employeeID) references Representative (employeeID)
                                      ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Visit_Memos
VALUES
(1, 2, 'Discussed winter break trips somewhere in Europe this year', '2023-11-17', 1),
(2, 2, 'Went over insurance coverage and needed items for 2 week hiking trip', '2023-09-23', 2);


CREATE TABLE IF NOT EXISTS Secondary_Traveler(
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    customerID INT(10),
    travelerID INT(10) UNIQUE PRIMARY KEY ,
    FOREIGN KEY (customerID) references Customer (customerID)
                                             ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Secondary_Traveler
VALUES('Paul', 'Richards', 1, 1),
      ('Jen', 'White', 2, 2);


CREATE TABLE IF NOT EXISTS Previous_Trips(
    itineraryDoc     TEXT,
    duration         INT(5),
    cost             INT(10),
    representativeID INT(10),
    customerID       INT(10),
    tripID           INT(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (representativeID) references Representative (employeeID)
                                         ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (customerID) references Customer (customerID)
                                         ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Previous_Trips
VALUES
('Text that contains the itinerary for a taken trip', 7, 3000, 1, 1, 1),
('Text that contains the itinerary for a taken trip', 5, 2200, 2, 2, 2);


CREATE TABLE IF NOT EXISTS Insurance(
    cost              INT(10),
    coverage          TEXT,
    insuranceCompany  VARCHAR(30),
    customerID        INT(10),
    insurancePolicyID INT(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (customerID) references Customer (customerID)
                                    ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Insurance
VALUES
(500, 'Injury, Sickness, Lost Personal Items', 'Progressive', 2, 1),
(120, 'Sickness, Lost Personal Items', 'AllState', 1, 2);


CREATE TABLE IF NOT EXISTS Payments(
    name           VARCHAR(20),
    expirationDate DATE,
    cvv            VARCHAR(3),
    customerID     INT(10),
    cardNumber     VARCHAR(16) UNIQUE,
    paymentID      VARCHAR(20) UNIQUE PRIMARY KEY,
    FOREIGN KEY (customerID) references Customer (customerID)
                                   ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Payments
VALUES
('Billy Smith', '2028-02-01', 123, 1, 1111111111111111,123456789),
('Mary Johnson', '2025-01-01', 456, 2, 2222222222222222,987654321);


CREATE TABLE IF NOT EXISTS Discounts(
    paymentID     VARCHAR(16) UNIQUE,
    type          VARCHAR(30),
    endDate       DATE,
    startDate     DATE,
    percentageOff VARCHAR(3),
    discountsID   VARCHAR(10) UNIQUE PRIMARY KEY,
    FOREIGN KEY (paymentID) references Payments (paymentID)
                                    ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Discounts
VALUES
(123456789, 'Student Discount', '2024-01-01', '2023-12-15', 35, 1),
(987654321, 'Holiday Discount', '2024-01-01', '2023-12-15', 20, 2);


CREATE TABLE IF NOT EXISTS Customer_Phone(
    customerID  INT(10),
    phoneNumber VARCHAR(20),
    FOREIGN KEY (customerID) references Customer (customerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customer_Phone
VALUES(1, '5089482345'),
      (1, '5084825937'),
      (2, '5087329147');


CREATE TABLE IF NOT EXISTS Customer_Email(
    customerID  INT(10),
    email VARCHAR(30),
    FOREIGN KEY (customerID) references Customer (customerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customer_Email
VALUES(1, 'bill@gmail.com'),
      (2, 'mary@gmail.com'),
      (2, 'johnson.m@northeastern.edu');


CREATE TABLE IF NOT EXISTS Secondary_Traveler_Email(
    travelerID INT(10),
    email VARCHAR(20),
    FOREIGN KEY (travelerID) references Secondary_Traveler (travelerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Secondary_Traveler_Email
VALUES(1, 'paul@gmail.com'),
      (2, 'jenwhite@gmail.com');


CREATE TABLE IF NOT EXISTS Secondary_Traveler_Phone(
    travelerID INT(10),
    phone VARCHAR(15),
    FOREIGN KEY (travelerID) references Secondary_Traveler (travelerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Secondary_Traveler_Phone
VALUES(1, 5086372819),
      (2, 5081293762),
      (2, 5081239126);


CREATE TABLE IF NOT EXISTS Service_Levels(
    flightID VARCHAR(10),
    level VARCHAR(20),
    FOREIGN KEY (flightID) references Flight (flightID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Service_Levels
VALUES(1, 'Economy'),
      (1, 'First Class'),
      (2, 'Coach');


#DROP DATABASE LoneStarTravel;