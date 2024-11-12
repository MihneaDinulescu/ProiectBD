CREATE TABLE `Locatie` (
  `ID_Locatie` int PRIMARY KEY AUTO_INCREMENT,
  `Tara` varchar(20) NOT NULL,
  `Oras` varchar(20) NOT NULL,
  `Strada` varchar(20) NOT NULL,
  `Nr_Strada` int NULL
);

CREATE TABLE `Patron` (
  `ID_Patron` int PRIMARY KEY AUTO_INCREMENT,
  `Nume_Patron` varchar(20) NOT NULL, 
  `Prenume_Patron` varchar(20) NOT NULL,
  `Nr_Telefon` varchar(20) NULL,
  `Email_Patron` varchar(40) NOT NULL
);

CREATE TABLE `Hotel` (
  `ID_Hotel` int PRIMARY KEY AUTO_INCREMENT,
  `ID_Patron` int NOT NULL,
  `ID_Locatie` int NOT NULL,
  `Nume_Hotel` varchar(20) NOT NULL,
  `An_Infiintare` date NOT NULL,
  `Nr_Stele` int NULL
);

CREATE TABLE `Camera` (
  `ID_Camera` int PRIMARY KEY AUTO_INCREMENT,
  `ID_Hotel` int NOT NULL,
  `Tip_Camera` varchar(15) NOT NULL,
  `Pret` decimal(6,2) NULL,
  `Numar_Camera` int NOT NULL
);

CREATE TABLE `Client` (
  `ID_Client` int PRIMARY KEY AUTO_INCREMENT,
  `Nume_Client` varchar(20) NOT NULL,
  `Prenume_Client` varchar(20) NOT NULL,
  `Email_Client` varchar(40) NULL,
  `Nr_Telefon_Client` varchar(20) NOT NULL
);

CREATE TABLE `Rezervare` (
  `ID_Rezervare` int PRIMARY KEY AUTO_INCREMENT,
  `ID_Client` int NOT NULL,
  `Avans` decimal(5,2) NULL,
  `Metoda_Plata` varchar(20) NOT NULL,
  `Puncte_Loialitate` int NULL
);

CREATE TABLE `Recenzie` (
  `ID_Recenzie` int PRIMARY KEY AUTO_INCREMENT,
  `ID_Rezervare` int NOT NULL,
  `Nr_Stele_General` int NOT NULL,
  `Nr_Stele_Servicii` int NULL,
  `Data_Recenzie` date NOT NULL
);

CREATE TABLE `Camera_Rezervare` (
  `ID_Camera_Rezervare` int PRIMARY KEY AUTO_INCREMENT,
  `ID_Rezervare` int NULL,
  `ID_Camera` int NOT NULL,
  `Data_Check_In` date NOT NULL,
  `Data_Check_Out` date NULL
);



ALTER TABLE `Hotel` ADD FOREIGN KEY  FK_ID_PATRON_HOTEL (`ID_Patron`) 
REFERENCES `Patron` (`ID_Patron`) ON DELETE CASCADE;
ALTER TABLE `Hotel` ADD FOREIGN KEY  FK_ID_LOCATIE_HOTEL (`ID_Locatie`)
 REFERENCES `Locatie` (`ID_Locatie`) ON DELETE CASCADE;
ALTER TABLE `Camera` ADD FOREIGN KEY FK_ID_HOTEL_CAMERA (`ID_Hotel`)
 REFERENCES `Hotel` (`ID_Hotel`) ON DELETE CASCADE;
ALTER TABLE `Camera_Rezervare` ADD FOREIGN KEY  FK_ID_CAMERA_CAMERA_REZERVARE (`ID_Camera`)
 REFERENCES `Camera` (`ID_Camera`) ON DELETE CASCADE;
ALTER TABLE `Camera_Rezervare` ADD FOREIGN KEY FK_ID_REZERVARE_CAMERA_REZERVARE(`ID_Rezervare`)
 REFERENCES `Rezervare` (`ID_Rezervare`) ON DELETE CASCADE;
ALTER TABLE `Rezervare` ADD FOREIGN KEY FK_ID_CLIENT_REZERVARE (`ID_Client`)
REFERENCES `Client` (`ID_Client`) ON DELETE CASCADE;
ALTER TABLE `Recenzie` ADD FOREIGN KEY FK_ID_REZERVARE_RECENZIE(`ID_Rezervare`)
 REFERENCES `Rezervare` (`ID_Rezervare`) ON DELETE CASCADE;


