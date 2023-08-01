-- The purpose of this project is to apply some common used sql command
--to pull up data that can summarize this dataset
Select * from Sleep_health_and_lifestyle_dataset shald 
where Daily_Steps in (6000,8000);

-- get average of sleep hour 
--partition on age and gender
select gender,age,round(avg(Sleep_Duration)
over(partition by age, gender order by Age, gender),2)
as average_sleep_hour
from Sleep_health_and_lifestyle_dataset;
-- create a temporary table name cte
-- add a new column name scale based on value in quality_of_sleep
With cte as (
select *,
case 
	when Quality_of_Sleep in (4,5) then 'Poor'
	when Quality_of_Sleep in (6,7) then 'Fair'
	Else 'Good'
end as "Scale"
from Sleep_health_and_lifestyle_dataset)

-- get info of people whose sleep quality are poor 
select Person_ID, gender, age, occupation, scale from cte
where scale ='Poor';
