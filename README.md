# Data Jobs Salaries
### Tools in use: Python, MySQL, Tableau

#### About Dataset

This dataset was retrieved from the page https://ai-jobs.net/salaries/download/

This site collects salary information anonymously from professionals all over the world in the AI, ML, Data Science space and makes it publicly available for anyone to use, share and play around with.

The primary goal is to have data that can provide better guidance in regards to what's being paid globally. So newbies, experienced pros, hiring managers, recruiters and also startup founders or people wanting to make a career switch can make better informed decisions.

### Tableau Visualization
#### Note: You can check this visualization and use filters to get specific information at this link: [click](https://public.tableau.com/app/profile/danylo.sushko/viz/DataSalaries_16979256360700/DataSalaryOverview?publish=yes)
![image](https://github.com/daunyl/data_salaries/assets/137568373/a8af2e6c-5a1e-44a2-aca4-4b83205e9087)


### Hypothesis testing

#### 1. Question: Is mid-level people working on a hybrid type of work get paid less than people working on Fully remote or On-site?

**Null Hypothesis**: Mid-level people working on a hybrid type of work get paid the same as people working on Fully remote or On-site.

**Alternative Hypothesis**: Mid-level people working on a hybrid type of work get paid less than people working on Fully remote or On-site.

![image](https://github.com/daunyl/data_salaries/assets/137568373/d76d5985-6337-4104-ba3d-4d38c71f7db3)

##### The result is: 
`Reject null hypothesis: There is a significant difference in salaries.`

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### 2. Question: Do entry-level residents of other countries receive lower wages than citizens of the company's country?
**Null Hypothesis**: Entry-level residents of other countries do not receive lower wages than citizens of the company's country.

**Alternative Hypothesis**: Entry-level residents of other countries receive lower wages than citizens of the company's country.

![image](https://github.com/daunyl/data_salaries/assets/137568373/e241c265-088f-46f1-952c-fd5dc7488dc3)

![image](https://github.com/daunyl/data_salaries/assets/137568373/27ee7824-6ecd-4287-8173-2934cf1231d9)

##### The result is:
`Fail to reject null hypothesis: Entry-level residents of other countries do not receive lower wages than citizens of the company's country.`
