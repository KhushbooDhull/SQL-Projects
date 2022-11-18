
# SQL -->
#	1. DDL => Data Definition Langugage
#			create, insert, update, drop ---

#	2. DML => Data Manipulation Language
#			alter, modify, change ----

create schema company ;

use company ;

CREATE TABLE EmPloYee (
	fname varchar(30),		# 	varchar becoz - frees extra memory
	minit char(1),
	lname varchar(30),
	ssn char(9),  
	bdate date,
	address varchar(50),
	sex char(1),
	salary float(10, 2),
	super_ssn char(9),
	dno char(3) 
   ) ;


insert into employee values
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5), 
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,'888665555',5), 
('Alicia','J','Zelaya','999887777','1968-01-09','3321 Castle, Spring, TX','F',25000,'987654321',4), 
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F',43000,'888665555',4), 
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,'333445555',5), 
('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,'333445555',5), 
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,'987654321',4), 
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000, NULL,1) ;


create table deartment(
dname varchar(20),
dnumber varchar(2),
mgr_ssn char(9),
mgr_start_date date);


insert into deartment VALUES 
('Research',5,333445555,'1988-05-22'), 
('Administration',4,987654321,'1995-01-01'), 
('Headquarters',1,888665555,'1981-06-19'); 


create table dept_locations( 
dnumber int, 
dlocation varchar(20)); 


insert into dept_locations values 
(1, 'Houston'), 
(4, 'Stafford'), 
(5, 'Bellaire'), 
(5, 'Sugarland'), 
(5, 'Houston'); 



create table works_on( 
essn char(9), 
pno int, 
hours float(4,2));


insert into works_on (essn, pno, hours) values 
('123456789', 1, 32.5), 
('123456789', 2, 7.5), 
('666884444', 3, 40.0), 
('453453453', 1, 20.0), 
('453453453', 2, 20.0), 
('333445555', 2, 10.0), 
('333445555', 3, 10.0), 
('333445555', 10, 10.0), 
('333445555', 20, 10.0), 
('999887777', 30, 30.0), 
('999887777', 10, 10.0), 
('987987987', 10, 35.0), 
('987987987', 30, 5.0), 
('987654321', 30, 20.0), 
('987654321', 20, 15.0), 
('888665555', 20, NULL); 




create table project( 
pname varchar(30), 
pnumber int, 
plocation varchar(30), 
dnum int); 


insert into project(pname,pnumber,plocation,dnum) values 
('ProductX', 1, 'Bellaire', 5), 
('ProductY', 2, 'Sugarland', 5), 
('ProductZ', 3, 'Houston', 5), 
('Computerization', 10, 'Stafford', 4), 
('Reorganization', 20, 'Houston', 1), 
('Newbenefits', 30, 'Stafford', 4); 


create table dependent( 
essn char(9), 
dependent_name varchar(30), 
sex char(1), 
bdate date, 
relationship varchar(20)); 


insert into dependent(essn,dependent_name,sex,bdate,relationship) values 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'), 
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'), 
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'), 
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'), 
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'), 
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


#drop table department ;

#drop view emp_view;

# drop schema schema_name ;

truncate table employee ;

# DML

alter table employee modify dno varchar(2) ;

alter table employee change super_ssn supervisor_ssn char(9) ;


alter table employee change sex gender varchar(6) ;


rename table deartment to department ;


alter table department add primary key (dnumber) ;

alter table employee add primary key (ssn);

alter table project add primary key (pnumber);

alter table dependent add primary key (essn, dependent_name) ;


alter table department add foreign key (mgr_ssn) references employee(ssn) ;





# DQL --> Data Query Language

# Select 'columns'

# From 'table'


# 1. Retrieve all rows and all columns of employee table.
select * from employee ;


# 2. Retrieve First name and last name of all employees.
select fname, lname from employee ;

select fname as 'First Name', lname as 'Last Name' from employee ;


# 3. Retrieve bdate and super_ssn of all employees using alias.
select bdate as Date_of_Birth , 
	   supervisor_ssn as Boss_SSN 
from employee ;


# 4. Retrieve details of all employees who draw salary at least 40000.
select *
from employee
where salary >= 40000 ;


# 5. Retrieve the relationships of all dependents of essn 333445555.
select essn, dependent_name, relationship
from dependent
where essn = 333445555 ;


# 6. Retrieve details of female employees who draw a salary at least 40000.
select *
from employee
where gender = 'f' and salary >= 40000;


# 7. Retrieve details of female employees or employees who drawing salary at least 40000.
select *
from employee
where gender = 'f' or salary >= 40000;


# 8. Display details of all (male employee who earn more than 40000) 
#	 or 
#    (female employees who earn less than 40000).
#    Hint: Pay attention to paranthesis.
select *
from employee
where (gender = 'M' and salary > 40000) or 
	  (gender = 'F' and salary < 40000) ;


# 9. Retrieve details of projects that are based at Houston or Stafford.

select *
from project
where plocation = 'Houston' or plocation = 'Stafford' ;


select *
from project 
where plocation in ('Houston', 'Stafford') ;


# 10. Retrieve details of projects that are NOT based at Houston nor Stafford.
select *
from project
where plocation != 'Houston' and plocation != 'Stafford' ;


select *
from project 
where plocation not in ('Houston', 'Stafford') ;


# 11. Display the essn of employees who have worked between 25 and 50 hours.

select essn, hours
from works_on
where hours >= 25 and hours <= 50 ;

