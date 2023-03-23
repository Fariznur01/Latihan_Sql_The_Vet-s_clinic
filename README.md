# Sql 

<br>
<div align="center">
    <a href=""><img src="/Clinic Pet/Images/Sql.png" width="200" hegiht="200" alt="Sql" title="Optional title"></a>
</div>
<a name="readme-top"></a>
<br>

[![PostgreSql](https://img.shields.io/badge/PostgreSql-blue.svg)]()

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#dataset"> Dataset </a></li> 
    <li><a href="#analisis">Analisis SQL</a></li>
    <li><a href="#author">Author</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project
Latihan studi analisa kasus The Vet's clinic dengan sql dan postgresql.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Dataset
Dataset:  https://drive.google.com/drive/folders/15-YtCjX_XjeNZ64KNpkfVZJTeTRMTmN2?usp=sharing

Dataset yang digunakan merupakan data dummy.

Tampilan Erd 

![Erd](https://user-images.githubusercontent.com/87837561/227065569-8ab7b7b9-c949-44fe-a56a-0eb2bfc9418b.png)


* Tabel Data P9-Owners
* Tabel Data P9-Pets
* Tabel Data P9-ProceduresDetails
* Tabel Data P9-ProceduresHistory
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Analisis SQL

```sql

#Membuat tabel dengan sql
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


```

```sql
#Ekstrak informasi tentang nama hewan peliharaan dan nama pemilik secara berdampingan

SELECT a1.nama nama_pemilik,b1.nama nama_hewan_pemilik,b1.kind jenis_hewan
FROM owners a1
INNER JOIN pets b1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,3
ORDER BY 3;

/*
create table owners_pets_kind
as 
SELECT a1.nama nama_pemilik,b1.nama nama_hewan_pemilik,b1.kind jenis_hewan
FROM owners a1
INNER JOIN pets b1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,3
ORDER BY 3;

*/
```
![1](https://user-images.githubusercontent.com/87837561/227066646-97dd81df-8314-400c-b4a4-c1a02c2bb768.png)

```sql
#Cari tahu hewan peliharaan mana dari klinik ini yang menjalani prosedur
SELECT DISTINCT nama
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid;

SELECT nama, proceduretype, count(2) AS total_procedure
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
WHERE c1.petid IS not null
GROUP BY 1,2
ORDER BY 1;

```

![2](https://user-images.githubusercontent.com/87837561/227066893-fed89a38-ca6e-489d-b8d5-7a07f985dffc.png)

```sql
#Cocokkan semua prosedur yang dilakukan dengan deskripsinya
SELECT b1.nama, c1.proceduretype, count(2) AS total_procedure, d1.description
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
GROUP BY 1,2,4
ORDER BY 1;

```

![3](https://user-images.githubusercontent.com/87837561/227067070-7b94b7bc-ddb5-4031-a6a3-01ee1e895801.png)

```sql
#Sama seperti di atas tetapi hanya atau hewan peliharaan dari klinik yang bersangkutan
SELECT b1.nama, c1.proceduretype, count(2) AS total_procedure, d1.description, a1.states, a1.city
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,4,5,6

```

![4](https://user-images.githubusercontent.com/87837561/227067533-f50e29c9-8415-4216-b5f4-f3c378d64623.png)

```sql
#Sama seperti di atas tetapi hanya atau hewan peliharaan dari klinik yang bersangkutan
SELECT b1.nama, c1.proceduretype, count(2) AS total_procedure, d1.description, a1.states, a1.city
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,4,5,6

```

![4](https://user-images.githubusercontent.com/87837561/227067694-037b0058-2a3c-4bdc-99de-460a429ed47f.png)

```sql
--Ekstrak tabel biaya individu (harga prosedur) yang dikeluarkan oleh pemilik hewan peliharaan dari klinik yang bersangkutan (tabel ini harus berdampingan dengan harga pemilik dan prosedur)
SELECT a1.nama, b1.nama, c1.proceduretype, d1.price
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,3,4
ORDER BY 4 DESC;

/*
create table owners_pays
as 
SELECT a1.nama as owner, b1.nama as nama_hewan, c1.proceduretype, d1.price
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,3,4
ORDER BY 4 DESC;
*/

```

![5](https://user-images.githubusercontent.com/87837561/227067757-d856c91f-a23e-4ffa-9ba8-32c11c94e510.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHOR -->
## Author

* **Fariz Nurfadillah** 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

