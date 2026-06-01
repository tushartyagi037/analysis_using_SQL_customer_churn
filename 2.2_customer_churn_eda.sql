select *
from churn_staging;


alter table churn_staging
rename column `Usage Frequency` to usage_frequency;
alter table churn_staging
rename column `support calls` to support_calls;
alter table churn_staging
rename column `payment delay` to payment_delay;
alter table churn_staging
rename column `Subscription Type` to subscription_type;
alter table churn_staging
rename column `Contract Length` to contract_length;
alter table churn_staging
rename column `total spend` to total_spend;
alter table churn_staging
rename column `last interaction` to last_interaction;


# basic statistics 

-- Average age
select 
min(age) min_age,		-- 18
max(age) max_age,		-- 65
round(avg(age), 0) avg_age		-- 42
from churn_staging;

-- Average spend
select
min(total_spend) min_spend,
max(total_spend) max_spend,
round(avg(total_spend), 0) avg_spend
from churn_staging;


# Churn distribution
select
churn, count(*) customer_count,
round(count(*) * 100 / (select count(*) from churn_staging), 2) percentage
from churn_staging
group by churn;
-- churned- 47.37%, not churned- 52.63%


# Gender distribution (churn)
select gender, count(*) total_customers
from churn_staging
group by gender;


# Contract length analysis
select
contract_length, count(*) total_customers
from churn_staging
group by contract_length
order by total_customers desc;


# Subscription type analysis
select
subscription_type, count(*) total_customers
from churn_staging
group by subscription_type;


# Churn vs Gender (number of females and males churned and not-churned)
select 
gender, churn, count(*) total_customers
from churn_staging
group by gender, churn 
order by gender;


# churn vs contract length
select
contract_length, churn, count(*) total_customers
from churn_staging
group by contract_length, churn
order by Contract_length;


# churn vs subscription type
select
subscription_type, churn,
count(*) total_customers
from churn_staging
group by subscription_type, churn;


# average usage frequency by churn
select churn, avg(usage_frequency) avg_usage_frequency
from churn_staging
group by churn;


# Average support calls by churn
select
churn, avg(support_calls) avg_support_calls
from churn_staging
group by churn;


# Payment delay by Churn
select
churn, avg(payment_delay) avg_payment_delay
from churn_staging
group by churn;


# average spend by churn
select
churn, avg(total_spend) avg_total_spend
from churn_staging
group by churn;


# Tenure Analysis
select 
churn, avg(tenure) avg_tenure
from churn_staging
group by churn;


# Top 10 highest spending customers
select
customerid, total_spend
from churn_staging
order by total_spend desc
limit 10;


# Churn rate by age group
select
case
when age < 20 then 'Teen'
when age between 20 and 30 then '20-30'
when age between 31 and 40 then '31-40'
when age between 41 and 50 then '41-50'
else '50+'
end as age_group,
churn,
count(*) total_customers
from churn_staging
group by age_group, churn;