select *
from customer_churn;
select count(*)
from customer_churn;
describe customer_churn;

create table churn_staging
like customer_churn;

insert into churn_staging
select *
from customer_churn;


select *
from churn_staging;		-- 64374 records


# Handling Duplicates
select customerid, count(*) record_count
from churn_staging
group by customerid
having count(*) > 1;
-- no duplicate records found


# checking for missing & null values
select
sum(case when customerid is null then 1 else 0 end) null_id,
sum(case when age is null then 1 else 0 end) null_age,
sum(case when gender is null then 1 else 0 end) null_gender,
sum(case when tenure is null then 1 else 0 end) null_tenure,
sum(case when 'subscription type' is null or 'subscription_type' = '' then 1 else 0 end) null_subscription,
sum(case when 'total spend' is null then 1 else 0 end) null_spend,
sum(case when churn is null then 1 else 0 end) null_churn
from churn_staging;
-- zero missing and null values


# checking consistency in columns
select distinct gender
from churn_staging;
-- only Female & Male (consistent)

select distinct 'subscription type'
from churn_staging;
-- consistent

select distinct 'contract length'
from churn_staging;
-- consistent


select *
from churn_staging;