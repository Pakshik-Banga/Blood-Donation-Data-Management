--      CREATING  Blood Bank Manager Table ----------- 

CREATE TABLE BB_Manager (
    m_ID INTEGER PRIMARY KEY,
    m_Name VARCHAR(100) NOT NULL,
    m_PhNo VARCHAR(15) NOT NULL
);



--        Inserting Data in BB_Manager table  ----------- 

INSERT into BB_Manager
VALUES(102,'Jack', '4693959671'),
(103,'Peter', '4693959601'),
(104,'Mark', '4693959677'),
(105,'Jason', '4693957671'),
(106,'Steve', '4694959671'),
(107,'Jason', '4695959671'),
(108,'Stella', '4663959671'),
(109,'Monika', '4673959671'),
(110,'John', '4693859671')


select * from BB_Manager


--       Creating  Blood Donor Table   000000000000000000----------- 
drop table blood_donor
	
CREATE TABLE Blood_Donor (
    bd_ID INTEGER PRIMARY KEY,
    bd_name VARCHAR(100) NOT NULL,
    bd_age INT NOT NULL,
	bd_sex CHAR(1) NOT NULL,
    bd_Bgroup VARCHAR(3) NOT NULL,
    bd_reg_date DATE NOT NULL,
    reco_ID INTEGER,
	city_ID INTEGER, 
    FOREIGN KEY (reco_ID) REFERENCES Recording_Staff(reco_ID),
    FOREIGN KEY (city_ID) REFERENCES City(city_ID)
);




--    Inserting  Data into Blood Donor Table   ------------ 

INSERT into Blood_Donor
VALUES(150221,'Mark',25,'M','B+','2015-12-17',101212,1300),
(160011,'Abdul',35,'F','A+','2016-11-22',101212,1200),
(160101,'Smith',22,'M','O+','2016-01-04',101312,1200),
(150011,'Pat',29,'M','O+','2015-07-19',101412,1300),
(150021,'Shyam',42,'F','A-','2015-12-24',101412,1300),
(150121,'Dan',44,'M','AB+','2015-08-28',101212,1200),
(160031,'Mike',33,'F','AB-','2016-02-06',101212,1400),
(160301,'Elisa',31,'F','AB+','2016-09-10',101312,1200),
(160091,'Carrol',24,'M','B-','2016-10-15',101312,1500),
(160401,'Mark',29,'M','O-','2016-12-17',101212,1200);



select * from blood_donor



--   Creating   Recording Staff table --------

CREATE TABLE Recording_Staff (
    reco_ID INTEGER PRIMARY KEY,
    reco_Name VARCHAR(100) NOT NULL,
    reco_PhNo VARCHAR(15) NOT NULL
);


--   Inserting  Data to  Recording Staff Table  -------


INSERT into Recording_Staff
VALUES(101212,'Walcot','4045806553'),
(101312,'Henry','4045806553'),
(101412,'Silva','4045806553'),
(101512,'Adrian','4045806553'),
(101612,'Mark','4045806553'),
(101712,'Abdul','4045816553'),
(101812,'Jerry','4045826553'),
(101912,'Tim','4045836553'),
(101012,'Lekha','4044846553'),
(101112,'Mark','4045856553');


select * from recording_staff


--     Creating  Table  DiseaseFinder ----------------


CREATE TABLE DiseaseFinder (
    dfind_ID INTEGER PRIMARY KEY,
    dfind_name VARCHAR(100) NOT NULL,
    dfind_PhNo VARCHAR(15) NOT NULL
);


INSERT into DiseaseFinder
VALUES(11,'Peter','4693804223'),
(12,'Park','4693804223'),
(13,'Jerry','4693804223'),
(14,'Mark','4693804223'),
(15,'Monika','4693804223'),
(16,'Ram','4693804123'),
(17,'Swathi','4693804223'),
(18,'Gautham','4693804323'),
(19,'Ashwin','4693804423'),
(20,'Yash','4693804523');


select * from diseaseFinder


--   Creating table city ---------

CREATE TABLE City (
    city_ID INTEGER PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL
);

--   Inserting   Data in City Table   --------------- 


INSERT into City
VALUES
(1200,'Austin'),
(1300,'Irving'),
(1400,'Houston'),
(1500,'Richardson'),
(1600,'Plano'),
(1700,'Frisco'),
(1800,'Arlington'),
(1900,'San Antonio'),
(2000,'Tyler');

SELECT * FROM city


--   Creating  Hospital_Info table  --------------

CREATE TABLE Hospital_Info (
    hosp_ID INTEGER,
    hosp_name VARCHAR(100) NOT NULL,
    city_ID INT,
    m_ID INT,
    PRIMARY KEY (hosp_ID, hosp_name),
    FOREIGN KEY (city_ID) REFERENCES City(city_ID),
    FOREIGN KEY (m_ID) REFERENCES BB_Manager(m_ID)
);


--  Inserting  Data into  Hospital_info    -----------

