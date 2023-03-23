CREATE TABLE pets (
 petid TEXT PRIMARY KEY,
 nama VARCHAR,
 kind VARCHAR,
 gender VARCHAR,
 age INTEGER,
 owner_id INTEGER	
);	


CREATE TABLE owners (
 owner_id INTEGER PRIMARY KEY,
 nama VARCHAR,
 surname VARCHAR,
 steertaddress TEXT,
 city VARCHAR,
 states VARCHAR,
 statefull VARCHAR,
 zipcode INTEGER);	
 
 CREATE TABLE procedureshistory (
 petid TEXT,
 date DATE,
 proceduretype TEXT,
 proceduresubcode INTEGER
);
--Tabel procedurehistory tidak ada kolom unik

CREATE TABLE proceduredetails (
 proceduretype TEXT,
 proceduresubcode INTEGER,
 description TEXT,
 price INTEGER	
);

--Tabel proceduredetails tidak ada kolom unik