ALTER TABLE `Patron` ADD CONSTRAINT UQ_EMAIL_PATRON UNIQUE (Email_Patron);
ALTER TABLE `Patron` ADD CONSTRAINT UQ_PATRON_NUME_PRENUME UNIQUE (Nume_Patron, Prenume_Patron);
ALTER TABLE `Patron` ADD CONSTRAINT UQ_PATRON_NR_TELEFON UNIQUE (Nr_Telefon);
ALTER TABLE `Locatie`ADD CONSTRAINT UQ_LOCATIE_UNICA UNIQUE (Tara, Oras, Strada, Nr_Strada);
ALTER TABLE `Client` ADD CONSTRAINT UQ_CLIENT_NUME_PRENUME UNIQUE (Nume_Client, Prenume_Client);
ALTER TABLE `Client` ADD CONSTRAINT UQ_EMAIL_CLIENT UNIQUE (Email_Client);
ALTER TABLE `Client` ADD CONSTRAINT UQ_NR_TELEFON_CLIENT UNIQUE (Nr_Telefon_Client);
ALTER TABLE `Camera` ADD CONSTRAINT UQ_NUMAR_CAMERA UNIQUE (ID_Hotel , Tip_Camera ,Numar_Camera);


ALTER TABLE `Hotel` ADD CONSTRAINT CHK_NR_STELE_HOTEL CHECK (Nr_Stele >= 1 AND Nr_Stele <= 5);
ALTER TABLE `Camera` ADD CONSTRAINT CHK_TIP_CAMERA CHECK (Tip_Camera IN ('Single','Dubla','Tripla','Cvadrupla','Suite','Standard','Deluxe'));
ALTER TABLE `Camera` ADD CONSTRAINT CHK_PRET_CAMERA CHECK (Pret > 0);
ALTER TABLE `Rezervare` ADD CONSTRAINT CHK_METODA_PLATA CHECK (Metoda_Plata IN ('Numerar','Card','Transfer bancar','Voucher'));
ALTER TABLE `Rezervare` ADD CONSTRAINT CHK_METODA_AVANS CHECK ((Metoda_Plata <> 'Voucher') OR (Metoda_Plata = 'Voucher' AND Avans IS NULL));
ALTER TABLE `Rezervare` ADD CONSTRAINT CHK_PUNCTE_LOIALITATE CHECK (Puncte_Loialitate < 250 AND Puncte_Loialitate > 0);
ALTER TABLE `Rezervare` ADD CONSTRAINT CHK_AVANS_POZITIV CHECK (Avans > 0);
ALTER TABLE `Camera_Rezervare` ADD CONSTRAINT CHK_DATA_CHECK_IN_CHECK_OUT CHECK (Data_Check_In <= Data_Check_Out);
ALTER TABLE `Recenzie` ADD CONSTRAINT CHK_NR_STELE_GENERAL_RECENZIE CHECK (Nr_Stele_General >= 1 AND Nr_Stele_General <= 5);
ALTER TABLE `Recenzie` ADD CONSTRAINT CHK_NR_STELE_SERVICII_RECENZIE CHECK (Nr_Stele_Servicii >= 1 AND Nr_Stele_Servicii <= 5);

INSERT INTO `Locatie` (`Tara`, `Oras`, `Strada`, `Nr_Strada`)
VALUES 
('Romania', 'Bucuresti', 'Victoriei', 123),
('FranÈ›a', 'Paris', 'Champs-Elysees', NULL),
('Germania', 'Berlin', 'Unter', 67),
('Italia', 'Roma', 'Corso', 89),
('Spania', 'Madrid', 'Gran', 101),
('Anglia', 'Londra', 'Baker', NULL),
('Olanda', 'Amsterdam', 'Prinsengracht', 345),
('ElveÈ›ia', 'Geneva', 'Mont-Blanc', 678),
('SUA', 'New York', 'Fifth', NULL),
('Japonia', 'Tokyo', 'Ginza', 5678),
('Brazilia', 'Rio', 'Copacabana', NULL),
('Canada', 'Toronto', 'Yonge', 908),
('Australia', 'Sydney', 'Harbour', 777),
('Rusia', 'Moscow', 'Tverskaya', NULL),
('Suedia', 'Stockholm', 'Drottninggatan', 654),
('Norvegia', 'Oslo', 'Karl Johans', NULL),
('India', 'Delhi', 'Connaught', 234),
('Grecia', 'Atena', 'Ermou', NULL),
('Egipt', 'Cairo', 'Nile', 1234),
('Argentina', 'Buenos Aires', 'Recoleta', NULL),
('Chile', 'Santiago', 'Alameda', 456),
('Africa de Sud', 'Johannesburg', 'Nelson', NULL),
('Coreea de Sud', 'Seoul', 'Myeongdong', 789),
('Turcia', 'Istanbul', 'Istiklal', NULL),
('Ucraina', 'Kiev', 'Khreshchatyk', 432),
('Portugalia', 'Lisabona', 'Liberdade', NULL),
('Polonia', 'VarÈ™ovia', 'Nowy', 567),
('Belgia', 'Bruxelles', 'Grand', NULL),
('Austria', 'Viena', 'Ringstrasse', 890);

