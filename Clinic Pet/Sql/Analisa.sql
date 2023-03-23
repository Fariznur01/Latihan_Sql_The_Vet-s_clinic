--Ekstrak informasi tentang nama hewan peliharaan dan nama pemilik secara berdampingan
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

--Cari tahu hewan peliharaan mana dari klinik ini yang menjalani prosedur
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

--Cocokkan semua prosedur yang dilakukan dengan deskripsinya
SELECT b1.nama, c1.proceduretype, count(2) AS total_procedure, d1.description
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
GROUP BY 1,2,4
ORDER BY 1;

--Sama seperti di atas tetapi hanya atau hewan peliharaan dari klinik yang bersangkutan
SELECT b1.nama, c1.proceduretype, count(2) AS total_procedure, d1.description, a1.states, a1.city
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
GROUP BY 1,2,4,5,6

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

SELECT SUM(d1.price) AS total_penerimaan, AVG(d1.price) AS rata_rata_pembayaran, 
MAX(d1.price) AS pembayaran_tertinggi, MIN(d1.price) AS pembayaran_terendah, COUNT(a1.nama) AS jmh_pengunjung 
FROM pets b1
JOIN procedureshistory c1
ON b1.petid = c1.petid
JOIN proceduredetails d1
ON d1.proceduretype = c1.proceduretype 
JOIN owners a1
ON a1.owner_id = b1.owner_id
ORDER BY 1 DESC;

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

SELECT * FROM owners_pays;
