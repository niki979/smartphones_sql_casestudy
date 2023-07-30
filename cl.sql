use smartphone;
SET SQL_SAFE_UPDATES = 0;

select * from scraped;

ALTER TABLE scraped
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


-- drop the first column
alter table scraped drop column MyUnknownColumn;
select * from scraped;

-- remove symbol from price column
update scraped set price=replace(price,'?','');
select * from scraped;

-- remove , from price column
update scraped set price=replace(price,',','');
select * from scraped;

-- change datatype of price to int 
alter table scraped modify column price int;
desc scraped;

-- find null values
select * from scraped where name = '' or price = '' or score = '' or sim = '' or processor = '' or ram = '' or battery = '' or display = '' or camera = '' or card = '' or os = '';

-- remove columns with null values
delete from scraped where name = '' or price = '' or score = '' or sim = '' or processor = '' or ram = '' or battery = '' or display = '' or camera = '' or card = '' or os = ''  ;

-- remove symbol from processor column
update scraped set processor=replace(processor,'?',' ');
select * from scraped;

-- remove symbol from ram column
update scraped set ram=replace(ram,'?',' ');
select * from scraped;

-- remove symbol from battery column
update scraped set battery=replace(battery,'?',' ');
select * from scraped;

-- remove symbol from display column
update scraped set display=replace(display,'?',' ');
select * from scraped;

-- remove symbol from camera column
update scraped set camera=replace(camera,'?',' ');
select * from scraped;

-- remove symbol from card column
update scraped set card=replace(card,'?',' ');
select * from scraped;

-- find incorrect data from processor column

select id,processor from scraped where processor not like '%Processor%' and processor not like '%Helio%' and processor not like '%Snapdragon%' and processor not like '%Bionic%' and processor not like '%Unisoc%';

-- delete rows that contain incorrect processor data
create temporary table temp as select id,processor from scraped where processor not like '%Processor%' and processor not like '%Helio%' and processor not like '%Snapdragon%' and processor not like '%Bionic%' and processor not like '%Unisoc%';

delete from scraped where id in (select id from temp);

drop temporary table temp;

-- find incorrect data in ram
select ram from scraped where ram not like '%RAM%';

-- delete rows with incorrect ram
create temporary table temp as select ram,id from scraped where ram not like '%RAM%';

delete from scraped where id in (select id from temp);

drop temporary table temp;

-- find incorrect battery values
select id,battery from scraped where battery not like '%Battery%';

-- delete incorrect values
create temporary table temp as select id,battery from scraped where battery not like '%Battery%';
delete from scraped where id in (select id from temp);
drop temporary table temp;

-- find incorrect display values
select id,display from scraped where display not like '%Display%';

-- find incorrect camera values
select id,camera from scraped where camera not like '%MP%';

-- delete incorrect values
create temporary table temp as select id,camera from scraped where camera not like '%MP%';
delete from scraped where id in (select id from temp);
drop temporary table temp;

select * from scraped;
-- values in card
select card,count(*) from scraped group by card;

-- if card details are not present , it should move to the next column os
create temporary table temp as select id,card from scraped where card not like '%Memory%';
select * from temp;

update scraped t1 join temp t2 on t1.id=t2.id 
set t1.os=t2.card;

drop temporary table temp;

-- replace incorrect values in card column with 'Memory Card Not Supported'
update scraped set card='Memory Card Not Supported' where card not like '%Memory%';

select card,count(*) from scraped group by card;

-- os column
select os,count(*) from scraped group by os;

delete from scraped where os='Bluetooth';

select * from scraped;