INSERT INTO `Patron` (`Nume_Patron`, `Prenume_Patron`, `Nr_Telefon`, `Email_Patron`)
VALUES 
('Smith', 'John', '+1 123 456 7890', 'john.smith@email.com'),
('Johnson', 'Emily', NULL, 'emily.johnson@email.com'),
('Garcia', 'Carlos', '+34 987 654 321', 'carlos.garcia@email.com'),
('Muller', 'Anna', '+49 123 456 789', 'anna.muller@email.com'),
('Rossi', 'Giuseppe', NULL, 'giuseppe.rossi@email.com'),
('Nguyen', 'Linh', '+84 912 345 678', 'linh.nguyen@email.com'),
('Gupta', 'Ravi', '+91 789 012 3456', 'ravi.gupta@email.com'),
('Martinez', 'Sofia', '+52 678 901 2345', 'sofia.martinez@email.com'),
('Lopez', 'Miguel', '+34 345 678 901', 'miguel.lopez@email.com'),
('Wang', 'Yan', NULL, 'yan.wang@email.com'),
('Ali', 'Ahmed', '+92 345 678 9012', 'ahmed.ali@email.com'),
('Smith', 'Emma', '+1 567 890 1234', 'emma.smith@email.com'),
('Ferrari', 'Luca', '+39 567 890 123', 'luca.ferrari@email.com'),
('Chung', 'Soo', '+82 901 234 5678', 'soomin.chung@email.com'),
('Dubois', 'Pierre', '+33 789 012 345', 'pierre.dubois@email.com');

INSERT INTO `Hotel` (`ID_Patron`, `ID_Locatie`, `Nume_Hotel`, `An_Infiintare`, `Nr_Stele`)
VALUES 
(1, 1, 'Central Comfort Inn', '2000-01-01', 4),
(1, 1, 'Elysian Luxe', '1995-05-05', 5),
(1, 2, 'Horizon Resort', '1998-02-15', 3),
(1, 3, 'Heritage Heights', '2005-07-20', NULL),
(1, 3, 'Grand Vista', '1999-11-11', 5),
(2, 4, 'Metropolitan Suite', '2003-06-01', 4),
(2, 4, 'Waterside Escape', '2007-09-12', 3),
(2, 4, 'Mountain Retreat', '2010-03-10', 5),
(2, 5, 'Skyline Oasis', '2002-04-15', 5),
(3, 6, 'Zenith Palace', '2009-10-20', 4),
(4, 7, 'Paradise Point', '2008-08-08', NULL),
(4, 8, 'Harbor Lights', '2004-12-05', 4),
(4, 8, 'Bayside Bliss', '2007-01-01', 5),
(4, 9, 'Kremlin Heritage', '2006-05-05', NULL),
(5, 10, 'Royal Essence', '2006-07-07', 5),
(5, 11, 'Northern Charm', '2003-03-03', 3),
(5, 11, 'Eastern Elegance', '2012-09-09', 4),
(5, 11, 'Classic Comfort', '2000-08-08', 2),
(6, 11, 'Desert Dream', '2009-10-10', 5),
(6, 12, 'Plaza Prestige', '2007-11-11', 2),
(7, 13, 'Heights Haven', '2005-12-12', 3),
(8, 14, 'Safari Serenity', '2010-04-04', 5),
(8, 14, 'Harmony Hideaway', '2009-05-05', 4),
(8, 15, 'Legacy Lodge', '2006-06-06', 3),
(8, 16, 'Majestic Manor', '2007-07-07', NULL),
(8, 16, 'Essence Escape', '2005-01-01', 4),
(9, 16, 'Tradition Tower', '2009-02-02', 3),
(9, 16, 'Heartland Hotel', '2004-03-03', 5),
(10, 16, 'Charming Crown', '2010-04-04', NULL),
(10, 16, 'Golden Gate', '2009-05-05', 3),
(11, 17, 'Canalview Inn', '2006-06-06', 4),
(11, 18, 'Lakefront Luxury', '2008-07-07', 5),
(11, 19, 'Central Comfort', '2010-08-08', 4),
(11, 20, 'Cityscape Suites', '2010-09-09', 3),
(12, 21, 'Mountain Mirage', '2010-10-10', 5);

