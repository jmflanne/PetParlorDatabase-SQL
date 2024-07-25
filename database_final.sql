--Name: Jenna Flannery
-- Final Database Project


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
    insert into NUM_OF_BOOKINGS values (99, current_date);
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


