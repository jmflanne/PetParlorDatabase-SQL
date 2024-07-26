--Name: Jenna Flannery
-- Final Database Project

--creation of database:
create table BREED (
breedName char(25) Primary Key,
coatType char(7),
breedSize char(5),
speciesName char(3)
);

create table Service (
serviceType int Primary Key,
cost dec(4,2) not null,
bath char(1) not null,
nailTrim char(1) not null,
deshedding char(1) not null
);

create table Appointment (
appointmentID number(10) Primary Key,
apptDate date not null,
pickup int not null,
dropoff int not null
);


create table PETOWNER (
petOwnerID number(10) Primary Key,
firstName char(10) not null,
lastName char(15) not null,
phoneNumber char(10) unique
);


create table HOURLYPAY (
paymentID number(10) Primary Key,
wage dec(4,2) not null,
payPeriod int not null,
lastPaymentDate date
);

create table SALARY (
salaryID number(10) Primary Key,
salary int not null,
payPeriod int not null,
lastPaymentDate date
);

create table STORE (
storeID number(10) Primary Key,
location char(20) not null,
open int,
close int,
phoneNumber char(10) unique
);

create table MANAGER (
managerID number(10) Primary Key,
firstName char(10) not null,
lastName char(15) not null,
salaryID number(10),
storeID number(10),
CONSTRAINT salaryIDFK FOREIGN KEY (salaryID) REFERENCES salary(salaryID),
CONSTRAINT storeIDFK FOREIGN KEY (storeID) REFERENCES store(storeID)
);

create table EMPLOYEE (
employeeID number(10) Primary Key,
firstName char(10) not null,
lastName char(15) not null,
hours int,
paymentID number(10),
managerID number(10),
CONSTRAINT managerIDFK FOREIGN KEY (managerID) REFERENCES manager(managerID),
CONSTRAINT paymentIDFK FOREIGN KEY (paymentID) REFERENCES hourlypay(paymentID)
);

create table PET (
petID number(10) Primary Key,
petOwnerID number(10),
petName char(15) not null,
serviceType int,
employeeID number(10),
appointmentID number(10),
breedName char(25),
CONSTRAINT petOwnerIDFK FOREIGN KEY (petOwnerID) REFERENCES petowner(petOwnerID),
CONSTRAINT serviceTypeFK FOREIGN KEY (serviceType) REFERENCES service(serviceType),
CONSTRAINT employeeIDFK FOREIGN KEY (employeeID) REFERENCES employee(employeeID),
CONSTRAINT appointmentIDFK FOREIGN KEY (appointmentID) REFERENCES appointment(appointmentID),
CONSTRAINT breedNameFK FOREIGN KEY (breedName) REFERENCES breed(breedName)
);



CREATE SEQUENCE apptSequence
start with 0000000001
increment by 1;

insert into APPOINTMENT values (apptSequence.nextval,'08-APR-24',2000,1800);
insert into APPOINTMENT values(apptSequence.nextval,'31-MAR-24',1800,1600);
insert into APPOINTMENT values(apptSequence.nextval,'05-MAR-24',1800,1500);
insert into APPOINTMENT values(apptSequence.nextval,'14-MAR-24',1600,1400);
insert into APPOINTMENT values(apptSequence.nextval,'04-MAR-24',1200,1000);
insert into APPOINTMENT values(apptSequence.nextval,'08-APR-24',1600,1400);
insert into APPOINTMENT values(apptSequence.nextval,'07-APR-24',1300,1000);

insert into BREED values ('samoyed','double','large','dog');
insert into BREED values ('dachshund','hair','small','dog');
insert into BREED values ('golden retriever','hair','large','dog');
insert into BREED values ('pug','fur','small','dog');
insert into BREED values ('golden doodle','hair','large','dog');
insert into BREED values ('boxer','fur','large','dog');
insert into BREED values ('siberian husky','double','large','dog');
insert into BREED values ('shiba inu','double','small','dog');
insert into BREED values ('miniature shnnauzer','hair','small','dog');
insert into BREED values ('persian','long','small','cat');
insert into BREED values ('exotic shorthair','short','small','cat');
insert into BREED values ('ragamuffin','long','small','cat');
insert into BREED values ('british shorthair','short','small','cat');

CREATE SEQUENCE storeSequence
start with 0000000001
increment by 1;