INSERT INTO `Client` (`Nume_Client`, `Prenume_Client`, `Email_Client`, `Nr_Telefon_Client`) 
VALUES 
('Brown', 'Michael', 'michael.brown@email.com', '+1 111 222 3333'),
('Davis', 'Laura', 'laura.davis@email.com', '+1 444 555 6666'),
('Williams', 'James', 'james.williams@email.com', '+1 777 888 9999'),
('Wilson', 'Jessica', 'jessica.wilson@email.com', '+1 101 202 3030'),
('Jones', 'Ryan', 'ryan.jones@email.com', '+1 404 505 6060'),
('Taylor', 'Megan', 'megan.taylor@email.com', '+1 707 808 9090'),
('Johnson', 'Kevin', 'kevin.johnson@email.com', '+1 111 222 3334'),
('Harris', 'Sophie', 'sophie.harris@email.com', '+1 444 555 6634'),
('Clark', 'Robert', 'robert.clark@email.com', '+1 777 888 9990'),
('Lewis', 'Catherine', 'catherine.lewis@email.com', '+1 101 202 3031'),
('Anderson', 'Matthew', 'matthew.anderson@email.com', '+1 404 505 6061'),
('Lee', 'Hannah', 'hannah.lee@email.com', '+1 707 808 9091'),
('Walker', 'Timothy', 'timothy.walker@email.com', '+1 707 834 9023'),
('Green', 'Olivia', 'olivia.green@email.com', '+1 444 555 6668'),
('Evans', 'Daniel', 'daniel.evans@email.com', '+1 777 888 9991'),
('King', 'Natalie', 'natalie.king@email.com', '+1 101 202 3032'),
('Scott', 'Brandon', 'brandon.scott@email.com', '+1 404 505 6062'),
('Adams', 'Samantha', 'samantha.adams@email.com', '+1 707 808 9092'),
('Baker', 'Patrick', 'patrick.baker@email.com', '+1 404 142 5002'),
('Murphy', 'Rachel', 'rachel.murphy@email.com', '+1 444 555 6669'),
('Hall', 'Andrew', 'andrew.hall@email.com', '+1 777 888 9992'),
('Graham', 'Elizabeth', 'elizabeth.graham@email.com', '+1 101 202 3033'),
('Parker', 'Johnathan', 'johnathan.parker@email.com', '+1 404 505 6063'),
('Cooper', 'Amanda', 'amanda.cooper@email.com', '+1 707 808 9093'),
('Phillips', 'Derek', 'derek.phillips@email.com', '+1 101 200 5234'),
('Jackson', 'Nicole', 'nicole.jackson@email.com', '+1 444 555 6670'),
('Bennett', 'Alex', 'alex.bennett@email.com', '+1 777 888 9993'),
('Carter', 'Grace', 'grace.carter@email.com', '+1 101 202 3034'),
('Roberts', 'Dylan', 'dylan.roberts@email.com', '+1 404 505 6064');


