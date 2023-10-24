SELECT * FROM salaries;

-- Number of NaN values in the whole table
SELECT sum(
	isnull(work_year) + 
    isnull(experience_level) +
    isnull(employment_type) +
    isnull(job_title) +
    isnull(salary) +
    isnull(salary_currency) +
    isnull(salary_in_usd) +
    isnull(employee_residence) +
    isnull(remote_ratio) +
    isnull(company_location) +
    isnull(company_size)
	) AS number_of_nans
FROM salaries;

-- Top 5 salaries for data professionals in different companies
WITH ranked_salaries AS (
    SELECT 
        company_size,
        job_title,
        round(avg(salary_in_usd), 2) as average_salary,
        ROW_NUMBER() OVER (PARTITION BY company_size ORDER BY round(avg(salary_in_usd), 2) DESC) AS rnk
    FROM salaries
    GROUP BY company_size, job_title
)
SELECT 
    company_size,
    job_title,
    average_salary
FROM ranked_salaries
WHERE rnk <= 5
ORDER BY company_size DESC, average_salary DESC;

-- Employment type distribution
SELECT
	employment_type,
	count(*) as number_of_observations
FROM salaries
group by employment_type;

-- Top paying companies
SELECT company_location, company_size, ROUND(AVG(salary_in_usd),2) as avg_salary
FROM salaries
GROUP BY company_location, company_size
ORDER BY avg_salary DESC
LIMIT 10;

-- Employee Retention Rate by Company Size and Employment Type
SELECT 
    s.company_size, 
    s.employment_type, 
    COUNT(CASE WHEN s.work_year = max_year.max_work_year THEN 1 END) as current_employees,
    COUNT(*) as total_employees,
    (COUNT(CASE WHEN s.work_year = max_year.max_work_year THEN 1 END) / COUNT(*)) * 100 as retention_rate
FROM 
    salaries s
JOIN (
    SELECT company_size, employment_type, MAX(work_year) as max_work_year
    FROM salaries
    GROUP BY company_size, employment_type
) max_year ON s.company_size = max_year.company_size AND s.employment_type = max_year.employment_type
GROUP BY s.company_size, s.employment_type;

-- Employee Churn Analysis by Experience Level and Company Size
SELECT 
    s.experience_level, 
    s.company_size, 
    COUNT(CASE WHEN s.work_year = max_year.max_work_year THEN 1 END) as current_employees,
    COUNT(*) as total_employees,
    (COUNT(CASE WHEN s.work_year = max_year.max_work_year THEN 1 END) / COUNT(*)) * 100 as churn_rate
FROM 
    salaries s
JOIN (
    SELECT experience_level, company_size, MAX(work_year) as max_work_year
    FROM salaries
    GROUP BY experience_level, company_size
) max_year ON s.experience_level = max_year.experience_level AND s.company_size = max_year.company_size
GROUP BY s.experience_level, s.company_size;

-- Salary Benchmarking by Job Title and Location
SELECT job_title, company_location, AVG(salary_in_usd) as avg_salary,
       MAX(salary_in_usd) as max_salary,
       MIN(salary_in_usd) as min_salary
FROM salaries
GROUP BY job_title, company_location;

-- Job Title with Highest Salary Fluctuation
WITH salary_fluctuation AS (
    SELECT job_title, MAX(salary_in_usd) - MIN(salary_in_usd) as salary_fluctuation
    FROM salaries
    GROUP BY job_title
)
SELECT job_title, salary_fluctuation
FROM salary_fluctuation
ORDER BY salary_fluctuation DESC
LIMIT 1;

-- Year-over-Year Salary Growth by Job Title
SELECT job_title, work_year, 
       AVG(salary_in_usd) - LAG(AVG(salary_in_usd)) OVER (PARTITION BY job_title ORDER BY work_year) as salary_growth
FROM salaries
GROUP BY job_title, work_year
ORDER BY job_title, work_year;

-- Salary Trends by Job Title For Entry-level employees
SELECT work_year, job_title,
	AVG(salary_in_usd) as average_salary,
    LAG(AVG(salary_in_usd), 1) OVER(PARTITION BY job_title ORDER BY work_year ASC) AS previous_year_salary
FROM salaries
WHERE experience_level = 'Entry-level'
GROUP BY work_year, job_title
ORDER BY job_title ASC, work_year ASC;