insert into STORE values (storeSequence.nextval,'Westfield',1000,2100,'3177777777');
insert into STORE values (storeSequence.nextval,'Noblesville',900,2000,'3175555555');
insert into STORE values (storeSequence.nextval,'Indianapolis',1000,2100,'3174444444');

CREATE SEQUENCE paySequence
start with 0000000001
increment by 1;

insert into HOURLYPAY values (paySequence.nextval, 22.00, 14, '25-FEB-24');
insert into HOURLYPAY values (paySequence.nextval, 21.00, 14, '11-FEB-24');
insert into HOURLYPAY values (paySequence.nextval, 22.00, 14, '11-FEB-24');

CREATE SEQUENCE salarySequence
start with 0000000001
increment by 1;

insert into SALARY values (salarySequence.nextval, 60000, 14, '11-FEB-24');
insert into SALARY values (salarySequence.nextval, 65000, 30, '11-FEB-24');
insert into SALARY values (salarySequence.nextval, 60000, 14, '25-FEB-24');


CREATE SEQUENCE managerSequence
start with 0000000001
increment by 1;

insert into MANAGER values (managerSequence.nextval, 'mark','jacobson',2,1);
insert into MANAGER values (managerSequence.nextval, 'mike','clark',1,2);
insert into MANAGER values (managerSequence.nextval, 'anna','kelly',3,3);


CREATE SEQUENCE employeeSequence
start with 0000000001
increment by 1;

insert into EMPLOYEE values (employeeSequence.nextval,'jenna','flannery',20,1,1);
insert into EMPLOYEE values (employeeSequence.nextval,'jane','doe',22,3,1);
insert into EMPLOYEE values (employeeSequence.nextval,'james','lee',24,3,1);
insert into EMPLOYEE values (employeeSequence.nextval,'william','bates',25,3,1);
insert into EMPLOYEE values (employeeSequence.nextval,'carly','jones',20,2,2);
insert into EMPLOYEE values (employeeSequence.nextval,'noah','williams',23,2,2);
insert into EMPLOYEE values (employeeSequence.nextval,'meghan','alexander',32,1,2);
insert into EMPLOYEE values (employeeSequence.nextval,'lucas','harper',null,null,null);
insert into EMPLOYEE values (employeeSequence.nextval,'james','henry',0,1,3);
insert into EMPLOYEE values (employeeSequence.nextval,'liam','jackson',30,3,3);
insert into EMPLOYEE values (employeeSequence.nextval,'ben','oliver',21,1,3);


CREATE SEQUENCE petOwnerSequence
start with 0000000001
increment by 1;

insert into PETOWNER values (petOwnerSequence.nextval, 'loretta','sanders','3178000000');
insert into PETOWNER values (petOwnerSequence.nextval, 'kitty','oneal','3179000000');
insert into PETOWNER values (petOwnerSequence.nextval, 'josue','armstrong','3176000000');
insert into PETOWNER values (petOwnerSequence.nextval, 'cathy','hunters','3178080000');
insert into PETOWNER values (petOwnerSequence.nextval, 'louis','potter','3178007000');
insert into PETOWNER values (petOwnerSequence.nextval, 'ronda','hurley','3178000500');


insert into SERVICE values (1, 75, 'Y','Y','Y');
insert into SERVICE values (2, 30, 'Y','N','N');
insert into SERVICE values (3, 60, 'Y','N','Y');
insert into SERVICE values (4, 20, 'N','Y','N');

CREATE SEQUENCE petIDSequence
start with 0000000001
increment by 1;

insert into PET values (petIDSequence.nextval, 1, 'lesley', 1, 1, 1, 'samoyed');
insert into PET values (petIDSequence.nextval, 2, 'moon', 1, 4, 2, 'dachshund');
insert into PET values (petIDSequence.nextval, 3, 'dolly', 2, 5, 3, 'siberian husky');
insert into PET values (petIDSequence.nextval, 4, 'araceli', 2, 6, 4, 'british shorthair');
insert into PET values (petIDSequence.nextval, 5, 'micah', 3, 7, 5, 'persian');
insert into PET values (petIDSequence.nextval, 6, 'marina', 1, 10, 6, 'golden doodle');
insert into PET values (petIDSequence.nextval, 1, 'wilfred', 1, 11, 7, 'pug');