INSERT INTO `Camera` (`ID_Hotel`, `Tip_Camera`, `Pret`, `Numar_Camera`) 
VALUES 
(1, 'Single', 100.00, 1),
(1, 'Dubla', 150.00, 2),
(1, 'Cvadrupla', 200.00, 3),
(1, 'Standard', 120.00, 4),
(2, 'Single', 110.00, 1),
(2, 'Dubla', 160.00, 2),
(2, 'Deluxe', 220.00, 3),
(3, 'Single', 105.00, 1),
(3, 'Dubla', 155.00, 2),
(3, 'Standard', 125.00, 3),
(3, 'Cvadrupla', 205.00, 4),
(4, 'Single', 114.99, 1),
(4, 'Dubla', 164.99, 2),
(4, 'Tripla', 209.99, 3),
(4, 'Standard', 129.99, 4),
(5, 'Single', 118.00, 1),
(5, 'Dubla', 168.00, 2),
(5, 'Deluxe', 225.00, 3),
(6, 'Single', 112.00, 1),
(6, 'Dubla', 162.00, 2),
(6, 'Standard', NULL, 3),
(7, 'Single', 120.00, 1),
(7, 'Dubla', 170.00, 2),
(7, 'Suite', 215.00, 3),
(8, 'Single', 125.00, 1),
(8, 'Dubla', 175.00, 2),
(8, 'Deluxe', 230.00, 3),
(9, 'Single', 110.00, 1),
(9, 'Dubla', 160.00, 2),
(9, 'Standard', 125.00, 3),
(9, 'Suite', 200.00, 4),
(10, 'Single', 130.00, 1),
(10, 'Dubla', 180.00, 2),
(10, 'Tripla', 220.00, 3),
(11, 'Single', 135.00, 1),
(11, 'Dubla', 185.00, 2),
(11, 'Standard', 140.00, 3),
(12, 'Single', 140.00, 1),
(12, 'Dubla', 190.00, 2),
(12, 'Cvadrupla', 230.00, 3),
(13, 'Single', 145.00, 1),
(13, 'Dubla', 195.00, 2),
(13, 'Deluxe', 240.00, 3),
(14, 'Single', 150.00, 1),
(14, 'Dubla', 200.00, 2),
(14, 'Standard', 145.00, 3),
(15, 'Single', 155.00, 1),
(15, 'Dubla', 205.00, 2),
(15, 'Suite', 250.00, 3),
(16, 'Single', 160.00, 1),
(16, 'Dubla', 210.00, 2),
(16, 'Deluxe', 260.00, 3),
(17, 'Single', NULL, 1),
(17, 'Dubla', 215.00, 2),
(17, 'Standard', 150.00, 3),
(18, 'Single', 170.00, 1),
(18, 'Dubla', 220.00, 2),
(18, 'Cvadrupla', 270.00, 3),
(19, 'Single', 175.00, 1),
(19, 'Dubla', 225.00, 2),
(19, 'Deluxe', 280.00, 3),
(20, 'Single', 180.00, 1),
(20, 'Dubla', 230.00, 2),
(20, 'Standard', 155.00, 3),
(21, 'Single', 185.00, 1),
(21, 'Dubla', 235.00, 2),
(21, 'Tripla', 290.00, 3),
(22, 'Single', 190.00, 1),
(22, 'Dubla', 240.00, 2),
(22, 'Deluxe', 300.00, 3),
(23, 'Single', 195.00, 1),
(23, 'Dubla', 245.00, 2),
(23, 'Standard', 160.00, 3),
(24, 'Single', 200.00, 1),
(24, 'Dubla', 250.00, 2),
(24, 'Cvadrupla', 310.00, 3),
(25, 'Single', 205.00, 1),
(25, 'Dubla', 255.00, 2),
(25, 'Deluxe', NULL, 3);


INSERT INTO `Rezervare` (`ID_Client`, `Avans`, `Metoda_Plata`, `Puncte_Loialitate`) 
VALUES 
(1, 50.00, 'Card', 10),
(1, NULL, 'Numerar', 35),
(2, 70.00, 'Transfer bancar', 20),
(3, NULL, 'Card', 30),
(3, 64.99, 'Transfer bancar', 25),
(4, 40.00, 'Card', 5),
(5, NULL, 'Voucher', NULL),
(6, 80.00, 'Transfer bancar', 15),
(7, 60.00, 'Card', 25),
(7, NULL, 'Voucher', NULL),
(7, NULL, 'Card', 33),
(8, 90.00, 'Card', 35),
(9, 45.00, 'Numerar', 8),
(10, 55.00, 'Card', 12),
(11, NULL, 'Transfer bancar', NULL),
(12, 75.00, 'Card', 18),
(13, 85.00, 'Card', NULL),
(14, 65.00, 'Transfer bancar', 22),
(15, 95.00, 'Card', 32),
(16, 100.00, 'Card', 40),
(17, 50.00, 'Numerar', 11),
(18, 60.00, 'Card', 14),
(19, NULL, 'Voucher', 16),
(20, 80.00, 'Transfer bancar', 20),
(21, 55.00, 'Card', 13),
(22, NULL, 'Voucher', NULL),
(23, 65.00, 'Card', 17),
(24, 75.00, 'Card', 19),
(25, 85.00, 'Transfer bancar', 23),
(26, 95.00, 'Card', 29);


