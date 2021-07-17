'''
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
'''
select * from city 
where population > 100000
and countrycode = 'USA';

'''
Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
'''
select name from city
where population > 120000
and countrycode = 'USA';

'''
Query all columns (attributes) for every row in the CITY table.
'''
select * from city;

'''
Query all columns for a city in CITY with the ID 1661.
'''
select * from city 
where ID = 1661;

'''
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
'''
select * from city 
where countrycode = 'JPN';

'''
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. 
'''
select name from city
where countrycode = 'JPN';



'''
Query a list of CITY and STATE from the STATION table. 
'''
select city, state from station;


'''
Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer. 
'''
select distinct city from station 
where ID % 2 = 0;

'''
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
'''
select count(city) - count(distinct city) from station;

'''
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. 
'''
/* the shortest */
select city, length(city) from station 
order by length(city), city limit 1;

/* the longest */
select city, length(city) from station
order by length(city) desc, city limit 1;

'''
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
'''
select distinct city from station
where (city like 'a%'
       or city like 'e%'
       or city like 'i%'
       or city like 'o%'
       or city like 'u%');
       
'''
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
'''
select distinct city from station
where (city like '%a'
       or city like '%e'
       or city like '%i'
       or city like '%o'
       or city like '%u');
       
'''
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
'''
select distinct city from station
where (city like 'a%'
       or city like 'e%'
       or city like 'i%'
       or city like 'o%'
       or city like 'u%')
and (city like '%a'
       or city like '%e'
       or city like '%i'
       or city like '%o'
       or city like '%u');
       
'''
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
'''
select distinct city from station
where (city not like 'a%'
       and city not like 'e%'
       and city not like 'i%'
       and city not like 'o%'
       and city not like 'u%');
/* or */
SELECT DISTINCT CITY FROM STATION WHERE upper(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') AND lower(SUBSTR(CITY,1,1)) NOT IN
('a','e','i','o','u');   

/* or */
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE 'A%' OR  CITY  LIKE 'E%' OR CITY  LIKE 'I%' OR CITY  LIKE 'O%' OR CITY  LIKE 'U%');

'''
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
'''
select distinct city from station 
where not (city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u');