INSERT into Hospital_Info
VALUES
(1,'MayoClinic',1300,104),
(2,'CleavelandClinic',1200,103),
(3,'NYU',1300,103),
(4,'Baylor',1400,104),
(5,'Charlton',1800,103),
(6,'Greenoaks',1300,106),
(7,'Forestpark',1300,102),
(8,'Parkland',1200,106),
(9,'Pinecreek',1500,109),
(10,'WalnutHill',1700,105);




--  Creating  Table  Hospital_Info_2  ----------- 

CREATE TABLE Hospital_Info_2 (
    hosp_ID INTEGER,
    hosp_name VARCHAR(100) NOT NULL,
    hosp_needed_Bgrp VARCHAR(3) NOT NULL,
    hosp_needed_Bqnty INT NOT NULL,
    PRIMARY KEY (hosp_ID, hosp_needed_Bgrp)
);

  
--   Inserting  Data into Hospital_Info_2   -------------- 


INSERT into Hospital_Info_2
VALUES(1,'MayoClinic','A+',20),
(1,'MayoClinic','AB+',0),
(1,'MayoClinic','A-',40),
(1,'MayoClinic','B-',10),
(1,'MayoClinic','AB-',20),
(2,'CleavelandClinic','A+',40),
(2,'CleavelandClinic','AB+',20),
(2,'CleavelandClinic','A-',10),
(2,'CleavelandClinic','B-',30),
(2,'CleavelandClinic','B+',0),
(2,'CleavelandClinic','AB-',10),
(3,'NYU','A+',0),
(3,'NYU','AB+',0),
(3,'NYU','A-',0),
(3,'NYU','B-',20),
(3,'NYU','B+',10),
(3,'NYU','AB-',0),
(4,'Baylor','A+',10),
(5,'Charlton','B+',30),
(4,'Baylor','A-',40),
(7,'Forestpark','B-',40),
(8,'Parkland','B+',10),
(9,'Pinecreek','AB-',20);


---   Creating  Table  BloodSpecimen   --------  

CREATE TABLE BloodSpecimen (
    specimen_number SERIAL,
    b_group VARCHAR(3) NOT NULL,
    status VARCHAR(50) NOT NULL,
    dfind_ID INT,
	m_ID INT,
    PRIMARY KEY (specimen_number, b_group),
    FOREIGN KEY (m_ID) REFERENCES BB_Manager(m_ID),
    FOREIGN KEY (dfind_ID) REFERENCES DiseaseFinder(dfind_ID)
);




--   Inserting  data into BloodSpecimen Table 


INSERT into BloodSpecimen
VALUES(1001, 'B+', 1,11,103),
(1002, 'O+', 1,12,102),
(1003, 'AB+', 1,11,102),
(1004, 'O-', 1,13,103),
(1005, 'A+', 0,14,102),
(1006, 'A-', 1,13,104),
(1007, 'AB-', 1,15,104),
(1008, 'AB-', 0,11,105),
(1009, 'B+', 1,13,105),
(1010, 'O+', 0,12,105),
(1011, 'O+', 1,13,103),
(1012, 'O-', 1,14,102),
(1013, 'B-', 1,14,102),
(1014, 'AB+', 0,15,105);


--  Creating  Recipent Table 

drop table recipient

CREATE TABLE Recipient (
    reci_ID INTEGER PRIMARY KEY,
    reci_name VARCHAR(100) NOT NULL,
    reci_age INT NOT NULL,
    reci_Bgrp VARCHAR(3) NOT NULL,
    reci_Bqnty INT NOT NULL,
     reco_ID INT,
     city_ID INT,
     m_ID INT,
	 reci_sex CHAR(1) NOT NULL,
	reci_reg_date DATE NOT NULL,
    FOREIGN KEY (reco_ID) REFERENCES Recording_Staff(reco_ID),
    FOREIGN KEY (city_ID) REFERENCES City(city_ID),
    FOREIGN KEY (m_ID) REFERENCES BB_Manager(m_ID)
);


 --   Inserting Data Into  Recipent 


INSERT into Recipient
VALUES(10001,'Mark',25,'B+',1.5,101212,1500,105,'M','2015-12-17'),
(10002,'Dan',60,'A+',1,101312,1300,102,'M','2015-12-16'),
(10003,'Steve',35,'AB+',0.5,101312,1200,102,'M','2015-10-17'),
(10004,'Parker',66,'B+',1,101212,1300,104,'M','2016-11-17'),
(10005,'Jason',53,'B-',1,101412,1400,105,'M','2015-04-17'),
(10006,'Preetham',45,'O+',1.5,101512,1500,105,'M','2015-12-17'),
(10007,'Swetha',22,'AB-',1,101212,1500,102,'F','2015-05-17'),
(10008,'Swathi',25,'B+',2,101412,1300,103,'F','2015-12-14'),
(10009,'Lance',30,'A+',1.5,101312,1200,104,'M','2015-02-16'),
(10010,'Marsh',25,'AB+',3.5,101212,1200,107,'M','2016-10-17');