INSERT INTO `Recenzie` (`ID_Rezervare`, `Nr_Stele_General`, `Nr_Stele_Servicii`, `Data_Recenzie`) VALUES
(1, 4, NULL, '2011-04-20'),
(2, 3, 3, '2012-06-25'),
(3, 5, 5, '2013-08-10'),
(3, 4, 4, '2014-09-12'),
(4, 2, 3, '2015-11-05'),
(5, 5, 5, '2016-01-08'),
(6, 4, 4, '2017-03-15'),
(7, 3, 2, '2018-05-20'),
(7, 3, NULL, '2019-07-22'),
(8, 5, 5, '2020-09-10'),
(9, 4, 4, '2021-11-15'),
(10, 2, 3, '2012-04-18'),
(11, 5, NULL, '2014-07-28'),
(12, 4, 4, '2015-09-30'),
(13, 3, 3, '2016-11-05'),
(14, 5, 5, '2017-01-10'),
(15, 4, NULL, '2018-03-15'),
(16, 2, 3, '2019-05-20'),
(17, 5, NULL, '2020-07-22'),
(18, 4, 4, '2021-09-10'),
(19, 1, 2, '2012-11-15'),
(20, 5, 5, '2013-02-18'),
(21, 3, 4, '2023-03-15'),
(22, 5, 4, '2022-12-22');


INSERT INTO `Camera_Rezervare` (ID_Rezervare, ID_Camera, Data_Check_In, Data_Check_Out) VALUES
(1, 1, '2015-02-10', '2015-02-15'),
(1, 2, '2015-02-10', '2015-02-15'),
(2, 3, '2015-02-10', '2015-02-15'),
(3, 2, '2015-03-15', '2015-03-20'),
(3, 3, '2015-03-15', '2015-03-20'),
(3, 4, '2015-03-15', '2015-03-20'),
(4, 8, '2015-03-22', '2015-03-25'),
(4, 9, '2015-03-22', '2015-03-25'),
(5, 8, '2015-04-05', '2015-04-10'),
(5, 9, '2015-04-05', '2015-04-10'),
(5, 10, '2015-04-05', '2015-04-10'),
(6, 10, '2015-04-20', '2015-04-25'),
(7, 12, '2015-05-05', '2015-05-10'),
(8, 2, '2015-05-20', '2015-05-25'),
(9, 3, '2015-06-05', '2015-06-10'),
(10, 18, '2015-06-20', '2015-06-25'),
(11, 20, '2015-07-05', '2015-07-10'),
(12, 22, '2015-07-20', '2015-07-25'),
(13, 24, '2015-08-05', '2015-08-10'),
(14, 26, '2015-08-20', '2015-08-25'),
(15, 28, '2015-09-05', '2015-09-10'),
(16, 30, '2015-09-20', '2015-09-25'),
(17, 32, '2015-10-05', '2015-10-10'),
(18, 34, '2015-10-20', '2015-10-25'),
(19, 36, '2015-11-05', '2015-11-10'),
(20, 38, '2015-11-20', '2015-11-25'),
(21, 40, '2015-12-05', '2015-12-10'),
(22, 42, '2015-12-20', '2015-12-25'),
(23, 44, '2016-01-05', '2016-01-10'),
(24, 46, '2016-01-20', '2016-01-25'),
(25, 48, '2016-02-05', '2016-02-10'),
(26, 50, '2016-02-20', '2016-02-25'),
(27, 52, '2016-03-05', '2016-03-10'),
(28, 54, '2016-03-20', '2016-03-25'),
(29, 56, '2016-04-05', '2016-04-10'),
(30, 58, '2016-04-20', NULL);


/***************************************************************
-- drop in cazul in care avem nevoie sa stergem tabele
drop table camera_rezervare;
drop table recenzie;
drop table rezervare;
drop table camera;
drop table hotel;
drop table patron;
drop table locatie;
drop table client;
***************************************************************/
