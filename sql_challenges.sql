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

'''
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
https://dev.mysql.com/doc/refman/5.6/en/regexp.html for reference
https://dataschool.com/how-to-teach-people-sql/how-regex-works-in-sql/ also for reference
'''
select distinct city from station where city regexp '^[^aeiou]|[^aeiou]$';

'''
Query the list of CITY names from STATION that do not start with vowels AND do not end with vowels. Your result cannot contain duplicates.
'''
select distinct city from station where city regexp '^[^aeiou].*[^aeiou]$';

'''
Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
'''
select name from students
where marks > 75
order by right(name, 3), id;

'''
Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
where employee_id is an employees ID number, name is their name, months is the total number of months theyve been working for the company, and salary is their monthly salary.
''' 
select name from employee
order by name;

'''
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
'''
select name from employee
where salary > 2000
and months < 10;


'''
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn\'t want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve.

grade = grade level
mark = score, if lower than 8 then null
order desc by grade level, then by name
'''

select if (grades.grade <8, NULL, students.name), grades.grade, students.marks from students 
join grades on students.marks between grades.min_mark and grades.max_mark
order by grades.grade DESC, students.Name, students.marks;

/* using alias */
select if (gr.grade <8, NULL, s.name), gr.grade, s.marks from students as s 
join grades as gr on s.marks between gr.min_mark and gr.max_mark
order by gr.grade desc, s.name, s.marks;

'''
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
'''

/* select hacker id, and name for people who competed in more than one challenge with submission score = difficulty table score
order by number of challenges taken, then by ascending hacker_id*/
select h.hacker_id, h.name from submissions as s
join hackers as h on s.hacker_id = h.hacker_id
join challenges as c on s.challenge_id = c.challenge_id
join difficulty as d on c.difficulty_level = d.difficulty_level
where s.score = d.score group by h.hacker_id, h.name having count(*)>1
order by count(*) desc, h.hacker_id;


'''
Query the total population of all cities in CITY where District is California.
'''
select sum(population) from city
where district = 'California';

'''
Query the average population of all cities in CITY where District is California.
'''
select avg(population) from city
where district = 'California';

'''
Query a count of the number of cities in CITY having a Population larger than 10000.
'''
select count(id) from city
where population > 100000;

'''
Query the average population for all cities in CITY, rounded down to the nearest integer.
'''
select round(avg(population)) from city;

'''
Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
'''
select sum(population) from city
where countrycode = 'JPN';

'''
Query the difference between the maximum and minimum populations in CITY.
'''
select max(population) - min(population) from city;

'''
We define an employee\'s total earnings to be their monthly salary x months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.
'''
select (salary * months) as earnings, count(*) from employee
group by earnings
order by earnings desc
limit 1;

'''
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
'''
select round(sum(lat_n),2), round(sum(long_w),2) from station;

'''
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
'''
select round(sum(lat_n),4) from station
where lat_n > 38.7880
and lat_n < 137.2345;

'''
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.
'''
select round(max(lat_n),4) from station
where lat_n < 137.2345;

'''
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 . Round your answer to 4 decimal places.
'''
select round(long_w,4) from station
where lat_n < 137.2345
order by lat_n desc
limit 1;

'''
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780 . Round your answer to 4 decimal places.
'''
select round(lat_n,4) from station
where lat_n > 38.7780
order by lat_n
limit 1;

'''
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.
'''
select round(long_w,4) from station
where lat_n > 38.7780
order by lat_n
limit 1;