select essn, hours
from works_on
where hours between 25 and 50 ;


# 12. Display employees whose first name begins with 'A'.

select *
from employee
where fname like 'A%' ;


# 13. Display names of all employees who live in Houston.
select fname, address
from employee
where address like '%Houston%' ; 


# 14. Display full names of all employees in one-go i.e. one single column.

select CONCAT(fname , ' ' , minit , ' ' , lname) as Name 
from employee ;


# Aggregate :- sum() , avg() , min() , max() , count()

# 15.a) Calculate total salary of employees.
# 15.b) Calculate average salary of employees.
# 15.c) Calculate minimum salary of employees.
# 15.d) Calculate maximum salary of employees.

select sum(salary) from employee ;


# 16. Find no. of employees in organization.
select count(ssn) from employee ;

select count(*) as no_of_employees from employee ;


# 17. Find no. of employees who have dependents.
select count(distinct essn)
from dependent;



# 18. Display the employee details who does not have supervisor.
select *
from employee
where supervisor_ssn is null ;


# 19. Display the ssn of manager and the year in which the manager was appointed.

select mgr_ssn, year(mgr_start_date) as mgr_start_year
from department ;


# 20. Display the ssn, fname and salaries of employees 
#	  sorted by their salary in descending mode.
select ssn, fname, salary
from employee
order by salary desc ;


# 21. Sort the works_on table based on Pno and Hours.
select * 
from works_on
order by pno , hours ;


# 22. Calculate average salary of employees department-wise.
select avg(salary) as avg_salary, dno
from employee 
group by dno
order by avg_salary desc ;


# 23. Display the number of male employees in each department.

select count(ssn) as no_of_males , dno
from employee
where gender = 'm'
group by dno ;


# 24. Among the people who draw at least 30000 salary, 
#	  what is the gender-wise average?
select gender, avg(salary)
from employee
where salary >= 30000
group by gender ;


# 25. Display the essn of employees who have worked between 25 and 50 hours.
select essn, sum(hours) as total_hrs
from works_on
group by essn
having total_hrs between 25 and 50 ;


# 26. Display the Dno of those departments those have at least 3 employees.

select dno, count(ssn) as no_of_emps
from employee
group by dno
having no_of_emps >= 3 ;


# 27. Display the fname and salary of employees 
#	  whose salary is more than the average salary of all the employees.

select fname, salary from employee
where salary >  (select avg(salary) from employee);




# 28. Display the fname of employees working in the Research department.

select fname 
from employee 
where dno = (select dnumber 
			 from department 
			 where dname = 'research');


select fname, dname
from employee join department on employee.dno = department.dnumber 
where dname = 'research';


# 29. Which department has the most number of employees?
select dno, num_emp
from (select dno, count(*) as num_emp from employee
	  group by dno) as abc
where num_emp = (select max(num_emp) 
				 from (select dno, count(*) as num_emp from employee
				 group by dno) as abc);


select dno, count(*) as num_emp
from employee
group by dno
order by num_emp desc
limit 1 ;


# 30. Print names of all employees working on Product 'Z'.

select concat(fname , ' ', minit , ' ', lname) as emp_name, dnum
from employee join project on employee.dno = project.dnum 
where pname='productz';


select *
from employee as e join works_on as w on e.ssn = w.essn
				   join project as p on p.pnumber = w.pno
where pname = 'productz'; 



# 31. Display all employees' full names along with their dependents' names.

select concat(fname, ' ', lname) as Emp_Name, 
	   dependent_name, relationship
from employee as e join dependent as d on e.ssn = d.essn;
        

select concat(fname, ' ', lname) as Emp_Name, 
	   dependent_name, relationship
from employee as e left join dependent as d on e.ssn = d.essn; 


select concat(fname, ' ', lname) as Emp_Name, 
		dependent_name, relationship
from  dependent as d right join employee as e on e.ssn = d.essn ; 


# 32. Display names of employees along with names of their supervisors.

select e1.fname as emp_name , e2.fname as sup_name
from employee as e1 join employee as e2 on e1.supervisor_ssn = e2.ssn ;


# 33. What is average salary of those employees who have at least one dependent?

select e.ssn, avg(salary)
from employee as e right join dependent as d on e.ssn = d.essn
group by e.ssn ;


select round(avg(salary), 2) as avg_sal_emp_with_dep
from
(select avg(e.salary) as salary, d.essn as employee
 from employee e right join dependent d on d.essn = e.ssn
 group by d.essn) as ABC ;


# 34. Print max. salary of female employees and
#	  min. salary of male employee.

select max(salary) as salary, gender from employee where gender='f'
union
select min(salary), gender from employee where gender='m';


# 35. Which department has the most number of employees?

create view dep_view as select count(*) as no_of_employees, dno 
from employee group by dno;


select no_of_employees, dno 
from dep_view
where no_of_employees = (select max(no_of_employees) from dep_view);


# 36. Create a view which contains each project's names and total hours work done on it.
create view project_hrs as
select pname, sum(hours)
from works_on as w join project as p 
     on w.pno = p.pnumber
  group by p.pnumber;


# Unique Index
alter table dependent add unique index sl_no (essn, dependent_name); 


# 37. Update missing supervisor ssn by suitable title.
update employee set supervisor_ssn = 'MD' where supervisor_ssn is null;


# 38. Jennifer got promoted! Update her salary as 50K.
update employee set salary = 50000 where fname = 'Jennifer';

