SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY gender


SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY race
ORDER BY count DESC


SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, 
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group
ORDER BY age_group;


SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;


SELECT ROUND(AVG(DATEDIFF(termdate, hire_date)),0)/365 AS avg_length_of_employment
FROM hr
WHERE termdate <= CURDATE() AND age >= 18;


SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;


SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;


SELECT department,
   total_count,
   terminated_count,
   terminated_count/total_count AS termination_rate
 FROM(
   SELECT department,
   count(*) AS total_count,
   SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
   FROM hr
   WHERE age >= 18
   GROUP BY department
 )  AS subquery
 ORDER BY termination_rate DESC;
 
 
 SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;


SELECT 
  year,
  hires,
  terminations,
  hires-terminations AS net_change,
  round((hires-terminations)/hires * 100, 2) AS net_chnge_percent
FROM (
  SELECT
    YEAR(hire_date) AS year,
    count(*) AS hires,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
  FROM hr
  WHERE age >= 18
  GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;


SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate IS NOT NULL AND age >= 18
GROUP BY department