--start of final project
--Req 1: use variables, Req 2: if statements, Req 4: exception handling, Req 6: function
--This will be used to create messages about appoitnments that can be send to customers
create TABLE MESSAGES
(
firstName char(10),
lastName char (15),
phoneNumber char(10),
message char(200)
);

drop table MESSAGES;
create or replace function create_message(aName IN varchar2,apptDate IN date)
return varchar2 is
message varchar2(200);
current_date date;
past_date exception;
BEGIN
select trunc(current_date) into current_date  from dual;
if (apptDate < current_date) then
    raise past_date;
else
    message := 'Hello ' || aName || '! This is a reminder that your appointment is on ' || apptDate || '. Please call or text us with any questions.';
    return message;
end if;
exception 
    when past_date then 
    if ((current_date - apptDate) > 60) then
        message := 'Hello ' || aName || '! It looks like it has been awhile since your last appointment. Call or email us anytime to schedule your next one.';
    else
        message := 'none';
    end if;
    return message;
END;
/


--Req 1: loops, Req 3: cursors, Req 7: stored procedure
create or replace procedure all_messages authid current_user
is
owner_name varchar(10);
owner_last varchar(15);
phone_num varchar(10);
appt_date date;
message varchar(200);
cursor pet_cursor is
    select * from PET;
pet_info pet_cursor%ROWTYPE;
BEGIN
for pet_info in pet_cursor
loop
    select firstName into owner_name from PETOWNER where petOwnerID = pet_info.petOwnerID;
    select lastName into owner_last from PETOWNER where petOwnerID = pet_info.petOwnerID;
    select phoneNumber into phone_num from PETOWNER where petOwnerID = pet_info.petOwnerID;
    select apptDate into appt_date from APPOINTMENT where appointmentID = pet_info.appointmentID;
    message := create_message(owner_name,appt_date);
    insert into MESSAGES values (owner_name,owner_last,phone_num, message);
end loop;
END;
/
-- has appt ID 32
insert into APPOINTMENT values(apptSequence.nextval,'31-MAY-24',1300,1000);
insert into PET values (petIDSequence.nextval, 2, 'test', 1, 1, 32, 'dachshund');

execute all_messages;
select * from PETOWNER;
select * from PET;
select * from APPOINTMENT;
select * from MESSAGES;


--Req 4: exception handling, Req 5: trigger
--keep track of previous employees
create table PREV_EMPLOYEE (
firstName char(10) not null,
lastName char(15) not null,
storeID number(10)
);

drop table PREV_EMPLOYEE;

create or replace trigger EMPLOYEE_DELETE
after delete on EMPLOYEE
for each row
declare
store_ID number(10);
begin
select storeID into store_ID from MANAGER where managerID = :old.managerID;
insert into PREV_EMPLOYEE values (:old.firstName, :old.lastName, store_ID);
exception
when NO_DATA_FOUND then
    store_ID := 0;
    insert into PREV_EMPLOYEE values (:old.firstName, :old.lastName, store_ID);
end;
/

select * from employee;
insert into EMPLOYEE values (employeeSequence.nextval,'test','test',20,1,1);
delete from EMPLOYEE where firstName = 'test';
select * from PREV_EMPLOYEE;
insert into EMPLOYEE values (employeeSequence.nextval,'test2','test2',20,1,null);
delete from EMPLOYEE where firstName = 'test2';

--Req 6: function
create or replace function num_appts(appt_date date)
return NUMBER is
num_appt NUMBER(2);
BEGIN
select count(*) into num_appt from APPOINTMENT where apptDate = appt_date;
return num_appt;
END;
/

select * from appointment;
select (num_appts('08-APR-24')) from APPOINTMENT;

--Req 7: stored procedure
create table NUM_OF_BOOKINGS(
numOfAppts number(2),
apptDate date
);

drop table NUM_OF_BOOKINGS;

declare 
num_appts varchar(2);
appt_date date;
count_date NUMBER(2);
cursor appt_cursor is
    select * from APPOINTMENT;
appt_info appt_cursor%ROWTYPE;
BEGIN
for appt_info in appt_cursor
loop
    appt_date := appt_info.apptDate;
    num_appts := APPT_CHECK.num_appts(appt_date);
    select count(*) into count_date from NUM_OF_BOOKINGS where apptDate = appt_date;
