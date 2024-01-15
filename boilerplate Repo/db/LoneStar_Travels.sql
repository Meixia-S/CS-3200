DROP DATABASE IF EXISTS `LoneStarTravel`;

CREATE DATABASE IF NOT EXISTS `LoneStarTravel`;
USE `LoneStarTravel`;

grant all privileges on LoneStarTravel.* to 'webapp'@'%';
flush privileges;

CREATE TABLE IF NOT EXISTS Representative(
    employeeID INT(10) UNIQUE PRIMARY KEY,
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    rating     INT(5)
);

CREATE TABLE IF NOT EXISTS Customer(
    customerID INT(10) UNIQUE PRIMARY KEY,
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    zip        INT(5),
    street     VARCHAR(100),
    city       VARCHAR(20),
    state      VARCHAR(20),
    employeeID INT(10),
    FOREIGN KEY (employeeID) references Representative (employeeID)
                                     ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Airline(
    airlineID         INT(10) UNIQUE PRIMARY KEY,
    name              VARCHAR(50),
    rating            INT(5),
    reliabilityRating INT(5)
);

CREATE TABLE IF NOT EXISTS Destination(
    destinationID       INT(10) UNIQUE PRIMARY KEY,
    region              VARCHAR(30),
    description         TEXT,
    publicTransitRating INT(5)
);

CREATE TABLE IF NOT EXISTS Flight(
    flightID      INT(10) UNIQUE PRIMARY KEY,
    origin        VARCHAR(50),
    destination   VARCHAR(50),
    hasWifi       BOOLEAN,
    airlineID     INT(10),
    destinationID INT(10),
    FOREIGN KEY (airlineID) references Airline (airlineID)
                                   ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                   ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Activity(
    activityID  INT(10) UNIQUE PRIMARY KEY,
    cost        INT(20),
    description TEXT
);

CREATE TABLE IF NOT EXISTS Hotel(
    hotelID       INT(10) UNIQUE PRIMARY KEY,
    rating        INT(5),
    hasWifi       BOOLEAN,
    zip           INT(5),
    street        VARCHAR(20),
    city          VARCHAR(20),
    state         VARCHAR(20),
    destinationID INT(10),
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Guided_Tour(
    tourID        INT(10) UNIQUE PRIMARY KEY,
    groupSize     INT(3),
    duration      INT(2),
    rating        INT(5),
    destinationID INT(10),
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                         ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Cultural_Site(
    siteID        INT(10) UNIQUE PRIMARY KEY,
    name   VARCHAR(50),
    type   VARCHAR(50),
    zip    INT(5),
    street VARCHAR(50),
    city   VARCHAR(50),
    state  VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Cultural_Site_Tour(
    tourID           INT(10),
    siteID           INT(10),
    FOREIGN KEY (tourID) references Guided_Tour (tourID)
                                                ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (siteID) references Cultural_Site (siteID)
                                                ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Research_Archive(
    name        INT(10) UNIQUE PRIMARY KEY,
    collections TEXT,
    area        VARCHAR(50),
    siteID      INT(10),
    FOREIGN KEY (siteID) references Cultural_Site (siteID)
                                              ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Activity_Destination(
    activityID  INT(10),
    destinationID INT(10),
    FOREIGN KEY (destinationID) references Destination (destinationID)
                                                  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (activityID) references Activity (activityID)
                                                  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Customer_Flight(
    customerID    INT(10),
    flightID      INT(10),
    FOREIGN KEY (customerID) references Customer (customerID)
                                             ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (flightID) references Flight (flightID)
                                             ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Visit_Memo(
    memoID INT(10) UNIQUE PRIMARY KEY,
    employeeID INT(10),
    duration INT(10),
    notes TEXT,
    date DATE,
    FOREIGN KEY (employeeID) references Representative (employeeID)
                                      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Secondary_Traveler(
    travelerID INT(10) UNIQUE PRIMARY KEY,
    firstName  VARCHAR(20),
    lastName   VARCHAR(20),
    customerID INT(10),
    FOREIGN KEY (customerID) references Customer (customerID)
                                             ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Previous_Trip(
    tripID           INT(10) UNIQUE PRIMARY KEY,
    itineraryDoc     TEXT,
    duration         INT(5),
    cost             INT(10),
    representativeID INT(10),
    customerID       INT(10),
    FOREIGN KEY (representativeID) references Representative (employeeID)
                                         ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (customerID) references Customer (customerID)
                                         ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Insurance(
    insurancePolicyID INT(10) UNIQUE PRIMARY KEY,
    cost              INT(10),
    coverage          TEXT,
    insuranceCompany  VARCHAR(30),
    customerID        INT(10),
    FOREIGN KEY (customerID) references Customer (customerID)
                                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Payment(
    paymentID      INT(10) UNIQUE PRIMARY KEY,
    name           VARCHAR(50),
    expirationDate DATE,
    cvv            VARCHAR(3),
    customerID     INT(10),
    cardNumber     VARCHAR(30),
    FOREIGN KEY (customerID) references Customer (customerID)
                                   ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Discount(
    discountID   INT(10) UNIQUE PRIMARY KEY,
    paymentID    INT(10),
    type          VARCHAR(50),
    endDate       DATE,
    startDate     DATE,
    percentageOff INT(3),
    FOREIGN KEY (paymentID) references Payment (paymentID)
                                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Customer_Phone(
    customerID  INT(10),
    phoneNumber VARCHAR(20),
    FOREIGN KEY (customerID) references Customer (customerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Customer_Email(
    customerID  INT(10),
    email VARCHAR(50),
    FOREIGN KEY (customerID) references Customer (customerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Secondary_Traveler_Email(
    travelerID INT(10),
    email VARCHAR(50),
    FOREIGN KEY (travelerID) references Secondary_Traveler (travelerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Secondary_Traveler_Phone(
    travelerID INT(10),
    phone VARCHAR(20),
    FOREIGN KEY (travelerID) references Secondary_Traveler (travelerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Service_Level(
    flightID INT(10),
    level VARCHAR(50),
    FOREIGN KEY (flightID) references Flight (flightID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

#DROP DATABASE LoneStarTravel;

insert into Representative values (1, 'Carlynn' , 'Bugden' ,84);
insert into Representative values (2, 'Ozzie' , 'Hambatch' ,23);
insert into Representative values (3, 'Carlyn' , 'Jelfs' ,54);
insert into Representative values (4, 'Isidro' , 'Foskett' ,89);
insert into Representative values (5, 'Arlyne' , 'Attawell' ,67);
insert into Representative values (6, 'Jecho' , 'Reith' ,32);
insert into Representative values (7, 'Mirella' , 'Brambley' ,56);
insert into Representative values (8, 'Klaus' , 'Jacqueminet' ,13);
insert into Representative values (9, 'Cthrine' , 'Skeemer' ,57);
insert into Representative values (10, 'Skylar' , 'Burgiss' ,34);
insert into Representative values (11, 'Katerine' , 'Corstorphine' ,56);
insert into Representative values (12, 'Ardisj' , 'Carradice' ,89);
insert into Representative values (13, 'Shel' , 'Jerman' ,48);
insert into Representative values (14, 'Kim' , 'Briton' ,92);
insert into Representative values (15, 'Abigael' , 'Evanson' ,71);
insert into Representative values (16, 'Slade' , 'Bricham' ,26);
insert into Representative values (17, 'Dorise' , 'Pudner' ,55);
insert into Representative values (18, 'Lana' , 'Schneidau' ,85);
insert into Representative values (19, 'Sheryl' , 'Newey' ,13);
insert into Representative values (20, 'Eugen' , 'Viall' ,45);
insert into Representative values (21, 'Fenelia' , 'Fraschetti' ,28);
insert into Representative values (22, 'Isac' , 'Breem' ,38);
insert into Representative values (23, 'Freemon' , 'Goodfield' ,96);
insert into Representative values (24, 'Nata' , 'Twigley' ,84);
insert into Representative values (25, 'Peg' , 'Rorke' ,17);
insert into Representative values (26, 'Elisabetta' , 'Dmisek' ,29);
insert into Representative values (27, 'Karina' , 'Clarson' ,32);
insert into Representative values (28, 'Tony' , 'Simonazzi' ,73);
insert into Representative values (29, 'Carline' , 'Owers' ,47);
insert into Representative values (30, 'Rolland' , 'Armatys' ,27);
insert into Representative values (31, 'Silas' , 'Megson' ,35);
insert into Representative values (32, 'Crawford' , 'Chardin' ,6);
insert into Representative values (33, 'Alf' , 'Chasmor' ,28);
insert into Representative values (34, 'Annelise' , 'Lumox' ,64);
insert into Representative values (35, 'Ulrica' , 'Acuna' ,81);
insert into Representative values (36, 'Kalvin' , 'Greatbanks' ,36);
insert into Representative values (37, 'Barnett' , 'Hearns' ,8);
insert into Representative values (38, 'Rosalie' , 'Yurocjkin' ,1);
insert into Representative values (39, 'Aveline' , 'Larby' ,26);
insert into Representative values (40, 'Gustavo' , 'Schroder' ,58);
insert into Representative values (41, 'Peterus' , 'Kempton' ,63);
insert into Representative values (42, 'Dotti' , 'Fleckno' ,57);
insert into Representative values (43, 'Willie' , 'Rogerot' ,15);
insert into Representative values (44, 'Jacklyn' , 'Bispo' ,98);
insert into Representative values (45, 'Maren' , 'Taig' ,36);
insert into Representative values (46, 'Abe' , 'Tabert' ,10);
insert into Representative values (47, 'Corrina' , 'Chalfont' ,4);
insert into Representative values (48, 'Gisela' , 'Slym' ,69);
insert into Representative values (49, 'Perrine' , 'Guterson' ,37);
insert into Representative values (50, 'Lira' , 'Durn' ,44);

insert into Customer values (1, 'Lock' , 'Newcom' ,15225, '3236 Charing Cross Hill' , 'Pittsburgh' , 'Pennsylvania' ,1);
insert into Customer values (2, 'Jaymee' , 'Smillie' ,92424, '23 Dottie Plaza' , 'San Bernardino' , 'California' ,2);
insert into Customer values (3, 'Justis' , 'Spilstead' ,33436, '95 Maple Wood Alley' , 'Boynton Beach' , 'Florida' ,3);
insert into Customer values (4, 'Abrahan' , 'Kolakowski' ,58505, '7 Walton Terrace' , 'Bismarck' , 'North Dakota' ,4);
insert into Customer values (5, 'Axe' , 'Glasheen' ,48126, '17250 Hagan Avenue' , 'Dearborn' , 'Michigan' ,5);
insert into Customer values (6, 'Josefa' , 'Nutbean' ,78682, '8 Grayhawk Junction' , 'Round Rock' , 'Texas' ,6);
insert into Customer values (7, 'Fifine' , 'Sheldrick' ,32627, '0 Holmberg Junction' , 'Gainesville' , 'Florida' ,7);
insert into Customer values (8, 'Madeleine' , 'Tirkin' ,70179, '4 Mcguire Terrace' , 'New Orleans' , 'Louisiana' ,8);
insert into Customer values (9, 'Evelyn' , 'Turbitt' ,60193, '6 Redwing Pass' , 'Schaumburg' , 'Illinois' ,9);
insert into Customer values (10, 'Bradney' , 'Andreasen' ,80638, '863 Warrior Street' , 'Greeley' , 'Colorado' ,10);
insert into Customer values (11, 'Fredia' , 'Syme' ,90094, '486 Killdeer Drive' , 'Los Angeles' , 'California' ,11);
insert into Customer values (12, 'Louisa' , 'McGowing' ,95818, '46074 Novick Avenue' , 'Sacramento' , 'California' ,12);
insert into Customer values (13, 'Alissa' , 'Harroll' ,79188, '8 Chive Junction' , 'Amarillo' , 'Texas' ,13);
insert into Customer values (14, 'Clyve' , 'Currall' ,25313, '62628 Oakridge Plaza' , 'Charleston' , 'West Virginia' ,14);
insert into Customer values (15, 'Berny' , 'Hounson' ,29208, '12 Dixon Avenue' , 'Columbia' , 'South Carolina' ,15);
insert into Customer values (16, 'Dare' , 'Hooks' ,87505, '228 Sauthoff Alley' , 'Santa Fe' , 'New Mexico' ,16);
insert into Customer values (17, 'Bartel' , 'Giddons' ,32204, '28 Onsgard Trail' , 'Jacksonville' , 'Florida' ,17);
insert into Customer values (18, 'Tina' , 'Ogiany' ,36109, '49 Riverside Alley' , 'Montgomery' , 'Alabama' ,18);
insert into Customer values (19, 'Zita' , 'Telezhkin' ,68144, '50 Autumn Leaf Place' , 'Omaha' , 'Nebraska' ,19);
insert into Customer values (20, 'Odella' , 'Issac' ,79452, '8814 Holy Cross Parkway' , 'Lubbock' , 'Texas' ,20);
insert into Customer values (21, 'Cloe' , 'Agar' ,77005, '164 Bay Pass' , 'Houston' , 'Texas' ,21);
insert into Customer values (22, 'Garv' , 'Alesbrook' ,91505, '2898 Esker Pass' , 'Burbank' , 'California' ,22);
insert into Customer values (23, 'Giustino' , 'Larmet' ,72905, '9915 Harbort Place' , 'Fort Smith' , 'Arkansas' ,23);
insert into Customer values (24, 'Elyssa' , 'Wade' ,78220, '3 Mosinee Street' , 'San Antonio' , 'Texas' ,24);
insert into Customer values (25, 'Leo' , 'De Bruyne' ,60624, '75 Loftsgordon Parkway' , 'Chicago' , 'Illinois' ,25);
insert into Customer values (26, 'Gallard' , 'Frankish' ,33763, '43 Anthes Center' , 'Clearwater' , 'Florida' ,26);
insert into Customer values (27, 'Susanne' , 'McCue' ,80925, '13 Express Hill' , 'Colorado Springs' , 'Colorado' ,27);
insert into Customer values (28, 'Rayna' , 'Escudier' ,43666, '6275 Stuart Way' , 'Toledo' , 'Ohio' ,28);
insert into Customer values (29, 'Doloritas' , 'Juleff' ,87110, '5 Mcguire Center' , 'Albuquerque' , 'New Mexico' ,29);
insert into Customer values (30, 'Ollie' , 'McGaffey' ,20540, '26802 Schmedeman Park' , 'Washington' , 'District of Columbia' ,30);
insert into Customer values (31, 'Bettye' , 'Cock' ,54313, '9347 Menomonie Plaza' , 'Green Bay' , 'Wisconsin' ,31);
insert into Customer values (32, 'Perl' , 'Malatalant' ,81015, '7 Banding Drive' , 'Pueblo' , 'Colorado' ,32);
insert into Customer values (33, 'Liesa' , 'Webland' ,53205, '1 Redwing Road' , 'Milwaukee' , 'Wisconsin' ,33);
insert into Customer values (34, 'Osbourne' , 'Mummery' ,40210, '6326 Darwin Way' , 'Louisville' , 'Kentucky' ,34);
insert into Customer values (35, 'Brenn' , 'Knight' ,20010, '778 Stephen Center' , 'Washington' , 'District of Columbia' ,35);
insert into Customer values (36, 'Jayne' , 'Yusupov' ,90831, '648 Carberry Pass' , 'Long Beach' , 'California' ,36);
insert into Customer values (37, 'Felipa' , 'Oki' ,89125, '3 Fairview Road' , 'Las Vegas' , 'Nevada' ,37);
insert into Customer values (38, 'Irwinn' , 'Padfield' ,48609, '7 Columbus Center' , 'Saginaw' , 'Michigan' ,38);
insert into Customer values (39, 'Nadia' , 'Shackelton' ,60435, '1 Saint Paul Place' , 'Joliet' , 'Illinois' ,39);
insert into Customer values (40, 'Alley' , 'Simek' ,22070, '88 Hayes Avenue' , 'Herndon' , 'Virginia' ,40);
insert into Customer values (41, 'Caesar' , 'Grubb' ,32854, '72 Northfield Circle' , 'Orlando' , 'Florida' ,41);
insert into Customer values (42, 'Meridel' , 'Warboys' ,28272, '837 Nova Street' , 'Charlotte' , 'North Carolina' ,42);
insert into Customer values (43, 'Anstice' , 'Godsil' ,55564, '2456 Gerald Lane' , 'Young America' , 'Minnesota' ,43);
insert into Customer values (44, 'Vaughan' , 'Cage' ,56398, '69 Straubel Junction' , 'Saint Cloud' , 'Minnesota' ,44);
insert into Customer values (45, 'Jarrad' , 'Maffetti' ,10024, '59 Ridgeway Hill' , 'New York City' , 'New York' ,45);
insert into Customer values (46, 'Wilbert' , 'Canniffe' ,94164, '3 Superior Alley' , 'San Francisco' , 'California' ,46);
insert into Customer values (47, 'Eryn' , 'Block' ,90071, '416 Rutledge Center' , 'Los Angeles' , 'California' ,47);
insert into Customer values (48, 'Elfrieda' , 'Rummings' ,21281, '89687 Northridge Place' , 'Baltimore' , 'Maryland' ,48);
insert into Customer values (49, 'Frannie' , 'Hakey' ,53234, '4 Carberry Center' , 'Milwaukee' , 'Wisconsin' ,49);
insert into Customer values (50, 'Shae' , 'Byas' ,20546, '19 Bashford Junction' , 'Washington' , 'District of Columbia' ,50);

insert into Airline values (1, 'Heathcote Inc' ,64,48);
insert into Airline values (2, 'Ortiz-Zieme' ,39,46);
insert into Airline values (3, 'Grant Inc' ,98,3);
insert into Airline values (4, 'Weimann-Okuneva' ,22,15);
insert into Airline values (5, 'Maggio-Pacocha' ,82,5);
insert into Airline values (6, 'Douglas LLC' ,50,25);
insert into Airline values (7, 'Crooks, Rippin and Ratke' ,81,55);
insert into Airline values (8, 'Wehner-Kautzer' ,33,32);
insert into Airline values (9, 'Fadel Inc' ,2,14);
insert into Airline values (10, 'Bergstrom-Reichel' ,28,39);
insert into Airline values (11, 'Glover, Schaden and McCullough' ,90,97);
insert into Airline values (12, 'Berge-Strosin' ,53,19);
insert into Airline values (13, 'Feeney LLC' ,49,79);
insert into Airline values (14, 'Lowe, Oconner and Kerluke' ,88,17);
insert into Airline values (15, 'Smitham Group' ,75,72);
insert into Airline values (16, 'Bartell, Rodriguez and Metz' ,96,55);
insert into Airline values (17, 'Mraz-Armstrong' ,10,81);
insert into Airline values (18, 'Bechtelar, Rogahn and Shields' ,53,32);
insert into Airline values (19, 'Spencer-Weissnat' ,100,84);
insert into Airline values (20, 'Heidenreich-Greenholt' ,50,84);
insert into Airline values (21, 'Dickens, Wilderman and Walker' ,7,24);
insert into Airline values (22, 'McCullough Group' ,13,7);
insert into Airline values (23, 'Bode and Sons' ,81,28);
insert into Airline values (24, 'Witting Inc' ,22,20);
insert into Airline values (25, 'Barton LLC' ,100,55);
insert into Airline values (26, 'Armstrong, Rolfson and Buckridge' ,100,34);
insert into Airline values (27, 'Towne, Hammes and Kautzer' ,66,71);
insert into Airline values (28, 'Hermiston-Hermann' ,38,68);
insert into Airline values (29, 'Kovacek Group' ,96,40);
insert into Airline values (30, 'Fisher, Lockman and Bashirian' ,56,24);
insert into Airline values (31, 'Batz-Deckow' ,7,56);
insert into Airline values (32, 'Satterfield-Stehr' ,5,87);
insert into Airline values (33, 'Runte, Krajcik and Schumm' ,39,88);
insert into Airline values (34, 'Towne LLC' ,76,22);
insert into Airline values (35, 'Price-Waters' ,88,29);
insert into Airline values (36, 'Barton-Nitzsche' ,11,43);
insert into Airline values (37, 'Ohara LLC' ,33,39);
insert into Airline values (38, 'West-Toy' ,86,29);
insert into Airline values (39, 'Kunze-Altenwerth' ,34,73);
insert into Airline values (40, 'Weimann Inc' ,14,100);
insert into Airline values (41, 'Koelpin-Bashirian' ,19,84);
insert into Airline values (42, 'Abernathy, Walter and Pfeffer' ,59,38);
insert into Airline values (43, 'Lakin Inc' ,72,64);
insert into Airline values (44, 'Yost, Lemke and Kassulke' ,66,48);
insert into Airline values (45, 'Lynch-Cummerata' ,98,71);
insert into Airline values (46, 'Quitzon LLC' ,28,26);
insert into Airline values (47, 'Daniel-Nicolas' ,42,1);
insert into Airline values (48, 'Hessel-Homenick' ,55,95);
insert into Airline values (49, 'Kessler LLC' ,60,32);
insert into Airline values (50, 'Hilll LLC' ,30,3);

insert into Destination values (1, 'Příbor' , 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.' ,74);
insert into Destination values (2, 'Ngenden' , 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' ,18);
insert into Destination values (3, 'Xinhe' , 'Aenean fermentum.' ,97);
insert into Destination values (4, 'Areia Branca' , 'Donec semper sapien a libero.' ,27);
insert into Destination values (5, 'Sarband' , 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.' ,65);
insert into Destination values (6, 'Nidek' , 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.' ,92);
insert into Destination values (7, 'Great Neck' , 'Morbi ut odio.' ,46);
insert into Destination values (8, 'Sindangraja' , 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.' ,22);
insert into Destination values (9, 'Pensacola' , 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.' ,25);
insert into Destination values (10, 'Rolante' , 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.' ,7);
insert into Destination values (11, 'Dapdap' , 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.' ,52);
insert into Destination values (12, 'Hubynykha' , 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.' ,4);
insert into Destination values (13, 'Ngulangan' , 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' ,93);
insert into Destination values (14, 'Kol’chugino' , 'Aliquam quis turpis eget elit sodales scelerisque.' ,28);
insert into Destination values (15, 'Berezniki' , 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' ,18);
insert into Destination values (16, 'Krzczonów' , 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.' ,72);
insert into Destination values (17, 'Samoš' , 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.' ,76);
insert into Destination values (18, 'Liufu' , 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' ,97);
insert into Destination values (19, 'Storozhynets’' , 'Duis mattis egestas metus. Aenean fermentum.' ,94);
insert into Destination values (20, 'Tolotangga' , 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.' ,70);
insert into Destination values (21, 'Cagliari' , 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' ,35);
insert into Destination values (22, 'Famaillá' , 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.' ,33);
insert into Destination values (23, 'Liloan' , 'Curabitur convallis.' ,3);
insert into Destination values (24, 'Edinburgh' , 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' ,24);
insert into Destination values (25, 'Salas' , 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' ,100);
insert into Destination values (26, 'Lanzhong' , 'Proin at turpis a pede posuere nonummy.' ,66);
insert into Destination values (27, 'Huabeitun' , 'Mauris sit amet eros.' ,2);
insert into Destination values (28, 'Tawau' , 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.' ,89);
insert into Destination values (29, 'Santa María Ixhuatán' , 'Nunc purus.' ,14);
insert into Destination values (30, 'Sanfang' , 'Etiam justo. Etiam pretium iaculis justo.' ,35);
insert into Destination values (31, 'São Pedro' , 'Nulla facilisi.' ,50);
insert into Destination values (32, 'Uście Gorlickie' , 'Praesent blandit lacinia erat.' ,8);
insert into Destination values (33, 'Oslo' , 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.' ,14);
insert into Destination values (34, 'Lviv' , 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' ,89);
insert into Destination values (35, 'Piekielnik' , 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.' ,12);
insert into Destination values (36, 'Ikar' , 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' ,71);
insert into Destination values (37, 'Gemuruh' , 'Curabitur convallis.' ,76);
insert into Destination values (38, 'Tsengel' , 'Aenean sit amet justo.' ,60);
insert into Destination values (39, 'Xingou' , 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.' ,27);
insert into Destination values (40, '‘Awaj' , 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.' ,95);
insert into Destination values (41, 'Sirinhaém' , 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.' ,79);
insert into Destination values (42, 'Chmielno' , 'Pellentesque at nulla.' ,51);
insert into Destination values (43, 'Đồi Ngô' , 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' ,18);
insert into Destination values (44, 'Hovtamej' , 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.' ,24);
insert into Destination values (45, 'Nawal' , 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.' ,7);
insert into Destination values (46, 'Lelystad' , 'Vivamus vestibulum sagittis sapien.' ,38);
insert into Destination values (47, 'Glyadyanskoye' , 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' ,53);
insert into Destination values (48, 'Sal’sk' , 'Pellentesque at nulla.' ,75);
insert into Destination values (49, 'Dushk' , 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' ,93);
insert into Destination values (50, 'Aganan' , 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.' ,72);

insert into Flight values (1, 'Puma' , 'Krajan Rowokangkung' ,1,1,31);
insert into Flight values (2, 'Mubi' , 'Caseros' ,1,2,34);
insert into Flight values (3, 'Purwosari' , 'Hanlin' ,0,3,38);
insert into Flight values (4, 'Sardoal' , 'Patalan' ,0,4,24);
insert into Flight values (5, 'Cantuk Kidul' , 'Guang’an' ,1,5,15);
insert into Flight values (6, 'Jiangqiao' , 'Nanzamu' ,0,6,21);
insert into Flight values (7, 'Khallat ad Dār' , 'San Fabian' ,1,7,41);
insert into Flight values (8, 'Yongxing Chengguanzhen' , 'Bagan' ,1,8,2);
insert into Flight values (9, 'Monte' , 'Elato' ,0,9,18);
insert into Flight values (10, 'Xiangyang' , 'Kastornoye' ,0,10,1);
insert into Flight values (11, 'Kokkini Trimithia' , 'Sindangheula' ,1,11,19);
insert into Flight values (12, 'Snegiri' , 'La Tour-du-Pin' ,0,12,42);
insert into Flight values (13, 'Diónysos' , 'Hekou' ,0,13,21);
insert into Flight values (14, 'Paris 01' , 'Confey' ,1,14,18);
insert into Flight values (15, 'Tame' , 'Gaspra' ,0,15,9);
insert into Flight values (16, 'San Pedro One' , 'Goyang-si' ,0,16,9);
insert into Flight values (17, 'Staraya Ladoga' , 'Kampong Chhnang' ,1,17,14);
insert into Flight values (18, 'Prévost' , 'Samanco' ,0,18,50);
insert into Flight values (19, 'Cikendi' , 'Novozavedennoye' ,0,19,16);
insert into Flight values (20, 'Santa Fe' , 'Fuhai' ,1,20,46);
insert into Flight values (21, 'Kuznechnoye' , 'Estelí' ,1,21,16);
insert into Flight values (22, 'Buffalo' , 'Bang Ban' ,1,22,23);
insert into Flight values (23, 'Aguas Corrientes' , 'Onguday' ,0,23,27);
insert into Flight values (24, 'Fauske' , 'Linköping' ,0,24,22);
insert into Flight values (25, 'Balitai' , 'Quintã' ,0,25,26);
insert into Flight values (26, 'Batutua' , 'Wenqiao' ,0,26,25);
insert into Flight values (27, 'Armenia' , 'Shijiao' ,0,27,14);
insert into Flight values (28, 'Verkhniy Kurkuzhin' , 'Úštěk' ,0,28,21);
insert into Flight values (29, 'Valparaíso' , 'Tuojiang' ,1,29,22);
insert into Flight values (30, 'Valinhos' , 'Paraíso' ,0,30,34);
insert into Flight values (31, 'Piskivka' , 'Kraśniczyn' ,1,31,44);
insert into Flight values (32, 'Sacramento' , 'Balykchy' ,0,32,46);
insert into Flight values (33, 'Pahing Jalatrang' , 'Normandin' ,0,33,26);
insert into Flight values (34, 'Pak Thong Chai' , 'Parion' ,1,34,16);
insert into Flight values (35, 'Xiadahe' , 'Kuznechnoye' ,0,35,29);
insert into Flight values (36, 'Sasaguri' , 'Qingyang' ,1,36,11);
insert into Flight values (37, 'Kedungreja' , 'Shymkent' ,1,37,30);
insert into Flight values (38, 'Maroua' , 'Pylaía' ,0,38,47);
insert into Flight values (39, 'Jiangxi' , 'Sorochuco' ,1,39,11);
insert into Flight values (40, 'Elat' , 'Hongqi Yingzi' ,0,40,33);
insert into Flight values (41, 'Asbest' , 'Padangulaktanding' ,1,41,6);
insert into Flight values (42, 'Al Wardānīn' , 'Yakutsk' ,1,42,13);
insert into Flight values (43, 'Huillapima' , 'Suwaru' ,1,43,44);
insert into Flight values (44, 'Buni Yadi' , 'Lushnjë' ,0,44,42);
insert into Flight values (45, 'Ljukovo' , 'Lapinjärvi' ,0,45,41);
insert into Flight values (46, 'Pathum Ratchawongsa' , 'Lyubeshiv' ,0,46,1);
insert into Flight values (47, 'Santa María de Ipire' , 'Istres' ,0,47,26);
insert into Flight values (48, 'Eskilstuna' , 'Arcos de Valdevez' ,0,48,23);
insert into Flight values (49, 'Oganlima' , 'Kulun' ,1,49,35);
insert into Flight values (50, 'Bích Động' , 'El Jem' ,0,50,27);

insert into Activity values (1, 68, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Activity values (2, 1053, 'Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into Activity values (3, 1402, 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
insert into Activity values (4, 1205, 'Suspendisse ornare consequat lectus.');
insert into Activity values (5, 708, 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into Activity values (6, 1748, 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
insert into Activity values (7, 438, 'Proin risus. Praesent lectus.');
insert into Activity values (8, 1400, 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Activity values (9, 194, 'Aenean sit amet justo.');
insert into Activity values (10, 256, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');
insert into Activity values (11, 412, 'Etiam faucibus cursus urna.');
insert into Activity values (12, 455, 'Suspendisse accumsan tortor quis turpis.');
insert into Activity values (13, 160, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
insert into Activity values (14, 872, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.');
insert into Activity values (15, 1415, 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
insert into Activity values (16, 1846, 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.');
insert into Activity values (17, 1682, 'Ut tellus. Nulla ut erat id mauris vulputate elementum.');
insert into Activity values (18, 1435, 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
insert into Activity values (19, 538, 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into Activity values (20, 318, 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.');
insert into Activity values (21, 267, 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
insert into Activity values (22, 1427, 'Mauris ullamcorper purus sit amet nulla.');
insert into Activity values (23, 433, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.');
insert into Activity values (24, 1848, 'Phasellus sit amet erat.');
insert into Activity values (25, 1647, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
insert into Activity values (26, 86, 'Quisque ut erat. Curabitur gravida nisi at nibh.');
insert into Activity values (27, 1108, 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
insert into Activity values (28, 1697, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.');
insert into Activity values (29, 1762, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
insert into Activity values (30, 131, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into Activity values (31, 162, 'In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Activity values (32, 1790, 'Morbi porttitor lorem id ligula.');
insert into Activity values (33, 1338, 'Morbi porttitor lorem id ligula.');
insert into Activity values (34, 829, 'Quisque ut erat.');
insert into Activity values (35, 1514, 'Donec quis orci eget orci vehicula condimentum.');
insert into Activity values (36, 1199, 'Etiam justo.');
insert into Activity values (37, 661, 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.');
insert into Activity values (38, 793, 'Integer ac neque. Duis bibendum.');
insert into Activity values (39, 983, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.');
insert into Activity values (40, 1580, 'Morbi a ipsum. Integer a nibh.');
insert into Activity values (41, 421, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into Activity values (42, 1682, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Activity values (43, 1261, 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
insert into Activity values (44, 1572, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into Activity values (45, 1072, 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.');
insert into Activity values (46, 1438, 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.');
insert into Activity values (47, 348, 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into Activity values (48, 1352, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.');
insert into Activity values (49, 1200, 'Aliquam erat volutpat.');
insert into Activity values (50, 893, 'Integer ac leo. Pellentesque ultrices mattis odio.');

insert into Hotel values (1,92,1,89130, 'Morningstar' , 'Las Vegas' , 'Nevada' ,37);
insert into Hotel values (2,2,1,94257, 'Petterle' , 'Sacramento' , 'California' ,43);
insert into Hotel values (3,73,0,24014, 'Harbort' , 'Roanoke' , 'Virginia' ,45);
insert into Hotel values (4,40,1,17105, 'Hallows' , 'Harrisburg' , 'Pennsylvania' ,18);
insert into Hotel values (5,71,0,78205, 'Atwood' , 'San Antonio' , 'Texas' ,17);
insert into Hotel values (6,19,0,92105, 'Southridge' , 'San Diego' , 'California' ,17);
insert into Hotel values (7,69,0,27605, 'Cascade' , 'Raleigh' , 'North Carolina' ,27);
insert into Hotel values (8,24,0,55905, 'Mcbride' , 'Rochester' , 'Minnesota' ,19);
insert into Hotel values (9,18,0,76711, 'Becker' , 'Waco' , 'Texas' ,32);
insert into Hotel values (10,84,1,40280, 'Sage' , 'Louisville' , 'Kentucky' ,14);
insert into Hotel values (11,6,1,94105, 'Vernon' , 'San Francisco' , 'California' ,36);
insert into Hotel values (12,32,0,33694, 'Ramsey' , 'Tampa' , 'Florida' ,23);
insert into Hotel values (13,78,1,20260, 'Cottonwood' , 'Washington' , 'District of Columbia' ,42);
insert into Hotel values (14,32,1,92640, 'Blackbird' , 'Fullerton' , 'California' ,36);
insert into Hotel values (15,20,1,55470, 'Thierer' , 'Minneapolis' , 'Minnesota' ,46);
insert into Hotel values (16,19,0,90025, 'Clarendon' , 'Los Angeles' , 'California' ,3);
insert into Hotel values (17,38,0,43666, '8th' , 'Toledo' , 'Ohio' ,31);
insert into Hotel values (18,83,0,11480, 'David' , 'Jamaica' , 'New York' ,43);
insert into Hotel values (19,38,0,85072, 'Anzinger' , 'Phoenix' , 'Arizona' ,40);
insert into Hotel values (20,12,1,73173, 'Thierer' , 'Oklahoma City' , 'Oklahoma' ,43);
insert into Hotel values (21,12,0,85030, 'Sachtjen' , 'Phoenix' , 'Arizona' ,40);
insert into Hotel values (22,89,0,53285, 'Quincy' , 'Milwaukee' , 'Wisconsin' ,13);
insert into Hotel values (23,30,1,40524, 'Utah' , 'Lexington' , 'Kentucky' ,42);
insert into Hotel values (24,85,1,98464, 'Thierer' , 'Tacoma' , 'Washington' ,17);
insert into Hotel values (25,93,1,90076, 'Schurz' , 'Los Angeles' , 'California' ,1);
insert into Hotel values (26,22,0,80638, 'Red Cloud' , 'Greeley' , 'Colorado' ,19);
insert into Hotel values (27,41,0,77266, 'Hanson' , 'Houston' , 'Texas' ,30);
insert into Hotel values (28,39,1,74133, 'Dapin' , 'Tulsa' , 'Oklahoma' ,6);
insert into Hotel values (29,94,1,32204, 'Park Meadow' , 'Jacksonville' , 'Florida' ,12);
insert into Hotel values (30,30,1,92878, 'Namekagon' , 'Corona' , 'California' ,8);
insert into Hotel values (31,8,1,95818, 'Buhler' , 'Sacramento' , 'California' ,29);
insert into Hotel values (32,31,1,83206, 'Vermont' , 'Pocatello' , 'Idaho' ,20);
insert into Hotel values (33,11,1,68179, 'Northridge' , 'Omaha' , 'Nebraska' ,1);
insert into Hotel values (34,82,0,52410, 'La Follette' , 'Cedar Rapids' , 'Iowa' ,31);
insert into Hotel values (35,23,0,54305, 'Thackeray' , 'Green Bay' , 'Wisconsin' ,33);
insert into Hotel values (36,95,1,29225, 'Talmadge' , 'Columbia' , 'South Carolina' ,13);
insert into Hotel values (37,49,0,55188, 'Lake View' , 'Saint Paul' , 'Minnesota' ,11);
insert into Hotel values (38,43,0,46266, 'Shelley' , 'Indianapolis' , 'Indiana' ,14);
insert into Hotel values (39,56,1,68531, 'Heath' , 'Lincoln' , 'Nebraska' ,7);
insert into Hotel values (40,73,0,33610, 'Moose' , 'Tampa' , 'Florida' ,47);
insert into Hotel values (41,18,1,19805, 'Algoma' , 'Wilmington' , 'Delaware' ,38);
insert into Hotel values (42,4,0,32255, 'Chive' , 'Jacksonville' , 'Florida' ,1);
insert into Hotel values (43,77,0,85284, 'Fair Oaks' , 'Tempe' , 'Arizona' ,11);
insert into Hotel values (44,66,1,1605, 'Moulton' , 'Worcester' , 'Massachusetts' ,50);
insert into Hotel values (45,33,0,2912, 'Warrior' , 'Providence' , 'Rhode Island' ,3);
insert into Hotel values (46,25,1,68117, 'Towne' , 'Omaha' , 'Nebraska' ,26);
insert into Hotel values (47,28,0,27150, 'Summerview' , 'Winston Salem' , 'North Carolina' ,8);
insert into Hotel values (48,1,1,34665, 'Waubesa' , 'Pinellas Park' , 'Florida' ,40);
insert into Hotel values (49,90,0,35895, 'Mccormick' , 'Huntsville' , 'Alabama' ,4);
insert into Hotel values (50,91,1,70116, 'Michigan' , 'New Orleans' , 'Louisiana' ,8);

insert into Guided_Tour values (1,43,8,31,47);
insert into Guided_Tour values (2,22,14,80,38);
insert into Guided_Tour values (3,38,4,73,32);
insert into Guided_Tour values (4,39,6,7,12);
insert into Guided_Tour values (5,24,3,61,19);
insert into Guided_Tour values (6,39,16,66,45);
insert into Guided_Tour values (7,54,16,50,23);
insert into Guided_Tour values (8,31,8,69,29);
insert into Guided_Tour values (9,6,3,42,24);
insert into Guided_Tour values (10,29,3,70,6);
insert into Guided_Tour values (11,52,2,93,32);
insert into Guided_Tour values (12,79,1,85,48);
insert into Guided_Tour values (13,4,16,39,3);
insert into Guided_Tour values (14,85,7,8,2);
insert into Guided_Tour values (15,57,4,6,29);
insert into Guided_Tour values (16,57,2,79,19);
insert into Guided_Tour values (17,54,18,21,3);
insert into Guided_Tour values (18,75,16,16,13);
insert into Guided_Tour values (19,22,5,59,49);
insert into Guided_Tour values (20,4,6,23,40);
insert into Guided_Tour values (21,54,20,28,38);
insert into Guided_Tour values (22,73,15,18,45);
insert into Guided_Tour values (23,21,5,92,25);
insert into Guided_Tour values (24,23,8,61,24);
insert into Guided_Tour values (25,94,18,10,15);
insert into Guided_Tour values (26,9,8,90,38);
insert into Guided_Tour values (27,67,19,36,32);
insert into Guided_Tour values (28,89,11,23,23);
insert into Guided_Tour values (29,14,16,79,36);
insert into Guided_Tour values (30,52,17,88,10);
insert into Guided_Tour values (31,10,6,39,38);
insert into Guided_Tour values (32,4,2,51,1);
insert into Guided_Tour values (33,75,10,12,37);
insert into Guided_Tour values (34,76,1,100,31);
insert into Guided_Tour values (35,89,13,52,8);
insert into Guided_Tour values (36,78,17,22,49);
insert into Guided_Tour values (37,36,13,78,26);
insert into Guided_Tour values (38,67,7,5,48);
insert into Guided_Tour values (39,79,6,45,42);
insert into Guided_Tour values (40,99,12,42,49);
insert into Guided_Tour values (41,50,8,86,15);
insert into Guided_Tour values (42,57,12,4,39);
insert into Guided_Tour values (43,85,8,45,28);
insert into Guided_Tour values (44,67,4,16,16);
insert into Guided_Tour values (45,65,2,15,23);
insert into Guided_Tour values (46,38,9,21,15);
insert into Guided_Tour values (47,18,3,73,3);
insert into Guided_Tour values (48,53,20,78,41);
insert into Guided_Tour values (49,3,10,69,16);
insert into Guided_Tour values (50,39,16,64,7);

insert into Cultural_Site values (1, 'erat eros' , 'lobortis vel' ,22111, '872 Merchant Point' , 'Manassas' , 'Virginia');
insert into Cultural_Site values (2, 'quisque arcu libero' , 'auctor sed tristique' ,20456, '9460 Amoth Center' , 'Washington' , 'District of Columbia');
insert into Cultural_Site values (3, 'non' , 'mattis pulvinar nulla' ,79410, '34 Meadow Valley Center' , 'Lubbock' , 'Texas');
insert into Cultural_Site values (4, 'porttitor id consequat' , 'vitae' ,95155, '83 Oak Point' , 'San Jose' , 'California');
insert into Cultural_Site values (5, 'pellentesque' , 'eget elit sodales' ,91125, '6293 Northridge Road' , 'Pasadena' , 'California');
insert into Cultural_Site values (6, 'maecenas ut' , 'condimentum id luctus' ,79452, '8917 Stone Corner Park' , 'Lubbock' , 'Texas');
insert into Cultural_Site values (7, 'vel ipsum praesent blandit' , 'consequat varius integer' ,33954, '13220 Fairview Alley' , 'Port Charlotte' , 'Florida');
insert into Cultural_Site values (8, 'vulputate elementum nullam varius nulla' , 'sit' ,93740, '38 Cardinal Lane' , 'Fresno' , 'California');
insert into Cultural_Site values (9, 'eros' , 'varius integer' ,45454, '5454 Golf Course Alley' , 'Dayton' , 'Ohio');
insert into Cultural_Site values (10, 'id turpis integer aliquet' , 'sociis' ,91505, '6855 Dorton Trail' , 'Burbank' , 'California');
insert into Cultural_Site values (11, 'felis sed' , 'quis augue' ,32255, '89835 Homewood Point' , 'Jacksonville' , 'Florida');
insert into Cultural_Site values (12, 'lobortis convallis tortor' , 'pede ullamcorper' ,60351, '1235 Fairview Alley' , 'Carol Stream' , 'Illinois');
insert into Cultural_Site values (13, 'nam congue risus semper porta' , 'eu sapien cursus' ,40215, '4036 Merrick Pass' , 'Louisville' , 'Kentucky');
insert into Cultural_Site values (14, 'interdum' , 'quis orci nullam' ,85215, '2602 Magdeline Hill' , 'Mesa' , 'Arizona');
insert into Cultural_Site values (15, 'est phasellus' , 'donec ut dolor' ,88558, '094 4th Drive' , 'El Paso' , 'Texas');
insert into Cultural_Site values (16, 'sagittis sapien cum sociis natoque' , 'eu' ,93111, '898 Carey Lane' , 'Santa Barbara' , 'California');
insert into Cultural_Site values (17, 'quis orci eget orci vehicula' , 'lectus pellentesque' ,10270, '6896 Ridgeview Plaza' , 'New York City' , 'New York');
insert into Cultural_Site values (18, 'neque' , 'tempor convallis nulla' ,12237, '20 Oakridge Avenue' , 'Albany' , 'New York');
insert into Cultural_Site values (19, 'posuere' , 'nibh in hac' ,97240, '5446 Arapahoe Way' , 'Portland' , 'Oregon');
insert into Cultural_Site values (20, 'sed' , 'metus' ,91505, '5242 Northfield Terrace' , 'Burbank' , 'California');
insert into Cultural_Site values (21, 'id' , 'nunc viverra' ,36628, '4 Russell Road' , 'Mobile' , 'Alabama');
insert into Cultural_Site values (22, 'convallis morbi odio' , 'at' ,50347, '7 Buell Drive' , 'Des Moines' , 'Iowa');
insert into Cultural_Site values (23, 'nisl ut volutpat sapien arcu' , 'augue quam sollicitudin' ,48076, '5 Cascade Trail' , 'Southfield' , 'Michigan');
insert into Cultural_Site values (24, 'ac' , 'augue' ,44130, '8 Rigney Pass' , 'Cleveland' , 'Ohio');
insert into Cultural_Site values (25, 'viverra diam' , 'id sapien in' ,38104, '1 Old Gate Park' , 'Memphis' , 'Tennessee');
insert into Cultural_Site values (26, 'lobortis' , 'consectetuer' ,59105, '09 Glendale Point' , 'Billings' , 'Montana');
insert into Cultural_Site values (27, 'facilisi cras non velit' , 'ante ipsum' ,76096, '49126 Bunting Hill' , 'Arlington' , 'Texas');
insert into Cultural_Site values (28, 'justo nec condimentum neque' , 'eros elementum' ,10203, '65 Continental Point' , 'New York City' , 'New York');
insert into Cultural_Site values (29, 'viverra eget congue' , 'congue risus semper' ,13210, '5 Marcy Street' , 'Syracuse' , 'New York');
insert into Cultural_Site values (30, 'vitae' , 'nibh' ,31416, '89056 Forest Run Crossing' , 'Savannah' , 'Georgia');
insert into Cultural_Site values (31, 'nullam molestie' , 'ultrices' ,20167, '546 Doe Crossing Way' , 'Sterling' , 'Virginia');
insert into Cultural_Site values (32, 'porttitor id' , 'volutpat' ,07104, '338 Susan Hill' , 'Newark' , 'New Jersey');
insert into Cultural_Site values (33, 'dui nec nisi' , 'gravida' ,77234, '85 Rockefeller Alley' , 'Houston' , 'Texas');
insert into Cultural_Site values (34, 'ultrices posuere cubilia curae' , 'sapien' ,30245, '3 Gerald Junction' , 'Lawrenceville' , 'Georgia');
insert into Cultural_Site values (35, 'sapien a libero' , 'donec' ,36610, '9940 Fair Oaks Lane' , 'Mobile' , 'Alabama');
insert into Cultural_Site values (36, 'aliquet' , 'ipsum praesent blandit' ,38168, '893 International Avenue' , 'Memphis' , 'Tennessee');
insert into Cultural_Site values (37, 'ultrices posuere cubilia curae duis' , 'amet' ,94245, '9 Oneill Pass' , 'Sacramento' , 'California');
insert into Cultural_Site values (38, 'tristique fusce congue diam id' , 'sem praesent' ,01813, '918 Hayes Parkway' , 'Woburn' , 'Massachusetts');
insert into Cultural_Site values (39, 'tempus vivamus in' , 'quis lectus' ,94280, '4 Northview Park' , 'Sacramento' , 'California');
insert into Cultural_Site values (40, 'elit ac nulla sed' , 'euismod scelerisque quam' ,94064, '3 Londonderry Road' , 'Redwood City' , 'California');
insert into Cultural_Site values (41, 'sapien urna pretium nisl' , 'justo lacinia' ,33169, '9 Farmco Lane' , 'Miami' , 'Florida');
insert into Cultural_Site values (42, 'elementum in hac habitasse platea' , 'sit amet' ,77493, '2 Merry Plaza' , 'Katy' , 'Texas');
insert into Cultural_Site values (43, 'amet nulla quisque' , 'convallis morbi' ,10310, '4 Florence Center' , 'Staten Island' , 'New York');
insert into Cultural_Site values (44, 'vulputate' , 'turpis adipiscing' ,23454, '834 Pennsylvania Road' , 'Virginia Beach' , 'Virginia');
insert into Cultural_Site values (45, 'ut dolor morbi vel' , 'sodales sed tincidunt' ,62525, '844 Claremont Pass' , 'Decatur' , 'Illinois');
insert into Cultural_Site values (46, 'odio' , 'odio consequat' ,75705, '3 Shasta Way' , 'Tyler' , 'Texas');
insert into Cultural_Site values (47, 'nulla pede' , 'orci pede venenatis' ,71914, '78 Loftsgordon Place' , 'Hot Springs National Park' , 'Arkansas');
insert into Cultural_Site values (48, 'a odio in' , 'vel est' ,68197, '7 Emmet Plaza' , 'Omaha' , 'Nebraska');
insert into Cultural_Site values (49, 'tortor quis turpis' , 'vestibulum' ,23203, '391 Crownhardt Parkway' , 'Richmond' , 'Virginia');
insert into Cultural_Site values (50, 'faucibus' , 'viverra pede' ,22908, '91 Ramsey Terrace' , 'Charlottesville' , 'Virginia');

insert into Cultural_Site_Tour (tourID, siteID) values (24, 1);
insert into Cultural_Site_Tour (tourID, siteID) values (30, 2);
insert into Cultural_Site_Tour (tourID, siteID) values (15, 3);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 4);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 5);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 6);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 7);
insert into Cultural_Site_Tour (tourID, siteID) values (46, 8);
insert into Cultural_Site_Tour (tourID, siteID) values (7, 9);
insert into Cultural_Site_Tour (tourID, siteID) values (21, 10);
insert into Cultural_Site_Tour (tourID, siteID) values (2, 11);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 12);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 13);
insert into Cultural_Site_Tour (tourID, siteID) values (32, 14);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 15);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 16);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 17);
insert into Cultural_Site_Tour (tourID, siteID) values (20, 18);
insert into Cultural_Site_Tour (tourID, siteID) values (39, 19);
insert into Cultural_Site_Tour (tourID, siteID) values (46, 20);
insert into Cultural_Site_Tour (tourID, siteID) values (18, 21);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 22);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 23);
insert into Cultural_Site_Tour (tourID, siteID) values (41, 24);
insert into Cultural_Site_Tour (tourID, siteID) values (27, 25);
insert into Cultural_Site_Tour (tourID, siteID) values (15, 26);
insert into Cultural_Site_Tour (tourID, siteID) values (41, 27);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 28);
insert into Cultural_Site_Tour (tourID, siteID) values (48, 29);
insert into Cultural_Site_Tour (tourID, siteID) values (27, 30);
insert into Cultural_Site_Tour (tourID, siteID) values (39, 31);
insert into Cultural_Site_Tour (tourID, siteID) values (31, 32);
insert into Cultural_Site_Tour (tourID, siteID) values (48, 33);
insert into Cultural_Site_Tour (tourID, siteID) values (45, 34);
insert into Cultural_Site_Tour (tourID, siteID) values (16, 35);
insert into Cultural_Site_Tour (tourID, siteID) values (16, 36);
insert into Cultural_Site_Tour (tourID, siteID) values (10, 37);
insert into Cultural_Site_Tour (tourID, siteID) values (25, 38);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 39);
insert into Cultural_Site_Tour (tourID, siteID) values (36, 40);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 41);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 42);
insert into Cultural_Site_Tour (tourID, siteID) values (4, 43);
insert into Cultural_Site_Tour (tourID, siteID) values (19, 44);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 45);
insert into Cultural_Site_Tour (tourID, siteID) values (12, 46);
insert into Cultural_Site_Tour (tourID, siteID) values (15, 47);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 48);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 49);
insert into Cultural_Site_Tour (tourID, siteID) values (4, 50);
insert into Cultural_Site_Tour (tourID, siteID) values (29, 1);
insert into Cultural_Site_Tour (tourID, siteID) values (12, 2);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 3);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 4);
insert into Cultural_Site_Tour (tourID, siteID) values (43, 5);
insert into Cultural_Site_Tour (tourID, siteID) values (32, 6);
insert into Cultural_Site_Tour (tourID, siteID) values (17, 7);
insert into Cultural_Site_Tour (tourID, siteID) values (20, 8);
insert into Cultural_Site_Tour (tourID, siteID) values (19, 9);
insert into Cultural_Site_Tour (tourID, siteID) values (34, 10);
insert into Cultural_Site_Tour (tourID, siteID) values (46, 11);
insert into Cultural_Site_Tour (tourID, siteID) values (14, 12);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 13);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 14);
insert into Cultural_Site_Tour (tourID, siteID) values (39, 15);
insert into Cultural_Site_Tour (tourID, siteID) values (12, 16);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 17);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 18);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 19);
insert into Cultural_Site_Tour (tourID, siteID) values (42, 20);
insert into Cultural_Site_Tour (tourID, siteID) values (43, 21);
insert into Cultural_Site_Tour (tourID, siteID) values (2, 22);
insert into Cultural_Site_Tour (tourID, siteID) values (43, 23);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 24);
insert into Cultural_Site_Tour (tourID, siteID) values (45, 25);
insert into Cultural_Site_Tour (tourID, siteID) values (14, 26);
insert into Cultural_Site_Tour (tourID, siteID) values (50, 27);
insert into Cultural_Site_Tour (tourID, siteID) values (50, 28);
insert into Cultural_Site_Tour (tourID, siteID) values (47, 29);
insert into Cultural_Site_Tour (tourID, siteID) values (45, 30);
insert into Cultural_Site_Tour (tourID, siteID) values (12, 31);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 32);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 33);
insert into Cultural_Site_Tour (tourID, siteID) values (17, 34);
insert into Cultural_Site_Tour (tourID, siteID) values (21, 35);
insert into Cultural_Site_Tour (tourID, siteID) values (7, 36);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 37);
insert into Cultural_Site_Tour (tourID, siteID) values (14, 38);
insert into Cultural_Site_Tour (tourID, siteID) values (27, 39);
insert into Cultural_Site_Tour (tourID, siteID) values (39, 40);
insert into Cultural_Site_Tour (tourID, siteID) values (1, 41);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 42);
insert into Cultural_Site_Tour (tourID, siteID) values (1, 43);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 44);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 45);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 46);
insert into Cultural_Site_Tour (tourID, siteID) values (41, 47);
insert into Cultural_Site_Tour (tourID, siteID) values (39, 48);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 49);
insert into Cultural_Site_Tour (tourID, siteID) values (17, 50);
insert into Cultural_Site_Tour (tourID, siteID) values (32, 1);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 2);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 3);
insert into Cultural_Site_Tour (tourID, siteID) values (1, 4);
insert into Cultural_Site_Tour (tourID, siteID) values (40, 5);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 6);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 7);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 8);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 9);
insert into Cultural_Site_Tour (tourID, siteID) values (48, 10);
insert into Cultural_Site_Tour (tourID, siteID) values (8, 11);
insert into Cultural_Site_Tour (tourID, siteID) values (21, 12);
insert into Cultural_Site_Tour (tourID, siteID) values (36, 13);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 14);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 15);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 16);
insert into Cultural_Site_Tour (tourID, siteID) values (13, 17);
insert into Cultural_Site_Tour (tourID, siteID) values (18, 18);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 19);
insert into Cultural_Site_Tour (tourID, siteID) values (13, 20);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 21);
insert into Cultural_Site_Tour (tourID, siteID) values (34, 22);
insert into Cultural_Site_Tour (tourID, siteID) values (21, 23);
insert into Cultural_Site_Tour (tourID, siteID) values (13, 24);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 25);
insert into Cultural_Site_Tour (tourID, siteID) values (4, 26);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 27);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 28);
insert into Cultural_Site_Tour (tourID, siteID) values (10, 29);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 30);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 31);
insert into Cultural_Site_Tour (tourID, siteID) values (30, 32);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 33);
insert into Cultural_Site_Tour (tourID, siteID) values (29, 34);
insert into Cultural_Site_Tour (tourID, siteID) values (25, 35);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 36);
insert into Cultural_Site_Tour (tourID, siteID) values (23, 37);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 38);
insert into Cultural_Site_Tour (tourID, siteID) values (10, 39);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 40);
insert into Cultural_Site_Tour (tourID, siteID) values (7, 41);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 42);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 43);
insert into Cultural_Site_Tour (tourID, siteID) values (40, 44);
insert into Cultural_Site_Tour (tourID, siteID) values (10, 45);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 46);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 47);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 48);
insert into Cultural_Site_Tour (tourID, siteID) values (9, 49);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 50);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 1);
insert into Cultural_Site_Tour (tourID, siteID) values (23, 2);
insert into Cultural_Site_Tour (tourID, siteID) values (9, 3);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 4);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 5);
insert into Cultural_Site_Tour (tourID, siteID) values (42, 6);
insert into Cultural_Site_Tour (tourID, siteID) values (34, 7);
insert into Cultural_Site_Tour (tourID, siteID) values (14, 8);
insert into Cultural_Site_Tour (tourID, siteID) values (45, 9);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 10);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 11);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 12);
insert into Cultural_Site_Tour (tourID, siteID) values (26, 13);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 14);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 15);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 16);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 17);
insert into Cultural_Site_Tour (tourID, siteID) values (50, 18);
insert into Cultural_Site_Tour (tourID, siteID) values (46, 19);
insert into Cultural_Site_Tour (tourID, siteID) values (50, 20);
insert into Cultural_Site_Tour (tourID, siteID) values (9, 21);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 22);
insert into Cultural_Site_Tour (tourID, siteID) values (9, 23);
insert into Cultural_Site_Tour (tourID, siteID) values (33, 24);
insert into Cultural_Site_Tour (tourID, siteID) values (35, 25);
insert into Cultural_Site_Tour (tourID, siteID) values (26, 26);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 27);
insert into Cultural_Site_Tour (tourID, siteID) values (49, 28);
insert into Cultural_Site_Tour (tourID, siteID) values (50, 29);
insert into Cultural_Site_Tour (tourID, siteID) values (48, 30);
insert into Cultural_Site_Tour (tourID, siteID) values (5, 31);
insert into Cultural_Site_Tour (tourID, siteID) values (40, 32);
insert into Cultural_Site_Tour (tourID, siteID) values (27, 33);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 34);
insert into Cultural_Site_Tour (tourID, siteID) values (24, 35);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 36);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 37);
insert into Cultural_Site_Tour (tourID, siteID) values (41, 38);
insert into Cultural_Site_Tour (tourID, siteID) values (14, 39);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 40);
insert into Cultural_Site_Tour (tourID, siteID) values (31, 41);
insert into Cultural_Site_Tour (tourID, siteID) values (13, 42);
insert into Cultural_Site_Tour (tourID, siteID) values (20, 43);
insert into Cultural_Site_Tour (tourID, siteID) values (3, 44);
insert into Cultural_Site_Tour (tourID, siteID) values (32, 45);
insert into Cultural_Site_Tour (tourID, siteID) values (28, 46);
insert into Cultural_Site_Tour (tourID, siteID) values (30, 47);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 48);
insert into Cultural_Site_Tour (tourID, siteID) values (1, 49);
insert into Cultural_Site_Tour (tourID, siteID) values (13, 50);
insert into Cultural_Site_Tour (tourID, siteID) values (7, 1);
insert into Cultural_Site_Tour (tourID, siteID) values (7, 2);
insert into Cultural_Site_Tour (tourID, siteID) values (16, 3);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 4);
insert into Cultural_Site_Tour (tourID, siteID) values (11, 5);
insert into Cultural_Site_Tour (tourID, siteID) values (18, 6);
insert into Cultural_Site_Tour (tourID, siteID) values (44, 7);
insert into Cultural_Site_Tour (tourID, siteID) values (40, 8);
insert into Cultural_Site_Tour (tourID, siteID) values (2, 9);
insert into Cultural_Site_Tour (tourID, siteID) values (45, 10);
insert into Cultural_Site_Tour (tourID, siteID) values (48, 11);
insert into Cultural_Site_Tour (tourID, siteID) values (40, 12);
insert into Cultural_Site_Tour (tourID, siteID) values (36, 13);
insert into Cultural_Site_Tour (tourID, siteID) values (38, 14);
insert into Cultural_Site_Tour (tourID, siteID) values (8, 15);
insert into Cultural_Site_Tour (tourID, siteID) values (6, 16);
insert into Cultural_Site_Tour (tourID, siteID) values (37, 17);
insert into Cultural_Site_Tour (tourID, siteID) values (2, 18);
insert into Cultural_Site_Tour (tourID, siteID) values (4, 19);
insert into Cultural_Site_Tour (tourID, siteID) values (22, 20);

insert into Research_Archive values (1, 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.' , 'Yanwang' ,49);
insert into Research_Archive values (2, 'Nulla mollis molestie lorem. Quisque ut erat.' , 'Yashan' ,26);
insert into Research_Archive values (3, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' , 'Yamaranguila' ,44);
insert into Research_Archive values (4, 'Nulla ut erat id mauris vulputate elementum. Nullam varius.' , 'Cibingbin' ,25);
insert into Research_Archive values (5, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' , 'Lyon' ,44);
insert into Research_Archive values (6, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.' , 'Daloa' ,29);
insert into Research_Archive values (7, 'Nulla facilisi.' , 'Phibun Mangsahan' ,26);
insert into Research_Archive values (8, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.' , 'Sanhe' ,30);
insert into Research_Archive values (9, 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.' , 'Mýto' ,13);
insert into Research_Archive values (10, 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.' , 'Khombole' ,27);
insert into Research_Archive values (11, 'Morbi a ipsum. Integer a nibh. In quis justo.' , 'Ivanava' ,4);
insert into Research_Archive values (12, 'In eleifend quam a odio.' , 'San Juan' ,8);
insert into Research_Archive values (13, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' , 'Maguyam' ,48);
insert into Research_Archive values (14, 'Curabitur in libero ut massa volutpat convallis.' , 'Damaying' ,20);
insert into Research_Archive values (15, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.' , 'NDjamena' ,1);
insert into Research_Archive values (16, 'Duis aliquam convallis nunc.' , 'Juvisy-sur-Orge' ,37);
insert into Research_Archive values (17, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' , 'Tsagaan-Olom' ,29);
insert into Research_Archive values (18, 'Proin risus.' , 'Warungbanten' ,43);
insert into Research_Archive values (19, 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.' , 'Majia' ,33);
insert into Research_Archive values (20, 'Nulla mollis molestie lorem. Quisque ut erat.' , 'Oakland' ,14);
insert into Research_Archive values (21, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' , 'Västervik' ,29);
insert into Research_Archive values (22, 'Donec ut mauris eget massa tempor convallis.' , 'Kerva' ,11);
insert into Research_Archive values (23, 'Mauris ullamcorper purus sit amet nulla.' , 'Qinjiang' ,32);
insert into Research_Archive values (24, 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.' , 'Verkhniy Baskunchak' ,50);
insert into Research_Archive values (25, 'Proin eu mi.' , 'Zblewo' ,33);
insert into Research_Archive values (26, 'Aenean auctor gravida sem.' , 'Nanzhang Chengguanzhen' ,45);
insert into Research_Archive values (27, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.' , 'Buqei‘a' ,47);
insert into Research_Archive values (28, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.' , 'Yandun' ,15);
insert into Research_Archive values (29, 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.' , 'Lutou' ,41);
insert into Research_Archive values (30, 'Morbi porttitor lorem id ligula.' , 'Pu’an' ,32);
insert into Research_Archive values (31, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.' , 'Bile' ,4);
insert into Research_Archive values (32, 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.' , 'Diavatá' ,41);
insert into Research_Archive values (33, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.' , 'Yanping' ,30);
insert into Research_Archive values (34, 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.' , 'Hengxi' ,46);
insert into Research_Archive values (35, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.' , 'Żyrardów' ,26);
insert into Research_Archive values (36, 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.' , 'Bourges' ,12);
insert into Research_Archive values (37, 'Nam dui.' , 'Nanhe' ,31);
insert into Research_Archive values (38, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.' , 'Kungsbacka' ,11);
insert into Research_Archive values (39, 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' , 'Agdangan' ,30);
insert into Research_Archive values (40, 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.' , 'Yinhe' ,9);
insert into Research_Archive values (41, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.' , 'San Antonio' ,10);
insert into Research_Archive values (42, 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.' , 'Shinshiro' ,32);
insert into Research_Archive values (43, 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.' , 'Luklukan' ,34);
insert into Research_Archive values (44, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.' , 'Malaga' ,41);
insert into Research_Archive values (45, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.' , 'Issad' ,25);
insert into Research_Archive values (46, 'In blandit ultrices enim.' , 'Pavliš' ,50);
insert into Research_Archive values (47, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' , 'Toutuo' ,25);
insert into Research_Archive values (48, 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' , 'Ban Mo' ,43);
insert into Research_Archive values (49, 'Pellentesque ultrices mattis odio.' , 'Kabaty' ,40);
insert into Research_Archive values (50, 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.' , 'Velyki Kopany' ,26);

insert into Activity_Destination values (19,23);
insert into Activity_Destination values (38,7);
insert into Activity_Destination values (6,9);
insert into Activity_Destination values (1,2);
insert into Activity_Destination values (21,20);
insert into Activity_Destination values (36,41);
insert into Activity_Destination values (20,34);
insert into Activity_Destination values (19,45);
insert into Activity_Destination values (30,47);
insert into Activity_Destination values (3,45);
insert into Activity_Destination values (16,2);
insert into Activity_Destination values (34,31);
insert into Activity_Destination values (27,20);
insert into Activity_Destination values (28,8);
insert into Activity_Destination values (36,46);
insert into Activity_Destination values (27,24);
insert into Activity_Destination values (28,24);
insert into Activity_Destination values (45,47);
insert into Activity_Destination values (22,9);
insert into Activity_Destination values (46,25);
insert into Activity_Destination values (42,4);
insert into Activity_Destination values (7,6);
insert into Activity_Destination values (46,14);
insert into Activity_Destination values (8,21);
insert into Activity_Destination values (39,24);
insert into Activity_Destination values (43,3);
insert into Activity_Destination values (42,39);
insert into Activity_Destination values (41,26);
insert into Activity_Destination values (24,21);
insert into Activity_Destination values (39,31);
insert into Activity_Destination values (16,9);
insert into Activity_Destination values (31,28);
insert into Activity_Destination values (17,28);
insert into Activity_Destination values (43,4);
insert into Activity_Destination values (21,9);
insert into Activity_Destination values (35,46);
insert into Activity_Destination values (28,16);
insert into Activity_Destination values (28,35);
insert into Activity_Destination values (46,29);
insert into Activity_Destination values (15,11);
insert into Activity_Destination values (19,1);
insert into Activity_Destination values (32,9);
insert into Activity_Destination values (37,38);
insert into Activity_Destination values (26,12);
insert into Activity_Destination values (15,24);
insert into Activity_Destination values (46,2);
insert into Activity_Destination values (32,1);
insert into Activity_Destination values (16,35);
insert into Activity_Destination values (10,39);
insert into Activity_Destination values (44,6);
insert into Activity_Destination values (6,2);
insert into Activity_Destination values (33,13);
insert into Activity_Destination values (48,13);
insert into Activity_Destination values (31,28);
insert into Activity_Destination values (38,10);
insert into Activity_Destination values (40,42);
insert into Activity_Destination values (50,7);
insert into Activity_Destination values (14,18);
insert into Activity_Destination values (8,8);
insert into Activity_Destination values (24,44);
insert into Activity_Destination values (17,3);
insert into Activity_Destination values (50,46);
insert into Activity_Destination values (48,22);
insert into Activity_Destination values (8,23);
insert into Activity_Destination values (5,36);
insert into Activity_Destination values (47,18);
insert into Activity_Destination values (25,26);
insert into Activity_Destination values (46,37);
insert into Activity_Destination values (7,8);
insert into Activity_Destination values (38,28);
insert into Activity_Destination values (33,3);
insert into Activity_Destination values (37,15);
insert into Activity_Destination values (36,38);
insert into Activity_Destination values (31,43);
insert into Activity_Destination values (38,48);
insert into Activity_Destination values (22,19);
insert into Activity_Destination values (38,2);
insert into Activity_Destination values (48,12);
insert into Activity_Destination values (19,45);
insert into Activity_Destination values (38,9);
insert into Activity_Destination values (15,2);
insert into Activity_Destination values (23,7);
insert into Activity_Destination values (40,37);
insert into Activity_Destination values (18,18);
insert into Activity_Destination values (33,27);
insert into Activity_Destination values (41,41);
insert into Activity_Destination values (46,36);
insert into Activity_Destination values (31,42);
insert into Activity_Destination values (43,24);
insert into Activity_Destination values (10,23);
insert into Activity_Destination values (41,13);
insert into Activity_Destination values (16,38);
insert into Activity_Destination values (3,15);
insert into Activity_Destination values (8,19);
insert into Activity_Destination values (39,6);
insert into Activity_Destination values (41,4);
insert into Activity_Destination values (40,36);
insert into Activity_Destination values (45,42);
insert into Activity_Destination values (15,39);
insert into Activity_Destination values (20,10);
insert into Activity_Destination values (42,35);
insert into Activity_Destination values (24,46);
insert into Activity_Destination values (14,30);
insert into Activity_Destination values (43,35);
insert into Activity_Destination values (18,27);
insert into Activity_Destination values (19,10);
insert into Activity_Destination values (6,28);
insert into Activity_Destination values (24,45);
insert into Activity_Destination values (35,34);
insert into Activity_Destination values (36,18);
insert into Activity_Destination values (48,36);
insert into Activity_Destination values (36,19);
insert into Activity_Destination values (43,10);
insert into Activity_Destination values (5,38);
insert into Activity_Destination values (26,36);
insert into Activity_Destination values (9,31);
insert into Activity_Destination values (38,9);
insert into Activity_Destination values (3,19);
insert into Activity_Destination values (19,48);
insert into Activity_Destination values (19,45);
insert into Activity_Destination values (48,19);
insert into Activity_Destination values (44,27);
insert into Activity_Destination values (18,6);
insert into Activity_Destination values (38,17);
insert into Activity_Destination values (44,21);
insert into Activity_Destination values (19,49);
insert into Activity_Destination values (16,22);
insert into Activity_Destination values (48,20);
insert into Activity_Destination values (25,29);
insert into Activity_Destination values (3,45);
insert into Activity_Destination values (16,34);
insert into Activity_Destination values (34,3);
insert into Activity_Destination values (23,3);
insert into Activity_Destination values (5,33);
insert into Activity_Destination values (18,44);
insert into Activity_Destination values (33,50);
insert into Activity_Destination values (48,43);
insert into Activity_Destination values (31,23);
insert into Activity_Destination values (39,5);
insert into Activity_Destination values (6,41);
insert into Activity_Destination values (13,49);
insert into Activity_Destination values (23,22);
insert into Activity_Destination values (8,3);
insert into Activity_Destination values (23,6);
insert into Activity_Destination values (33,23);
insert into Activity_Destination values (50,13);
insert into Activity_Destination values (49,3);
insert into Activity_Destination values (28,31);
insert into Activity_Destination values (18,35);
insert into Activity_Destination values (27,21);
insert into Activity_Destination values (37,46);
insert into Activity_Destination values (35,25);
insert into Activity_Destination values (27,24);
insert into Activity_Destination values (25,29);
insert into Activity_Destination values (23,19);
insert into Activity_Destination values (3,23);
insert into Activity_Destination values (29,12);
insert into Activity_Destination values (26,45);
insert into Activity_Destination values (7,29);
insert into Activity_Destination values (6,14);
insert into Activity_Destination values (32,26);
insert into Activity_Destination values (31,31);
insert into Activity_Destination values (40,4);
insert into Activity_Destination values (2,16);
insert into Activity_Destination values (35,33);
insert into Activity_Destination values (31,27);
insert into Activity_Destination values (32,20);
insert into Activity_Destination values (4,37);
insert into Activity_Destination values (1,2);
insert into Activity_Destination values (6,42);
insert into Activity_Destination values (32,9);
insert into Activity_Destination values (24,38);
insert into Activity_Destination values (47,25);
insert into Activity_Destination values (6,12);
insert into Activity_Destination values (48,50);
insert into Activity_Destination values (19,25);
insert into Activity_Destination values (4,36);
insert into Activity_Destination values (16,22);
insert into Activity_Destination values (42,6);
insert into Activity_Destination values (9,14);
insert into Activity_Destination values (40,47);
insert into Activity_Destination values (47,38);
insert into Activity_Destination values (45,13);
insert into Activity_Destination values (48,32);
insert into Activity_Destination values (18,29);
insert into Activity_Destination values (2,32);
insert into Activity_Destination values (45,36);
insert into Activity_Destination values (22,5);
insert into Activity_Destination values (3,39);
insert into Activity_Destination values (27,30);
insert into Activity_Destination values (20,22);
insert into Activity_Destination values (2,8);
insert into Activity_Destination values (27,17);
insert into Activity_Destination values (46,5);
insert into Activity_Destination values (15,16);
insert into Activity_Destination values (42,31);
insert into Activity_Destination values (14,22);
insert into Activity_Destination values (14,39);
insert into Activity_Destination values (13,48);
insert into Activity_Destination values (20,23);
insert into Activity_Destination values (7,44);
insert into Activity_Destination values (13,9);
insert into Activity_Destination values (12,17);
insert into Activity_Destination values (20,22);
insert into Activity_Destination values (7,10);
insert into Activity_Destination values (29,18);
insert into Activity_Destination values (9,13);
insert into Activity_Destination values (12,12);
insert into Activity_Destination values (40,18);
insert into Activity_Destination values (14,27);
insert into Activity_Destination values (10,40);
insert into Activity_Destination values (27,46);
insert into Activity_Destination values (9,30);
insert into Activity_Destination values (47,25);
insert into Activity_Destination values (6,11);
insert into Activity_Destination values (17,29);
insert into Activity_Destination values (42,13);
insert into Activity_Destination values (22,25);
insert into Activity_Destination values (47,36);
insert into Activity_Destination values (47,20);

insert into Customer_Flight values(20,1);
insert into Customer_Flight values(18,2);
insert into Customer_Flight values(29,3);
insert into Customer_Flight values(29,4);
insert into Customer_Flight values(19,5);
insert into Customer_Flight values(35,6);
insert into Customer_Flight values(4,7);
insert into Customer_Flight values(19,8);
insert into Customer_Flight values(34,9);
insert into Customer_Flight values(20,10);
insert into Customer_Flight values(45,11);
insert into Customer_Flight values(48,12);
insert into Customer_Flight values(18,13);
insert into Customer_Flight values(22,14);
insert into Customer_Flight values(44,15);
insert into Customer_Flight values(36,16);
insert into Customer_Flight values(16,17);
insert into Customer_Flight values(23,18);
insert into Customer_Flight values(16,19);
insert into Customer_Flight values(12,20);
insert into Customer_Flight values(24,21);
insert into Customer_Flight values(19,22);
insert into Customer_Flight values(29,23);
insert into Customer_Flight values(1,24);
insert into Customer_Flight values(13,25);
insert into Customer_Flight values(41,26);
insert into Customer_Flight values(26,27);
insert into Customer_Flight values(13,28);
insert into Customer_Flight values(47,29);
insert into Customer_Flight values(12,30);
insert into Customer_Flight values(30,31);
insert into Customer_Flight values(23,32);
insert into Customer_Flight values(50,33);
insert into Customer_Flight values(22,34);
insert into Customer_Flight values(47,35);
insert into Customer_Flight values(38,36);
insert into Customer_Flight values(39,37);
insert into Customer_Flight values(45,38);
insert into Customer_Flight values(50,39);
insert into Customer_Flight values(50,40);
insert into Customer_Flight values(40,41);
insert into Customer_Flight values(38,42);
insert into Customer_Flight values(44,43);
insert into Customer_Flight values(25,44);
insert into Customer_Flight values(34,45);
insert into Customer_Flight values(15,46);
insert into Customer_Flight values(23,47);
insert into Customer_Flight values(31,48);
insert into Customer_Flight values(47,49);
insert into Customer_Flight values(11,50);
insert into Customer_Flight values(50,1);
insert into Customer_Flight values(41,2);
insert into Customer_Flight values(11,3);
insert into Customer_Flight values(5,4);
insert into Customer_Flight values(31,5);
insert into Customer_Flight values(12,6);
insert into Customer_Flight values(4,7);
insert into Customer_Flight values(14,8);
insert into Customer_Flight values(40,9);
insert into Customer_Flight values(29,10);
insert into Customer_Flight values(39,11);
insert into Customer_Flight values(41,12);
insert into Customer_Flight values(36,13);
insert into Customer_Flight values(13,14);
insert into Customer_Flight values(1,15);
insert into Customer_Flight values(21,16);
insert into Customer_Flight values(20,17);
insert into Customer_Flight values(39,18);
insert into Customer_Flight values(7,19);
insert into Customer_Flight values(47,20);
insert into Customer_Flight values(9,21);
insert into Customer_Flight values(13,22);
insert into Customer_Flight values(1,23);
insert into Customer_Flight values(23,24);
insert into Customer_Flight values(28,25);
insert into Customer_Flight values(48,26);
insert into Customer_Flight values(46,27);
insert into Customer_Flight values(34,28);
insert into Customer_Flight values(17,29);
insert into Customer_Flight values(46,30);
insert into Customer_Flight values(37,31);
insert into Customer_Flight values(12,32);
insert into Customer_Flight values(14,33);
insert into Customer_Flight values(46,34);
insert into Customer_Flight values(15,35);
insert into Customer_Flight values(8,36);
insert into Customer_Flight values(10,37);
insert into Customer_Flight values(19,38);
insert into Customer_Flight values(4,39);
insert into Customer_Flight values(2,40);
insert into Customer_Flight values(50,41);
insert into Customer_Flight values(15,42);
insert into Customer_Flight values(17,43);
insert into Customer_Flight values(30,44);
insert into Customer_Flight values(36,45);
insert into Customer_Flight values(23,46);
insert into Customer_Flight values(19,47);
insert into Customer_Flight values(10,48);
insert into Customer_Flight values(11,49);
insert into Customer_Flight values(47,50);
insert into Customer_Flight values(19,1);
insert into Customer_Flight values(4,2);
insert into Customer_Flight values(4,3);
insert into Customer_Flight values(1,4);
insert into Customer_Flight values(48,5);
insert into Customer_Flight values(29,6);
insert into Customer_Flight values(32,7);
insert into Customer_Flight values(31,8);
insert into Customer_Flight values(31,9);
insert into Customer_Flight values(41,10);
insert into Customer_Flight values(47,11);
insert into Customer_Flight values(35,12);
insert into Customer_Flight values(15,13);
insert into Customer_Flight values(22,14);
insert into Customer_Flight values(28,15);
insert into Customer_Flight values(50,16);
insert into Customer_Flight values(26,17);
insert into Customer_Flight values(39,18);
insert into Customer_Flight values(50,19);
insert into Customer_Flight values(7,20);
insert into Customer_Flight values(34,21);
insert into Customer_Flight values(41,22);
insert into Customer_Flight values(47,23);
insert into Customer_Flight values(48,24);
insert into Customer_Flight values(45,25);
insert into Customer_Flight values(34,26);
insert into Customer_Flight values(25,27);
insert into Customer_Flight values(46,28);
insert into Customer_Flight values(4,29);
insert into Customer_Flight values(45,30);
insert into Customer_Flight values(21,31);
insert into Customer_Flight values(39,32);
insert into Customer_Flight values(33,33);
insert into Customer_Flight values(34,34);
insert into Customer_Flight values(17,35);
insert into Customer_Flight values(39,36);
insert into Customer_Flight values(33,37);
insert into Customer_Flight values(12,38);
insert into Customer_Flight values(9,39);
insert into Customer_Flight values(31,40);
insert into Customer_Flight values(17,41);
insert into Customer_Flight values(12,42);
insert into Customer_Flight values(35,43);
insert into Customer_Flight values(8,44);
insert into Customer_Flight values(24,45);
insert into Customer_Flight values(9,46);
insert into Customer_Flight values(4,47);
insert into Customer_Flight values(50,48);
insert into Customer_Flight values(12,49);
insert into Customer_Flight values(14,50);
insert into Customer_Flight values(45,1);
insert into Customer_Flight values(18,2);
insert into Customer_Flight values(49,3);
insert into Customer_Flight values(5,4);
insert into Customer_Flight values(31,5);
insert into Customer_Flight values(30,6);
insert into Customer_Flight values(1,7);
insert into Customer_Flight values(12,8);
insert into Customer_Flight values(23,9);
insert into Customer_Flight values(19,10);
insert into Customer_Flight values(44,11);
insert into Customer_Flight values(38,12);
insert into Customer_Flight values(28,13);
insert into Customer_Flight values(43,14);
insert into Customer_Flight values(3,15);
insert into Customer_Flight values(10,16);
insert into Customer_Flight values(36,17);
insert into Customer_Flight values(5,18);
insert into Customer_Flight values(38,19);
insert into Customer_Flight values(22,20);
insert into Customer_Flight values(47,21);
insert into Customer_Flight values(41,22);
insert into Customer_Flight values(2,23);
insert into Customer_Flight values(46,24);
insert into Customer_Flight values(49,25);
insert into Customer_Flight values(48,26);
insert into Customer_Flight values(23,27);
insert into Customer_Flight values(30,28);
insert into Customer_Flight values(27,29);
insert into Customer_Flight values(29,30);
insert into Customer_Flight values(7,31);
insert into Customer_Flight values(47,32);
insert into Customer_Flight values(15,33);
insert into Customer_Flight values(41,34);
insert into Customer_Flight values(26,35);
insert into Customer_Flight values(37,36);
insert into Customer_Flight values(19,37);
insert into Customer_Flight values(19,38);
insert into Customer_Flight values(19,39);
insert into Customer_Flight values(15,40);
insert into Customer_Flight values(20,41);
insert into Customer_Flight values(34,42);
insert into Customer_Flight values(2,43);
insert into Customer_Flight values(6,44);
insert into Customer_Flight values(36,45);
insert into Customer_Flight values(50,46);
insert into Customer_Flight values(23,47);
insert into Customer_Flight values(48,48);
insert into Customer_Flight values(3,49);
insert into Customer_Flight values(3,50);
insert into Customer_Flight values(25,1);
insert into Customer_Flight values(32,2);
insert into Customer_Flight values(37,3);
insert into Customer_Flight values(28,4);
insert into Customer_Flight values(15,5);
insert into Customer_Flight values(1,6);
insert into Customer_Flight values(4,7);
insert into Customer_Flight values(42,8);
insert into Customer_Flight values(12,9);
insert into Customer_Flight values(29,10);
insert into Customer_Flight values(45,11);
insert into Customer_Flight values(12,12);
insert into Customer_Flight values(2,13);
insert into Customer_Flight values(9,14);
insert into Customer_Flight values(7,15);
insert into Customer_Flight values(19,16);
insert into Customer_Flight values(25,17);
insert into Customer_Flight values(43,18);
insert into Customer_Flight values(24,19);
insert into Customer_Flight values(29,20);

insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (1, 39, 4, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '2022-07-04');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (2, 43, 4, 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2021-11-20');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (3, 48, 2, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', '2021-08-29');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (4, 48, 4, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', '2021-08-07');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (5, 32, 1, 'Quisque ut erat. Curabitur gravida nisi at nibh.', '2023-07-24');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (6, 18, 9, 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', '2023-01-15');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (7, 29, 3, 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', '2022-06-10');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (8, 4, 8, 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '2023-05-18');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (9, 49, 5, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2023-03-26');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (10, 13, 1, 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2023-07-26');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (11, 3, 9, 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.', '2022-01-13');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (12, 47, 9, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '2023-01-20');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (13, 44, 7, 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', '2021-08-05');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (14, 46, 5, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', '2021-03-01');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (15, 19, 9, 'Maecenas ut massa quis augue luctus tincidunt.', '2023-02-13');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (16, 37, 10, 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '2021-07-19');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (17, 28, 6, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2022-05-03');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (18, 11, 1, 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '2023-09-25');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (19, 47, 8, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2022-05-03');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (20, 14, 1, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2021-03-05');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (21, 47, 6, 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', '2021-08-16');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (22, 36, 8, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '2022-07-01');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (23, 48, 4, 'Donec semper sapien a libero.', '2023-01-06');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (24, 30, 7, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2021-09-23');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (25, 2, 5, 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.', '2023-01-14');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (26, 2, 9, 'Nam tristique tortor eu pede.', '2022-03-27');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (27, 10, 3, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2021-11-13');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (28, 8, 1, 'Proin eu mi. Nulla ac enim.', '2021-08-06');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (29, 48, 10, 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2022-04-27');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (30, 7, 9, 'In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '2023-05-26');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (31, 2, 6, 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2022-05-28');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (32, 7, 10, 'Integer a nibh. In quis justo.', '2021-07-26');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (33, 46, 1, 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', '2022-02-14');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (34, 8, 7, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue.', '2023-05-01');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (35, 14, 5, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '2022-04-29');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (36, 38, 5, 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '2022-07-06');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (37, 28, 1, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2022-05-25');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (38, 21, 9, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2023-03-11');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (39, 34, 2, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', '2021-10-15');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (40, 22, 8, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', '2023-04-11');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (41, 11, 9, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '2023-05-05');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (42, 2, 9, 'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.', '2021-05-14');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (43, 29, 1, 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', '2021-08-03');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (44, 26, 8, 'Aenean sit amet justo.', '2023-06-09');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (45, 44, 1, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.', '2023-10-20');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (46, 13, 1, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', '2021-09-03');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (47, 5, 3, 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', '2023-03-19');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (48, 18, 7, 'Nunc nisl.', '2021-05-25');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (49, 10, 9, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', '2023-05-20');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (50, 37, 2, 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2021-08-22');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (51, 20, 2, 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2022-02-20');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (52, 13, 8, 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '2023-11-13');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (53, 1, 8, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.', '2023-09-05');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (54, 25, 6, 'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', '2021-09-02');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (55, 17, 8, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', '2023-07-30');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (56, 4, 6, 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', '2022-09-15');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (57, 46, 8, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', '2023-02-11');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (58, 44, 1, 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2022-12-30');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (59, 10, 8, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2023-03-02');
insert into Visit_Memo (memoid, employeeid, duration, notes, date) values (60, 26, 9, 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', '2022-12-04');

insert into Secondary_Traveler values (1, 'Sidnee' , 'Tebbit' ,22);
insert into Secondary_Traveler values (2, 'Henrietta' , 'Kennerknecht' ,44);
insert into Secondary_Traveler values (3, 'Sigismond' , 'Eaken' ,45);
insert into Secondary_Traveler values (4, 'Martin' , 'Raistrick' ,22);
insert into Secondary_Traveler values (5, 'Lionello' , 'Haynesford' ,24);
insert into Secondary_Traveler values (6, 'Avril' , 'Severwright' ,17);
insert into Secondary_Traveler values (7, 'Jessalin' , 'Harsant' ,1);
insert into Secondary_Traveler values (8, 'Eugenius' , 'Gollard' ,15);
insert into Secondary_Traveler values (9, 'Collen' , 'Bichener' ,17);
insert into Secondary_Traveler values (10, 'Karlene' , 'Rosenblath' ,6);
insert into Secondary_Traveler values (11, 'Kincaid' , 'Borwick' ,12);
insert into Secondary_Traveler values (12, 'Geneva' , 'Izaks' ,39);
insert into Secondary_Traveler values (13, 'Mildrid' , 'Fuentes' ,8);
insert into Secondary_Traveler values (14, 'Jannel' , 'Sheryne' ,41);
insert into Secondary_Traveler values (15, 'Craggy' , 'Kellert' ,18);
insert into Secondary_Traveler values (16, 'Katha' , 'Fairnie' ,37);
insert into Secondary_Traveler values (17, 'Betsy' , 'Crickmore' ,26);
insert into Secondary_Traveler values (18, 'Monique' , 'Olrenshaw' ,5);
insert into Secondary_Traveler values (19, 'Taddeo' , 'Dolbey' ,24);
insert into Secondary_Traveler values (20, 'Elia' , 'McAlees' ,29);
insert into Secondary_Traveler values (21, 'Isaac' , 'Dyett' ,33);
insert into Secondary_Traveler values (22, 'Jens' , 'Lyttle' ,36);
insert into Secondary_Traveler values (23, 'Tobey' , 'Goulston' ,37);
insert into Secondary_Traveler values (24, 'Georgeanne' , 'Carratt' ,33);
insert into Secondary_Traveler values (25, 'Norbert' , 'Oboyle' ,26);
insert into Secondary_Traveler values (26, 'Herb' , 'Braiden' ,46);
insert into Secondary_Traveler values (27, 'Pepe' , 'Bravington' ,33);
insert into Secondary_Traveler values (28, 'Pru' , 'Ferro' ,41);
insert into Secondary_Traveler values (29, 'Alica' , 'Shotbolt' ,22);
insert into Secondary_Traveler values (30, 'Perle' , 'Maytom' ,50);
insert into Secondary_Traveler values (31, 'Nelle' , 'Allum' ,24);
insert into Secondary_Traveler values (32, 'Benton' , 'Leidl' ,20);
insert into Secondary_Traveler values (33, 'Nadiya' , 'Knifton' ,21);
insert into Secondary_Traveler values (34, 'Jodie' , 'Ducket' ,45);
insert into Secondary_Traveler values (35, 'Vaughan' , 'Dowderswell' ,33);
insert into Secondary_Traveler values (36, 'Janeczka' , 'Orniz' ,42);
insert into Secondary_Traveler values (37, 'Arlyne' , 'Oliff' ,48);
insert into Secondary_Traveler values (38, 'Jenni' , 'Horley' ,13);
insert into Secondary_Traveler values (39, 'Yankee' , 'Hearns' ,18);
insert into Secondary_Traveler values (40, 'Dareen' , 'Phython' ,19);
insert into Secondary_Traveler values (41, 'Ivar' , 'Barff' ,41);
insert into Secondary_Traveler values (42, 'Gabriello' , 'Serrels' ,27);
insert into Secondary_Traveler values (43, 'Fleurette' , 'Coonan' ,38);
insert into Secondary_Traveler values (44, 'Marve' , 'Lemerle' ,36);
insert into Secondary_Traveler values (45, 'Rafaelia' , 'Lawling' ,2);
insert into Secondary_Traveler values (46, 'Geoff' , 'Neagle' ,31);
insert into Secondary_Traveler values (47, 'Jobye' , 'Valentinuzzi' ,1);
insert into Secondary_Traveler values (48, 'Patin' , 'Trask' ,16);
insert into Secondary_Traveler values (49, 'Hartwell' , 'Couling' ,30);
insert into Secondary_Traveler values (50, 'Batsheva' , 'Piddick' ,42);

insert into Previous_Trip values (1, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue.' ,44,637,49,36);
insert into Previous_Trip values (2, 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.' ,13,2710,32,45);
insert into Previous_Trip values (3, 'Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' ,35,3598,40,43);
insert into Previous_Trip values (4, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.' ,18,4051,40,14);
insert into Previous_Trip values (5, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' ,28,5145,12,47);
insert into Previous_Trip values (6, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.' ,45,5206,49,20);
insert into Previous_Trip values (7, 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.' ,40,7375,14,42);
insert into Previous_Trip values (8, 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.' ,12,3154,15,45);
insert into Previous_Trip values (9, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.' ,8,2659,50,4);
insert into Previous_Trip values (10, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.' ,25,2382,21,31);
insert into Previous_Trip values (11, 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.' ,49,6489,11,26);
insert into Previous_Trip values (12, 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.' ,12,5072,29,37);
insert into Previous_Trip values (13, 'Pellentesque ultrices mattis odio.' ,39,9645,19,6);
insert into Previous_Trip values (14, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.' ,6,6947,7,8);
insert into Previous_Trip values (15, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.' ,28,8512,11,4);
insert into Previous_Trip values (16, 'Nullam sit amet turpis elementum ligula vehicula consequat.' ,4,9032,10,41);
insert into Previous_Trip values (17, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.' ,44,7358,34,1);
insert into Previous_Trip values (18, 'Suspendisse potenti.' ,18,8229,5,46);
insert into Previous_Trip values (19, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' ,19,662,22,46);
insert into Previous_Trip values (20, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.' ,18,144,35,28);
insert into Previous_Trip values (21, 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' ,32,844,18,4);
insert into Previous_Trip values (22, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue.' ,10,5077,16,25);
insert into Previous_Trip values (23, 'Nunc rhoncus dui vel sem. Sed sagittis.' ,28,8376,18,27);
insert into Previous_Trip values (24, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.' ,16,2552,45,14);
insert into Previous_Trip values (25, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' ,19,2361,23,15);
insert into Previous_Trip values (26, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' ,43,171,28,44);
insert into Previous_Trip values (27, 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.' ,31,4847,13,25);
insert into Previous_Trip values (28, 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' ,6,6825,32,9);
insert into Previous_Trip values (29, 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.' ,50,2205,20,18);
insert into Previous_Trip values (30, 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.' ,11,2445,25,11);
insert into Previous_Trip values (31, 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.' ,15,9020,35,36);
insert into Previous_Trip values (32, 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' ,20,292,6,19);
insert into Previous_Trip values (33, 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.' ,22,2503,34,36);
insert into Previous_Trip values (34, 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.' ,37,3534,17,9);
insert into Previous_Trip values (35, 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.' ,43,7288,35,33);
insert into Previous_Trip values (36, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' ,3,1764,26,37);
insert into Previous_Trip values (37, 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.' ,14,4592,11,33);
insert into Previous_Trip values (38, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.' ,28,5970,16,34);
insert into Previous_Trip values (39, 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.' ,50,8753,1,41);
insert into Previous_Trip values (40, 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.' ,19,4293,5,31);
insert into Previous_Trip values (41, 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.' ,20,4791,45,13);
insert into Previous_Trip values (42, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.' ,22,1559,8,5);
insert into Previous_Trip values (43, 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.' ,49,3333,11,21);
insert into Previous_Trip values (44, 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' ,27,9275,19,6);
insert into Previous_Trip values (45, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' ,15,2768,44,6);
insert into Previous_Trip values (46, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.' ,47,560,26,32);
insert into Previous_Trip values (47, 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.' ,6,7247,17,21);
insert into Previous_Trip values (48, 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.' ,44,1914,7,35);
insert into Previous_Trip values (49, 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.' ,33,6879,18,18);
insert into Previous_Trip values (50, 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.' ,20,6092,1,40);

insert into Insurance values (1,8820, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.' , 'Chatterbridge' ,32);
insert into Insurance values (2,1048, 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' , 'Mycat' ,21);
insert into Insurance values (3,3011, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.' , 'Thoughtbeat' ,32);
insert into Insurance values (4,7559, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.' , 'Devcast' ,49);
insert into Insurance values (5,9830, 'Nunc rhoncus dui vel sem.' , 'Browsebug' ,34);
insert into Insurance values (6,4408, 'Nam nulla.' , 'Jabbercube' ,15);
insert into Insurance values (7,2407, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.' , 'Geba' ,41);
insert into Insurance values (8,4578, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' , 'Wikizz' ,12);
insert into Insurance values (9,9347, 'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.' , 'Brainverse' ,46);
insert into Insurance values (10,3392, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.' , 'Reallinks' ,27);
insert into Insurance values (11,8602, 'Vivamus tortor. Duis mattis egestas metus.' , 'Jaxbean' ,47);
insert into Insurance values (12,3934, 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.' , 'Youtags' ,4);
insert into Insurance values (13,7511, 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' , 'Gabspot' ,10);
insert into Insurance values (14,3245, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.' , 'Youfeed' ,49);
insert into Insurance values (15,9115, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.' , 'Twitterlist' ,15);
insert into Insurance values (16,8514, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' , 'Blogpad' ,29);
insert into Insurance values (17,1779, 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' , 'Riffpedia' ,43);
insert into Insurance values (18,6602, 'Suspendisse potenti.' , 'Browseblab' ,19);
insert into Insurance values (19,9525, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' , 'Realpoint' ,29);
insert into Insurance values (20,8578, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' , 'Skinte' ,25);
insert into Insurance values (21,4431, 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.' , 'Babbleset' ,18);
insert into Insurance values (22,1575, 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.' , 'Brainsphere' ,31);
insert into Insurance values (23,8813, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' , 'Kayveo' ,15);
insert into Insurance values (24,8755, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.' , 'Kwimbee' ,20);
insert into Insurance values (25,5149, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.' , 'Flashset' ,42);
insert into Insurance values (26,9611, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.' , 'Plambee' ,17);
insert into Insurance values (27,3809, 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.' , 'Meezzy' ,25);
insert into Insurance values (28,3274, 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.' , 'Feedmix' ,2);
insert into Insurance values (29,2874, 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.' , 'Zoombox' ,34);
insert into Insurance values (30,7683, 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.' , 'Latz' ,7);
insert into Insurance values (31,4274, 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.' , 'Quinu' ,3);
insert into Insurance values (32,6513, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' , 'Avamba' ,11);
insert into Insurance values (33,4575, 'Vestibulum rutrum rutrum neque.' , 'Shufflebeat' ,40);
insert into Insurance values (34,8144, 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.' , 'Realfire' ,20);
insert into Insurance values (35,3289, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.' , 'Jabbersphere' ,3);
insert into Insurance values (36,6391, 'Quisque id justo sit amet sapien dignissim vestibulum.' , 'Jayo' ,38);
insert into Insurance values (37,4239, 'Aliquam quis turpis eget elit sodales scelerisque.' , 'Geba' ,49);
insert into Insurance values (38,5189, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' , 'Quinu' ,8);
insert into Insurance values (39,9759, 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' , 'Buzzster' ,20);
insert into Insurance values (40,4832, 'Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.' , 'Agivu' ,7);
insert into Insurance values (41,4113, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.' , 'Jatri' ,29);
insert into Insurance values (42,7222, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.' , 'Tagpad' ,14);
insert into Insurance values (43,4154, 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.' , 'Devpoint' ,20);
insert into Insurance values (44,317, 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.' , 'Quaxo' ,24);
insert into Insurance values (45,3122, 'Donec posuere metus vitae ipsum. Aliquam non mauris.' , 'Rhyzio' ,9);
insert into Insurance values (46,8734, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.' , 'Photofeed' ,14);
insert into Insurance values (47,8688, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.' , 'Jabberbean' ,44);
insert into Insurance values (48,7739, 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.' , 'Yozio' ,35);
insert into Insurance values (49,9336, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.' , 'Yacero' ,12);
insert into Insurance values (50,2250, 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.' , 'Bubblemix' ,6);

insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (1, 'jcb', '2025-04-20', 762, 40, '3536173802550733');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (2, 'china-unionpay', '2025-01-12', 181, 40, '5602258194024736165');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (3, 'jcb', '2023-06-18', 162, 38, '3567944666214901');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (4, 'diners-club-us-ca', '2024-10-18', 923, 15, '5558852878663482');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (5, 'bankcard', '2023-05-13', 566, 34, '5602242037036992');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (6, 'mastercard', '2023-07-13', 701, 24, '5400926808094701');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (7, 'jcb', '2025-05-08', 627, 21, '3569986329761537');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (8, 'bankcard', '2024-07-21', 801, 36, '5602218780202825');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (9, 'jcb', '2025-03-07', 998, 29, '3567036757193746');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (10, 'jcb', '2025-03-24', 859, 24, '3533884636103225');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (11, 'laser', '2024-01-01', 209, 21, '6304340724895438');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (12, 'mastercard', '2024-10-20', 653, 4, '5007669587442892');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (13, 'diners-club-us-ca', '2025-04-09', 394, 32, '5592876276289812');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (14, 'jcb', '2023-07-30', 833, 9, '3530317907290432');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (15, 'jcb', '2023-04-23', 599, 44, '3577236404062942');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (16, 'jcb', '2024-07-15', 959, 47, '3583901843026459');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (17, 'diners-club-carte-blanche', '2024-04-12', 935, 29, '30588169172457');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (18, 'switch', '2023-01-12', 282, 10, '4905532721688018');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (19, 'maestro', '2024-08-18', 678, 18, '50201544735660523');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (20, 'mastercard', '2024-06-18', 407, 14, '5108756554347788');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (21, 'jcb', '2024-05-20', 326, 38, '3558177997656224');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (22, 'jcb', '2023-10-21', 372, 2, '3571641201376393');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (23, 'diners-club-carte-blanche', '2025-02-13', 928, 47, '30439641242791');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (24, 'visa-electron', '2024-11-07', 734, 19, '4405361082069872');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (25, 'jcb', '2024-10-12', 246, 42, '3534620610977153');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (26, 'bankcard', '2024-04-20', 345, 37, '5602242569448201');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (27, 'mastercard', '2025-07-04', 572, 48, '5291742296820347');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (28, 'jcb', '2024-09-28', 650, 49, '3532725245842623');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (29, 'jcb', '2024-10-15', 773, 47, '3550729934245434');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (30, 'switch', '2024-04-02', 629, 5, '633354336538563568');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (31, 'diners-club-enroute', '2024-05-31', 557, 39, '201729684026553');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (32, 'diners-club-enroute', '2023-10-04', 795, 2, '201532971125215');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (33, 'bankcard', '2024-06-01', 820, 34, '5602215784311552');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (34, 'jcb', '2023-01-06', 664, 34, '3546421477000973');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (35, 'jcb', '2025-01-08', 454, 35, '3588641902312516');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (36, 'jcb', '2024-08-19', 452, 33, '3582039949868358');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (37, 'visa-electron', '2024-04-20', 875, 6, '4913866315508749');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (38, 'jcb', '2025-02-05', 508, 24, '3579612915314899');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (39, 'jcb', '2025-04-20', 633, 14, '3531361727054387');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (40, 'jcb', '2024-07-22', 601, 14, '3533536903821661');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (41, 'jcb', '2024-09-22', 489, 47, '3550923934574741');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (42, 'diners-club-enroute', '2024-05-01', 525, 21, '201730726850588');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (43, 'jcb', '2024-12-29', 264, 43, '3546361329206784');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (44, 'bankcard', '2022-12-09', 333, 4, '5602257711791662');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (45, 'jcb', '2024-10-16', 337, 11, '3548836031248636');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (46, 'jcb', '2023-06-05', 443, 38, '3528324871226289');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (47, 'laser', '2024-01-03', 443, 35, '6709422422241494');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (48, 'jcb', '2023-04-07', 729, 18, '3553578117010777');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (49, 'laser', '2024-02-25', 405, 13, '6709374367542474680');
insert into Payment (paymentID, name, expirationDate, cvv, customerID, cardNumber) values (50, 'maestro', '2023-12-02', 647, 35, '6763519433709169654');

insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (1, 38, 'scalable', '2022-12-28', '2023-10-31', 89);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (2, 24, 'fault-tolerant', '2023-03-29', '2023-02-10', 71);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (3, 8, 'Graphic Interface', '2023-01-31', '2023-10-14', 48);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (4, 22, 'installation', '2023-11-10', '2023-08-09', 73);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (5, 31, 'Centralized', '2023-04-06', '2023-02-02', 56);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (6, 49, 'Reactive', '2023-01-02', '2023-09-25', 77);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (7, 50, 'Open-source', '2022-12-25', '2023-06-30', 59);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (8, 29, 'emulation', '2023-05-05', '2023-05-25', 78);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (9, 6, 'Balanced', '2023-02-10', '2023-10-03', 65);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (10, 29, 'utilisation', '2023-01-25', '2023-10-19', 8);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (11, 31, 'incremental', '2023-05-01', '2023-02-05', 1);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (12, 33, 'real-time', '2023-09-11', '2023-08-02', 38);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (13, 40, 'zero administration', '2022-12-07', '2023-08-19', 4);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (14, 7, 'Proactive', '2023-05-04', '2023-04-10', 86);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (15, 33, 'reciprocal', '2022-12-11', '2022-12-20', 43);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (16, 27, 'groupware', '2023-11-06', '2023-04-26', 90);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (17, 48, 'Ergonomic', '2023-01-14', '2023-09-02', 47);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (18, 21, 'heuristic', '2023-04-11', '2023-10-26', 83);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (19, 37, 'hybrid', '2023-09-28', '2023-07-03', 26);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (20, 21, 'moderator', '2023-09-08', '2023-11-01', 77);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (21, 8, 'projection', '2023-03-18', '2023-07-02', 92);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (22, 24, 'modular', '2023-11-10', '2023-10-24', 41);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (23, 22, 'Multi-layered', '2023-02-10', '2023-09-10', 65);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (24, 29, 'portal', '2023-02-26', '2023-04-06', 31);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (25, 1, 'cohesive', '2023-09-11', '2023-10-22', 70);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (26, 5, 'concept', '2023-02-22', '2023-01-05', 57);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (27, 2, '5th generation', '2023-01-29', '2023-10-30', 72);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (28, 5, 'Programmable', '2023-01-12', '2023-04-12', 45);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (29, 28, 'orchestration', '2023-09-05', '2023-06-10', 56);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (30, 28, 'hierarchy', '2023-07-19', '2023-03-15', 72);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (31, 43, 'Up-sized', '2023-02-24', '2023-07-19', 82);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (32, 5, 'Optimized', '2023-05-20', '2023-03-31', 33);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (33, 38, 'Multi-channelled', '2023-08-23', '2023-09-08', 9);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (34, 46, 'middleware', '2022-12-23', '2023-04-11', 58);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (35, 42, 'neural-net', '2023-02-06', '2023-03-21', 67);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (36, 34, 'De-engineered', '2023-05-26', '2023-01-25', 94);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (37, 22, 'Reactive', '2023-01-28', '2023-02-27', 39);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (38, 48, 'Visionary', '2023-10-27', '2023-05-24', 30);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (39, 48, 'radical', '2023-09-21', '2023-07-15', 82);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (40, 49, 'knowledge user', '2023-11-21', '2023-02-24', 25);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (41, 37, 'upward-trending', '2023-11-30', '2023-08-06', 38);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (42, 32, 'Vision-oriented', '2023-03-13', '2023-11-03', 43);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (43, 20, 'Switchable', '2023-09-06', '2023-02-01', 16);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (44, 31, 'Function-based', '2023-07-24', '2022-12-16', 52);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (45, 18, 'framework', '2023-07-24', '2023-05-29', 51);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (46, 1, 'modular', '2023-01-25', '2023-10-01', 69);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (47, 1, 'analyzing', '2023-05-10', '2023-05-29', 53);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (48, 8, 'content-based', '2023-04-12', '2023-08-19', 31);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (49, 27, 'neural-net', '2023-06-29', '2023-10-01', 61);
insert into Discount (discountID, paymentID, type, endDate, startDate, percentageoff) values (50, 28, 'support', '2023-08-10', '2023-02-25', 51);

insert into Customer_Phone values (15, '357-577-8258' );
insert into Customer_Phone values (16, '575-988-5765' );
insert into Customer_Phone values (36, '722-898-9180' );
insert into Customer_Phone values (10, '848-768-4091' );
insert into Customer_Phone values (34, '707-797-4173' );
insert into Customer_Phone values (11, '585-573-8361' );
insert into Customer_Phone values (24, '251-726-8034' );
insert into Customer_Phone values (19, '515-277-1295' );
insert into Customer_Phone values (9, '553-496-5702' );
insert into Customer_Phone values (32, '997-134-0143' );
insert into Customer_Phone values (26, '403-306-5358' );
insert into Customer_Phone values (48, '741-947-2152' );
insert into Customer_Phone values (45, '540-240-3964' );
insert into Customer_Phone values (6, '687-246-9639' );
insert into Customer_Phone values (27, '292-861-0060' );
insert into Customer_Phone values (8, '918-710-7485' );
insert into Customer_Phone values (41, '822-736-7721' );
insert into Customer_Phone values (37, '848-978-5178' );
insert into Customer_Phone values (43, '533-303-3458' );
insert into Customer_Phone values (5, '391-310-4760' );
insert into Customer_Phone values (50, '253-170-5519' );
insert into Customer_Phone values (15, '435-281-3506' );
insert into Customer_Phone values (50, '639-213-4831' );
insert into Customer_Phone values (20, '524-632-8737' );
insert into Customer_Phone values (15, '297-793-2217' );
insert into Customer_Phone values (19, '690-278-6482' );
insert into Customer_Phone values (33, '521-663-1168' );
insert into Customer_Phone values (31, '554-721-5762' );
insert into Customer_Phone values (38, '291-988-9015' );
insert into Customer_Phone values (46, '178-471-3097' );
insert into Customer_Phone values (30, '391-998-9873' );
insert into Customer_Phone values (33, '860-111-5844' );
insert into Customer_Phone values (6, '750-523-9793' );
insert into Customer_Phone values (40, '280-463-9851' );
insert into Customer_Phone values (37, '153-203-9896' );
insert into Customer_Phone values (34, '312-238-1269' );
insert into Customer_Phone values (32, '155-170-8476' );
insert into Customer_Phone values (22, '639-649-9182' );
insert into Customer_Phone values (25, '407-756-2623' );
insert into Customer_Phone values (21, '896-995-5957' );
insert into Customer_Phone values (8, '361-448-8521' );
insert into Customer_Phone values (12, '774-822-1145' );
insert into Customer_Phone values (13, '948-862-9763' );
insert into Customer_Phone values (43, '412-170-3983' );
insert into Customer_Phone values (36, '105-859-1703' );
insert into Customer_Phone values (16, '580-568-9528' );
insert into Customer_Phone values (34, '586-723-2939' );
insert into Customer_Phone values (3, '932-533-0962' );
insert into Customer_Phone values (37, '234-686-1839' );
insert into Customer_Phone values (34, '428-861-8098' );

insert into Customer_Email values (6, 'wsenn0@typepad.com');
insert into Customer_Email values (10, 'mnorthwood1@mashable.com');
insert into Customer_Email values (44, 'acastaner2@istockphoto.com');
insert into Customer_Email values (18, 'agulleford3@army.mil');
insert into Customer_Email values (4, 'wcoche4@nymag.com');
insert into Customer_Email values (10, 'celderfield5@skype.com');
insert into Customer_Email values (41, 'vbottoner6@cpanel.net');
insert into Customer_Email values (43, 'nblazdell7@instagram.com');
insert into Customer_Email values (45, 'bjessopp8@si.edu');
insert into Customer_Email values (38, 'bfaucett9@gnu.org');
insert into Customer_Email values (37, 'mgerrelta@123-reg.co.uk');
insert into Customer_Email values (34, 'lmaciociab@fema.gov');
insert into Customer_Email values (5, 'wmeanwellc@dmoz.org');
insert into Customer_Email values (30, 'ufallad@domainmarket.com');
insert into Customer_Email values (7, 'ttauntone@ucoz.com');
insert into Customer_Email values (6, 'ctresvinaf@netlog.com');
insert into Customer_Email values (28, 'skmiecg@hc360.com');
insert into Customer_Email values (26, 'dwattamh@pbs.org');
insert into Customer_Email values (38, 'njanseni@rakuten.co.jp');
insert into Customer_Email values (37, 'tkundtj@amazon.co.jp');
insert into Customer_Email values (22, 'rboldisonk@foxnews.com');
insert into Customer_Email values (19, 'mgunterl@yellowbook.com');
insert into Customer_Email values (32, 'bslattenm@tinypic.com');
insert into Customer_Email values (2, 'cmeddn@fema.gov');
insert into Customer_Email values (8, 'rmatteso@google.ca');
insert into Customer_Email values (34, 'adeeginp@nasa.gov');
insert into Customer_Email values (27, 'kphilpaultq@reuters.com');
insert into Customer_Email values (41, 'scarelessr@intel.com');
insert into Customer_Email values (32, 'ahurds@dion.ne.jp');
insert into Customer_Email values (9, 'vdunnicot@reference.com');
insert into Customer_Email values (8, 'gmetzigu@samsung.com');
insert into Customer_Email values (41, 'adenyukhinv@chronoengine.com');
insert into Customer_Email values (33, 'hloudwellw@cbslocal.com');
insert into Customer_Email values (28, 'bfiggex@howstuffworks.com');
insert into Customer_Email values (48, 'rcanniffey@nps.gov');
insert into Customer_Email values (41, 'callsobrookz@ihg.com');
insert into Customer_Email values (22, 'mcowling10@ted.com');
insert into Customer_Email values (37, 'cbonefant11@infoseek.co.jp');
insert into Customer_Email values (6, 'ajesteco12@netvibes.com');
insert into Customer_Email values (30, 'khawksby13@japanpost.jp');
insert into Customer_Email values (46, 'ksach14@huffingtonpost.com');
insert into Customer_Email values (41, 'lnewlands15@biblegateway.com');
insert into Customer_Email values (47, 'bdagless16@mozilla.org');
insert into Customer_Email values (16, 'rbourthoumieux17@mail.ru');
insert into Customer_Email values (49, 'kelstone18@engadget.com');
insert into Customer_Email values (17, 'bladyman19@google.com.br');
insert into Customer_Email values (44, 'okeme1a@hatena.ne.jp');
insert into Customer_Email values (35, 'nmounfield1b@nasa.gov');
insert into Customer_Email values (27, 'hiddison1c@berkeley.edu');
insert into Customer_Email values (20, 'gwicklen1d@miitbeian.gov.cn');

insert into Secondary_Traveler_Phone values(36, '174-871-1048' );
insert into Secondary_Traveler_Phone values(37, '197-390-6504' );
insert into Secondary_Traveler_Phone values(45, '209-697-6554' );
insert into Secondary_Traveler_Phone values(22, '699-394-2326' );
insert into Secondary_Traveler_Phone values(42, '518-516-4795' );
insert into Secondary_Traveler_Phone values(10, '644-784-9166' );
insert into Secondary_Traveler_Phone values(5, '678-551-1914' );
insert into Secondary_Traveler_Phone values(19, '353-251-7283' );
insert into Secondary_Traveler_Phone values(42, '233-469-7318' );
insert into Secondary_Traveler_Phone values(17, '684-493-4522' );
insert into Secondary_Traveler_Phone values(44, '859-843-2072' );
insert into Secondary_Traveler_Phone values(28, '764-941-2951' );
insert into Secondary_Traveler_Phone values(33, '306-334-4606' );
insert into Secondary_Traveler_Phone values(14, '986-990-3383' );
insert into Secondary_Traveler_Phone values(21, '607-625-7703' );
insert into Secondary_Traveler_Phone values(5, '591-175-3100' );
insert into Secondary_Traveler_Phone values(32, '786-130-4886' );
insert into Secondary_Traveler_Phone values(9, '647-932-5676' );
insert into Secondary_Traveler_Phone values(3, '241-121-8250' );
insert into Secondary_Traveler_Phone values(34, '832-345-1421' );
insert into Secondary_Traveler_Phone values(15, '433-917-0607' );
insert into Secondary_Traveler_Phone values(21, '911-982-3699' );
insert into Secondary_Traveler_Phone values(17, '533-583-2118' );
insert into Secondary_Traveler_Phone values(25, '694-663-1305' );
insert into Secondary_Traveler_Phone values(45, '212-231-9143' );
insert into Secondary_Traveler_Phone values(4, '987-119-3019' );
insert into Secondary_Traveler_Phone values(49, '793-463-5285' );
insert into Secondary_Traveler_Phone values(37, '826-756-4019' );
insert into Secondary_Traveler_Phone values(12, '507-883-3376' );
insert into Secondary_Traveler_Phone values(42, '576-334-2194' );
insert into Secondary_Traveler_Phone values(3, '889-617-6143' );
insert into Secondary_Traveler_Phone values(14, '873-764-4625' );
insert into Secondary_Traveler_Phone values(37, '539-762-1711' );
insert into Secondary_Traveler_Phone values(17, '939-258-1454' );
insert into Secondary_Traveler_Phone values(13, '619-308-5435' );
insert into Secondary_Traveler_Phone values(12, '514-238-6210' );
insert into Secondary_Traveler_Phone values(10, '975-759-7174' );
insert into Secondary_Traveler_Phone values(11, '877-820-7809' );
insert into Secondary_Traveler_Phone values(50, '985-372-6337' );
insert into Secondary_Traveler_Phone values(46, '722-394-5452' );
insert into Secondary_Traveler_Phone values(14, '513-798-7693' );
insert into Secondary_Traveler_Phone values(44, '635-285-7296' );
insert into Secondary_Traveler_Phone values(45, '620-706-4231' );
insert into Secondary_Traveler_Phone values(19, '409-111-5785' );
insert into Secondary_Traveler_Phone values(30, '859-194-6290' );
insert into Secondary_Traveler_Phone values(14, '381-686-0708' );
insert into Secondary_Traveler_Phone values(40, '792-229-1299' );
insert into Secondary_Traveler_Phone values(23, '929-885-1312' );
insert into Secondary_Traveler_Phone values(49, '260-860-8741' );
insert into Secondary_Traveler_Phone values(39, '858-322-1695' );

insert into Secondary_Traveler_Email values (17, 'hbrewse0@hao123.com' );
insert into Secondary_Traveler_Email values (28, 'mcornfoot1@noaa.gov' );
insert into Secondary_Traveler_Email values (47, 'lhamberstone2@addthis.com' );
insert into Secondary_Traveler_Email values (17, 'pjeffcoat3@paginegialle.it' );
insert into Secondary_Traveler_Email values (11, 'pdowson4@icq.com' );
insert into Secondary_Traveler_Email values (20, 'slongworth5@nhs.uk' );
insert into Secondary_Traveler_Email values (15, 'asafe6@google.fr' );
insert into Secondary_Traveler_Email values (21, 'fpettigree7@yandex.ru' );
insert into Secondary_Traveler_Email values (19, 'aglenfield8@slideshare.net' );
insert into Secondary_Traveler_Email values (42, 'lvanbruggen9@ezinearticles.com' );
insert into Secondary_Traveler_Email values (33, 'dlicciardoa@yolasite.com' );
insert into Secondary_Traveler_Email values (26, 'ssurgeonerb@cafepress.com' );
insert into Secondary_Traveler_Email values (44, 'acrimminsc@google.cn' );
insert into Secondary_Traveler_Email values (44, 'myeomansd@stanford.edu' );
insert into Secondary_Traveler_Email values (11, 'dalvise@posterous.com' );
insert into Secondary_Traveler_Email values (3, 'afoshf@vk.com' );
insert into Secondary_Traveler_Email values (11, 'hbarensg@blog.com' );
insert into Secondary_Traveler_Email values (9, 'dnilesh@buzzfeed.com' );
insert into Secondary_Traveler_Email values (7, 'gvolantei@4shared.com' );
insert into Secondary_Traveler_Email values (7, 'cvittlej@unesco.org' );
insert into Secondary_Traveler_Email values (7, 'jspraggonk@gravatar.com' );
insert into Secondary_Traveler_Email values (7, 'sderuggerol@tripadvisor.com' );
insert into Secondary_Traveler_Email values (44, 'patmorem@comcast.net' );
insert into Secondary_Traveler_Email values (10, 'tbazellen@moonfruit.com' );
insert into Secondary_Traveler_Email values (21, 'rlepicko@noaa.gov' );
insert into Secondary_Traveler_Email values (6, 'wmocherp@networkadvertising.org' );
insert into Secondary_Traveler_Email values (21, 'dlackintonq@t.co' );
insert into Secondary_Traveler_Email values (15, 'piltchevr@techcrunch.com' );
insert into Secondary_Traveler_Email values (10, 'aglanvills@github.io' );
insert into Secondary_Traveler_Email values (12, 'kcarahert@eventbrite.com' );
insert into Secondary_Traveler_Email values (11, 'vphilipsohnu@list-manage.com' );
insert into Secondary_Traveler_Email values (21, 'fcorterv@networkadvertising.org' );
insert into Secondary_Traveler_Email values (8, 'rduranw@theglobeandmail.com' );
insert into Secondary_Traveler_Email values (49, 'smcmahonx@buzzfeed.com' );
insert into Secondary_Traveler_Email values (27, 'dphizackleay@blogger.com' );
insert into Secondary_Traveler_Email values (12, 'hgladebeckz@answers.com' );
insert into Secondary_Traveler_Email values (46, 'adenington10@hugedomains.com' );
insert into Secondary_Traveler_Email values (22, 'hflamank11@ihg.com' );
insert into Secondary_Traveler_Email values (36, 'aspreull12@squidoo.com' );
insert into Secondary_Traveler_Email values (27, 'ddidball13@github.io' );
insert into Secondary_Traveler_Email values (11, 'rdeakan14@cnbc.com' );
insert into Secondary_Traveler_Email values (25, 'knewbigging15@imdb.com' );
insert into Secondary_Traveler_Email values (43, 'fjeandot16@prweb.com' );
insert into Secondary_Traveler_Email values (20, 'ssnellman17@zdnet.com' );
insert into Secondary_Traveler_Email values (38, 'kklosterman18@quantcast.com' );
insert into Secondary_Traveler_Email values (13, 'bconvery19@tripadvisor.com' );
insert into Secondary_Traveler_Email values (1, 'ckrebs1a@tuttocitta.it' );
insert into Secondary_Traveler_Email values (49, 'drambaut1b@technorati.com' );
insert into Secondary_Traveler_Email values (34, 'gmoodey1c@facebook.com' );
insert into Secondary_Traveler_Email values (21, 'coakeby1d@opensource.org' );

insert into Service_Level values(14, 'eu' );
insert into Service_Level values(8, 'vel augue' );
insert into Service_Level values(14, 'tortor' );
insert into Service_Level values(18, 'dictumst morbi' );
insert into Service_Level values(5, 'orci luctus' );
insert into Service_Level values(22, 'velit id' );
insert into Service_Level values(36, 'nec euismod' );
insert into Service_Level values(1, 'maecenas' );
insert into Service_Level values(3, 'vel nulla' );
insert into Service_Level values(37, 'nisi vulputate' );
insert into Service_Level values(16, 'lobortis ligula' );
insert into Service_Level values(10, 'hac habitasse' );
insert into Service_Level values(2, 'ullamcorper' );
insert into Service_Level values(14, 'semper' );
insert into Service_Level values(15, 'volutpat sapien' );
insert into Service_Level values(25, 'cras pellentesque' );
insert into Service_Level values(17, 'ipsum' );
insert into Service_Level values(6, 'velit vivamus' );
insert into Service_Level values(8, 'donec' );
insert into Service_Level values(12, 'tempor' );
insert into Service_Level values(13, 'nunc nisl' );
insert into Service_Level values(29, 'elit ac' );
insert into Service_Level values(36, 'molestie' );
insert into Service_Level values(49, 'magnis' );
insert into Service_Level values(47, 'lobortis est' );
insert into Service_Level values(29, 'pretium iaculis' );
insert into Service_Level values(10, 'eu' );
insert into Service_Level values(36, 'natoque' );
insert into Service_Level values(40, 'potenti nullam' );
insert into Service_Level values(42, 'nisl duis' );
insert into Service_Level values(6, 'tellus semper' );
insert into Service_Level values(39, 'id pretium' );
insert into Service_Level values(40, 'mus etiam' );
insert into Service_Level values(38, 'id' );
insert into Service_Level values(11, 'rutrum neque' );
insert into Service_Level values(3, 'est' );
insert into Service_Level values(37, 'odio in' );
insert into Service_Level values(7, 'dictumst morbi' );
insert into Service_Level values(21, 'metus' );
insert into Service_Level values(8, 'in' );
insert into Service_Level values(30, 'egestas' );
insert into Service_Level values(30, 'eleifend luctus' );
insert into Service_Level values(16, 'tincidunt' );
insert into Service_Level values(34, 'suspendisse' );
insert into Service_Level values(21, 'eget tincidunt' );
insert into Service_Level values(30, 'duis' );
insert into Service_Level values(47, 'diam vitae' );
insert into Service_Level values(30, 'ut' );
insert into Service_Level values(50, 'quis turpis' );
insert into Service_Level values(4, 'etiam' );