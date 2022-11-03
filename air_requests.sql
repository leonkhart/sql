
# create DB
CREATE DATABASE aircrafts;

# start work with db
USE aircrafts;


# create tables 
CREATE TABLE manufacturers(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    origin VARCHAR(20),
    PRIMARY KEY (id)
);


CREATE TABLE type(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE details(
    id INT NOT NULL AUTO_INCREMENT,
    model VARCHAR(25) NOT NULL,
    manufacturers_id INT,
    type_id INT,
    first_flight DATE,
    number_built INT,
    PRIMARY KEY (id),
    FOREIGN KEY(manufacturers_id) REFERENCES manufacturers(id),
    FOREIGN KEY(type_id) REFERENCES type(id)
);    


# add info 
INSERT INTO type(name)
VALUES
('Regional jet'), ('Narrow-body'), ('Wide-body'), ('Narrow-body jet');

INSERT INTO manufacturers(name, origin)
VALUES
('Airbus', 'Europe'), ('Boeing', 'USA'), ('Sukhoi', 'Russia'), ('Fokker', 'Netherlands'), ('Tupolev', 'Russia');


# change column's name 
ALTER TABLE type
RENAME COLUMN name TO type_name;

ALTER TABLE MANUFACTURERS
RENAME COLUMN name TO m_name;

# 
# select all from every table 
# 

SELECT * FROM type;

/* results 
+----+-----------------+
| id | type_name       |
+----+-----------------+
|  1 | Regional jet    |
|  2 | Narrow-body     |
|  3 | Wide-body       |
|  4 | Narrow-body jet |
|  5 | Business jets   |
|  6 | Cargo jet       |
+----+-----------------+
*/


SELECT * FROM manufacturers;
/* results 
+----+-------------------+-------------+
| id | m_name            | origin      |
+----+-------------------+-------------+
|  1 | Airbus            | Europe      |
|  2 | Boeing            | USA         |
|  3 | Sukhoi            | Russia      |
|  4 | Fokker            | Netherlands |
|  5 | Tupolev           | Russia      |
|  6 | Douglas           | USA         |
|  7 | Bombardier        | Canadair    |
|  8 | Dassault Aviation | France      |
|  9 | Comac             | Chine       |
| 10 | Cessna            | USA         |
| 11 | Fairchild Dornier | Germany     |
| 12 | Mitsubishi        | Japan       |
+----+-------------------+-------------+
*/


SELECT * FROM details;
/* results
+----+----------------+------------------+---------+--------------+--------------+
| id | model          | manufacturers_id | type_id | first_flight | number_built |
+----+----------------+------------------+---------+--------------+--------------+
|  1 | 747            |                2 |       3 | 1969-02-09   |         1572 |
|  2 | A330           |                1 |       3 | 1992-11-02   |         1548 |
|  3 | SSJ100         |                3 |       1 | 2008-05-19   |          172 |
|  4 | 717            |                2 |       2 | 1999-10-12   |          156 |
|  5 | Fokker 100     |                4 |       1 | 1988-04-03   |          283 |
|  6 | Tu-154         |                5 |       2 | 1968-10-04   |         1026 |
|  7 | 737            |                2 |       2 | 1967-04-09   |        11154 |
|  8 | A318           |                1 |       2 | 2002-01-15   |           80 |
|  9 | DC-8           |                6 |       2 | 1958-05-30   |          556 |
| 10 | Challenger 300 |                7 |       5 | 2004-01-08   |          450 |
| 11 | Falcon 7X      |                8 |       5 | 2005-05-05   |          289 |
+----+----------------+------------------+---------+--------------+--------------+
*/


# select only company name, models and type of airplane  
SELECT manufacturers.m_name, details.model, type.type_name
FROM
    details
    JOIN manufacturers on details.manufacturers_id = manufacturers.id 
    JOIN type ON details.type_id = type.id;
 
/*results
+-------------------+----------------+----------------+
| m_name            | model          | type_name      |
+-------------------+----------------+----------------+
| Boeing            | 747            | Wide-body      |
| Airbus            | A330           | Wide-body      |
| Sukhoi            | SSJ100         | Regional jet   |
| Boeing            | 717            | Narrow-body    |
| Fokker            | Fokker 100     | Regional jet   |
| Tupolev           | Tu-154         | Narrow-body    |
| Boeing            | 737            | Narrow-body    |
| Airbus            | A318           | Narrow-body    |
| Douglas           | DC-8           | Narrow-body    |
| Bombardier        | Challenger 300 | Business jets  |
| Dassault Aviation | Falcon 7X      | Business jets  |
+-------------------+----------------+----------------+
*/

# same result with left/right joins 
SELECT manufacturers.m_name, details.model, type.type_name
FROM
    manufacturers
    RIGHT JOIN details ON manufacturers.id = details.manufacturers_id
    LEFT JOIN type ON details.type_id = type.id;


#select only regional jet 
SELECT manufacturers.m_name, details.model, type.type_name
FROM
    manufacturers
    RIGHT JOIN details ON manufacturers.id = details.manufacturers_id
    LEFT JOIN type ON details.type_id = type.id
WHERE type_name = 'Regional jet';

/*results
+--------+------------+--------------+
| m_name | model      | type_name    |
+--------+------------+--------------+
| Sukhoi | SSJ100     | Regional jet |
| Fokker | Fokker 100 | Regional jet |
+--------+------------+--------------+
*/


#select only narrow-body airplans 
SELECT manufacturers.m_name, details.model, type.type_name
FROM
    details
    JOIN manufacturers on details.manufacturers_id = manufacturers.id 
    JOIN type ON details.type_id = type.id
WHERE type_name = 'Narrow-body';

/*results
+---------+--------+-------------+
| m_name  | model  | type_name   |
+---------+--------+-------------+
| Boeing  | 717    | Narrow-body |
| Tupolev | Tu-154 | Narrow-body |
| Boeing  | 737    | Narrow-body |
| Airbus  | A318   | Narrow-body |
| Douglas | DC-8   | Narrow-body |
+---------+--------+-------------+*/


# select only company name and model with ascending order for two column 
SELECT manufacturers.m_name, details.model
FROM
    manufacturers
    INNER JOIN details ON manufacturers.id = details.manufacturers_id
ORDER BY m_name, model;

/*results
+-------------------+----------------+
| m_name            | model          |
+-------------------+----------------+
| Airbus            | A318           |
| Airbus            | A330           |
| Boeing            | 717            |
| Boeing            | 737            |
| Boeing            | 747            |
| Bombardier        | Challenger 300 |
| Dassault Aviation | Falcon 7X      |
| Douglas           | DC-8           |
| Fokker            | Fokker 100     |
| Sukhoi            | SSJ100         |
| Tupolev           | Tu-154         |
+-------------------+----------------+*/


# select MAX and MIN number_built use nested query 
SELECT manufacturers.m_name, details.model, details.number_built
FROM
    details
    JOIN manufacturers ON details.manufacturers_id = manufacturers.id 
WHERE number_built = (
        SELECT MIN(number_built)
        FROM details)
OR number_built = (
        SELECT MAX(number_built)
        FROM details)
ORDER BY number_built;

/*results
+--------+-------+--------------+
| m_name | model | number_built |
+--------+-------+--------------+
| Airbus | A318  |           80 |
| Boeing | 737   |        11154 |
+--------+-------+--------------+*/


# select airplanes witch the first flight was done for 20 years from curent date  
SELECT manufacturers.m_name, details.model, details.first_flight
FROM
    details
    JOIN manufacturers ON manufacturers.id = details.manufacturers_id
WHERE DATEDIFF(CURDATE(), first_flight) < 365*20;
/*results
+-------------------+----------------+--------------+
| m_name            | model          | first_flight |
+-------------------+----------------+--------------+
| Sukhoi            | SSJ100         | 2008-05-19   |
| Bombardier        | Challenger 300 | 2004-01-08   |
| Dassault Aviation | Falcon 7X      | 2005-05-05   |
+-------------------+----------------+--------------+*/