if (count_date != 0) then
    continue;
else 
    insert into NUM_OF_BOOKINGS values (num_appts,appt_date);
end if;
end loop;
END;
/

select * from NUM_OF_BOOKINGS;

create or replace procedure NUM_OF_BOOKINGS_MANAGEMENT authid current_user
is
current_date date;
num_current_date number(2);
BEGIN
select TRUNC(CURRENT_DATE) into current_date from dual;
select count(*) into num_current_date from NUM_OF_BOOKINGS where apptDate = current_date;
if (num_current_date) = 0 then
    insert into NUM_OF_BOOKINGS values (99, current_date);
end if;
END;
/

select * from NUM_OF_BOOKINGS;
execute NUM_OF_BOOKINGS_MANAGEMENT;
DELETE FROM NUM_OF_BOOKINGS where numofAppts = 0;

--Req 6: function, Req 7: stored procedure, Req 8: create package
--keep track of the number of appointments scheduled each day
create or replace package APPT_CHECK
as
function num_appts(appt_date date)return NUMBER;
procedure NUM_OF_BOOKINGS_MANAGEMENT;
end APPT_CHECK;
/

create or replace package body APPT_CHECK as 
function num_appts(appt_date date)
return NUMBER is
num_appt NUMBER(2);
BEGIN
select count(*) into num_appt from APPOINTMENT where apptDate = appt_date;
return num_appt;
END num_appts;

procedure NUM_OF_BOOKINGS_MANAGEMENT
is
current_date date;
num_current_date number(2);
BEGIN
select TRUNC(CURRENT_DATE) into current_date from dual;
select count(*) into num_current_date from NUM_OF_BOOKINGS where apptDate = current_date;
if (num_current_date) = 0 then
    insert into NUM_OF_BOOKINGS values (0, current_date);
end if;
END NUM_OF_BOOKINGS_MANAGEMENT;

END APPT_CHECK;
/

select * from appointment;
select (APPT_CHECK.num_appts('08-APR-24')) from APPOINTMENT;

select * from NUM_OF_BOOKINGS;
execute APPT_CHECK.NUM_OF_BOOKINGS_MANAGEMENT;
DELETE FROM NUM_OF_BOOKINGS where numofAppts = 0;


-- Req 5: trigger
--update NUM_OF_BOOKINGS when appointment inserted into APPOINTMENT table
create or replace trigger APPTS_INSERT
after insert on APPOINTMENT
for each row
declare
appt_date date;
prev_num_of_appts NUMBER(2);
begin
appt_date := :new.apptDate;
select (numOfAppts)into prev_num_of_appts from NUM_OF_BOOKINGS where apptDate = appt_date;
update NUM_OF_BOOKINGS set numOfAppts = (prev_num_of_appts + 1) where apptDate = appt_date;
exception
when NO_DATA_FOUND then
    insert into NUM_OF_BOOKINGS values (1, appt_date);
end;
/

select * from APPOINTMENT;
insert into APPOINTMENT values(apptSequence.nextval,'24-APR-24',1300,1000);
select * from NUM_OF_BOOKINGS;

--Req 9: create database object
--keep track of orders for each store and what is in those orders
create type PART_TY as object
(
supplierID NUMBER(10),
part varchar(15),
qty number(2)
);
/

drop type PART_TY;

create type PARTS_NT as table of PART_TY;
/
drop type PARTS_NT;
create table ORDERS
(
orderID NUMBER(10),
items PARTS_NT)
nested table items store as PARTS_NT_TAB;

CREATE SEQUENCE orderSequence
start with 1
increment by 1;

CREATE SEQUENCE supplierSequence
start with 1
increment by 1;

insert into ORDERS values (orderSequence.nextval, PARTS_NT(
    PART_TY(supplierSequence.nextval,'scissors',2),
    PART_TY(supplierSequence.nextval,'shampoo',4),
    PART_TY(supplierSequence.nextval,'clippers',1)
));

insert into ORDERS values (orderSequence.nextval, PARTS_NT(
    PART_TY(supplierSequence.nextval,'paper',50),
    PART_TY(1,'shampoo',4)
));
drop table ORDERS;
drop sequence orderSequence;
drop sequence supplierSequence;
select orderID, N.* from ORDERS, TABLE(items)N;


