-- 1.	Write a query that returns a list of all the unique values in the 'country' field.
SELECT DISTINCT country
FROM ksprojects;

-- 2. How many unique values are there for the main_category field? What about for the category field?

SELECT COUNT(DISTINCT main_category), COUNT(DISTINCT category)
FROM ksprojects;
-- 15 FOR main_category, 158 for category

-- 3. Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.
SELECT DISTINCT main_category, category 
FROM ksprojects
ORDER BY main_category;

--4.How many unique categories are in each main_category?
SELECT main_category, COUNT(DISTINCT category)
FROM ksprojects
GROUP BY main_category
ORDER BY main_category;

--5.Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted from high to low.
SELECT main_category, ROUND(AVG(backers),0) as avg_backers
FROM ksprojects
GROUP BY main_category
ORDER BY avg_backers DESC;

--"Games"	342
--"Design"	254
--"Technology"	167
--"Comics"	138
--"Fashion"	68
--"Film & Video"	59
--"Food"	56
--"Publishing"	50
--"Music"	48
--"Theater"	44
--"Dance"	43
--"Journalism"	40
--"Art"	40
--"Photography"	39
--"Crafts"	25

--6.Write a query that shows, for each category, how many campaigns were successful and the average difference per project between dollars pledged and the goal.
SELECT COUNT(category) as category, AVG(usd_pledged - goal) as raised_over_goal
FROM ksprojects
WHERE state='successful'
GROUP BY category;
-- ORDER BY category
-- note, should be able to round dummy column?

--7.Write a query that shows, for each main category, how many projects had zero backers for that category and the largest goal amount for that category (also for projects with zero backers).
SELECT main_category, MAX(goal) AS largest_goal, COUNT(*) AS zero_backers
FROM ksprojects
WHERE backers=0
GROUP BY main_category;

--8. For each category, find the average USD per backer, and return only those results for which the average USD per backer is < $50, sorted high to low. Hint: Division by NULL is not possible, so use NULLIF to replace NULLs with 0 in the average calculation.
SELECT category, ROUND(avg(usd_pledged/NULLIF(backers,0))) as avg_pledge_per_backer
FROM ksprojects
GROUP BY category
HAVING avg(usd_pledged/NULLIF(backers,0)) < 50
ORDER BY avg_pledge_per_backer DESC;

--9.Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers.
SELECT COUNT(main_category), main_category
FROM ksprojects
WHERE state='successful' AND backers BETWEEN 5 and 10
GROUP BY main_category;

--10.Get a total of the amount ‘pledged’ for each type of currency grouped by its respective currency. Sort by ‘pledged’ from high to low.
SELECT currency, LOG(SUM(pledged)) as pledged
FROM ksprojects
GROUP BY currency
ORDER BY SUM(pledged) DESC;

--11. Excluding Games and Technology records in the main_category field, return the total of all backers for successful projects by main_category where the total was more than 100,000. Sort by main_category from A to Z.
SELECT main_category, SUM(backers) as successful_projects
FROM ksprojects
WHERE main_category NOT IN('Games', 'Technology') and state='successful'
GROUP BY main_category
HAVING SUM(backers)> 100000
ORDER BY successful_projects ASC;
