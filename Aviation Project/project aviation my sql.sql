create database aviation;
use aviation;
CREATE TABLE flight_data (
    MONTH INT NOT NULL,
    DAY INT NOT NULL,
    DAY_OF_WEEK INT NOT NULL,
    AIRLINE VARCHAR(10) NOT NULL,
    FLIGHT_NUMBER INT NOT NULL,
    ORIGIN_AIRPORT VARCHAR(10) NOT NULL,
    DESTINATION_AIRPORT VARCHAR(10) NOT NULL,
    DEPARTURE_DELAY FLOAT NOT NULL,
    DISTANCE INT NOT NULL,
    ARRIVAL_DELAY FLOAT NOT NULL,
    CANCELLED INT NOT NULL,
    CANCELLATION_REASON VARCHAR(20),
    CITY varchar(50) NOT NULL,
    STATE varchar(20) not null
);

SHOW VARIABLES LIKE '%dir%';

load DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/flights.csv"
INTO TABLE flight_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

Select count(*) from flight_data;



Select Airline, Count(*) 
from flight_data
Group by Airline;



select count(*) from flight_data;
select * from flight_data;


#1 Weekday Vs Weekend total flight statistics





-- # 1. Weekday Vs Weekend total flights statistics

SELECT
    CASE
	WHEN DAY_OF_WEEK IN (6,7) THEN 'Weekend'
	ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS Canceled
FROM flight_data
GROUP BY day_type;

#2 Total number of cancelled flights for JetBlue Airways on first date of every month

CREATE VIEW JBCancellations AS
SELECT AIRLINE, Count(AIRLINE) as Flights_Count
FROM flight_data
WHERE AIRLINE = "B6" AND DAY = 1;

select * from JBCancellations;

#3 Week wise, State wise and City wise statistics of delay of flights with airline details

Select 
      day_of_week,state,city,
      count(DEPARTURE_DELAY) as DEPARTURE_DELAY,
      count(ARRIVAL_DELAY) as ARRIVAL_DELAY 
from flight_data
group by day_of_week,state,city;

#4 Number of airlines with No departure/arrival delay with distance covered between 2500 and 3000


SELECT AIRLINE, Count(AIRLINE) as NodelayFlights
FROM flight_data
WHERE DEPARTURE_DELAY >=0 AND ARRIVAL_DELAY>=0 AND
DISTANCE BETWEEN 2500 AND 3000
GROUP BY AIRLINE
ORDER BY NodelayFlights DESC;
