create database Bank_loan;
Use Bank_loan;
select * from finance_1;
select * from  finance_2;

##### KPI 1 (YEAR WISE LOAN AMOUNT STATS) #####
SELECT YEAR(issue_d) AS issue_year, SUM(loan_amnt) AS Total_Loan_amnt
FROM finance_1
GROUP BY issue_year;

##### KPI 2 (GRADE AND SUB GRADE WISE REVOL_BAL) #####
select grade, sub_grade,sum(revol_bal) as total_revol_bal
from finance_1 B1 inner join finance_2 B2 
on(B1.id = B2.id) 
group by grade,sub_grade
order by grade;

##### KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status) #####
select verification_status, round(sum(total_pymnt),2) as Total_payment
from finance_1 B1 inner join finance_2 B2 
on(B1.id = B2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

##### KPI 4 (State wise and last_credit_pull_d wise loan status) #####
SELECT addr_state, last_credit_pull_d, MAX(loan_status) AS max_loan_status
FROM finance_1 B1
INNER JOIN finance_2 B2 ON B1.id = B2.id
GROUP BY addr_state, last_credit_pull_d
ORDER BY addr_state;

##### KPI 5 (Home ownership Vs last payment date stats) #####
SELECT
    home_ownership,
    last_pymnt_d,
    CONCAT('$', FORMAT(ROUND(SUM(last_pymnt_amnt) / 1000, 2), 'K')) AS total_Amount
FROM finance_1
INNER JOIN finance_2 ON finance_1.id = finance_2.id
GROUP BY home_ownership, last_pymnt_d
ORDER BY last_pymnt_d DESC, home_ownership DESC;

## Yearly Interest Received ##

select year(last_pymnt_d) as received_year, cast(sum(total_rec_int) as decimal (10,2)) as interest_received
from finance_2
group by received_year
order by received_year;

##Term Wise Popularity##
select term, sum(loan_amnt) total_amount from finance_1
group by term;

##Top 5 States## 
select addr_state as state_name, count(*) as customer_count
from finance_1
group by addr_state
order by customer_count desc
limit 5;



