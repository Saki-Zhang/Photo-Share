DROP DATABASE PHOTOSHARE;
CREATE DATABASE PHOTOSHARE;

USE PHOTOSHARE;

CREATE TABLE USER (
  UID INT NOT NULL AUTO_INCREMENT,
  EMAIL VARCHAR(30) UNIQUE NOT NULL,
  PASSWORD VARCHAR(30) NOT NULL,
  FNAME VARCHAR(30) NOT NULL,
  LNAME VARCHAR(30) NOT NULL,
  GENDER VARCHAR(10),
  DOB DATE NOT NULL,
  HOMETOWN VARCHAR(30),
  PRIMARY KEY (UID)
);

CREATE TABLE FRIENDSHIP (
  UID1 INT NOT NULL,
  UID2 INT NOT NULL,
  PRIMARY KEY (UID1, UID2),
  FOREIGN KEY (UID1) REFERENCES USER (UID) ON DELETE CASCADE,
  FOREIGN KEY (UID2) REFERENCES USER (UID) ON DELETE CASCADE
);

CREATE TABLE ALBUM (
  AID INT NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(30) NOT NULL,
  DOC TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UID INT NOT NULL,
  PRIMARY KEY (AID),
  FOREIGN KEY (UID) REFERENCES USER (UID) ON DELETE CASCADE
);

CREATE TABLE PHOTO (
  PID INT NOT NULL AUTO_INCREMENT,
  CAPTION VARCHAR(200),
  DATA VARCHAR(100) NOT NULL,
  AID INT NOT NULL,
  PRIMARY KEY (PID),
  FOREIGN KEY (AID) REFERENCES ALBUM (AID) ON DELETE CASCADE
);

CREATE TABLE TAG (
  HASHTAG VARCHAR(30) NOT NULL,
  PRIMARY KEY (HASHTAG)
);

CREATE TABLE ASSOCIATE (
  PID INT NOT NULL,
  HASHTAG VARCHAR(30) NOT NULL,
  PRIMARY KEY (PID, HASHTAG),
  FOREIGN KEY (PID) REFERENCES PHOTO (PID) ON DELETE CASCADE,
  FOREIGN KEY (HASHTAG) REFERENCES TAG (HASHTAG) ON DELETE CASCADE
);

CREATE TABLE COMMENT (
  CID INT NOT NULL AUTO_INCREMENT,
  CONTENT VARCHAR(200) NOT NULL,
  DOC TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UID INT NOT NULL,
  PID INT NOT NULL,
  PRIMARY KEY (CID),
  FOREIGN KEY (UID) REFERENCES USER (UID) ON DELETE CASCADE,
  FOREIGN KEY (PID) REFERENCES PHOTO (PID) ON DELETE CASCADE
);

CREATE TABLE FAVORITE (
  UID INT NOT NULL,
  PID INT NOT NULL,
  DOC TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UID, PID),
  FOREIGN KEY (UID) REFERENCES USER (UID) ON DELETE CASCADE,
  FOREIGN KEY (PID) REFERENCES PHOTO (PID) ON DELETE CASCADE
);

INSERT INTO USER (EMAIL, PASSWORD, FNAME, LNAME, DOB) VALUES ('anonymous@photoshare.com', 'password', 'Anonymous', 'User', '2017-10-01');
INSERT INTO USER (EMAIL, PASSWORD, FNAME, LNAME, DOB) VALUES ('zqzhang@bu.edu', 'hello', 'Zuoqi', 'Zhang', '2017-10-01');
INSERT INTO USER (EMAIL, PASSWORD, FNAME, LNAME, DOB) VALUES ('chahuang@bu.edu', 'hello', 'Charles', 'Huang', '2017-10-01');
INSERT INTO USER (EMAIL, PASSWORD, FNAME, LNAME, DOB) VALUES ('test@bu.edu', 'test', 'test', 'test', '2017-10-01');
INSERT INTO USER (EMAIL, PASSWORD, FNAME, LNAME, DOB) VALUES ('aa@aa.com', 'aa', 'aa', 'aa', '2017-10-01');

INSERT INTO FRIENDSHIP VALUES (2, 3);
INSERT INTO FRIENDSHIP VALUES (3, 2);
INSERT INTO FRIENDSHIP VALUES (2, 4);
INSERT INTO FRIENDSHIP VALUES (4, 2);

INSERT INTO ALBUM (NAME, DOC, UID) VALUES ('Default', CURRENT_TIMESTAMP, 4);
INSERT INTO ALBUM (NAME, DOC, UID) VALUES ('Test', CURRENT_TIMESTAMP, 4);

INSERT INTO PHOTO (CAPTION, DATA, AID) VALUES ('Photo 1', '1.jpg', 1);
INSERT INTO PHOTO (CAPTION, DATA, AID) VALUES ('Photo 2', '2.jpg', 2);
INSERT INTO PHOTO (CAPTION, DATA, AID) VALUES ('Photo 3', '3.jpg', 2);

INSERT INTO TAG VALUES ('boston');
INSERT INTO TAG VALUES ('icon');

INSERT INTO ASSOCIATE VALUES (1, 'boston');
INSERT INTO ASSOCIATE VALUES (1, 'icon');
INSERT INTO ASSOCIATE VALUES (2, 'icon');
INSERT INTO ASSOCIATE VALUES (3, 'icon');

INSERT INTO COMMENT (CONTENT, DOC, UID, PID) VALUES ('Comment from test user.', CURRENT_TIMESTAMP, 4, 1);
INSERT INTO FAVORITE VALUES (5, 1, CURRENT_TIMESTAMP);