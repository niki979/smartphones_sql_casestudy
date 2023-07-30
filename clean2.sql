-- further prepossing of data for better analysis
select * from scraped;

-- add column brand
alter table scraped add column brand text;

update scraped set brand=substring_index(name,' ',1);

-- add columns has_5g, has_nfc and has_ir_blaster from sim
alter table scraped add column has_5g boolean, 
add column has_nfc boolean,
add column has_ir_blaster boolean;

update scraped 
set has_5g=
case 
when sim like '%5G%' then true
else false
end;

update scraped 
set has_nfc=
case 
when sim like '%NFC%' then true
else false
end;

update scraped 
set has_ir_blaster=
case 
when sim like '%IR%' then true
else false
end;

-- split processor column
alter table scraped
add column processor_brand text,
add column num_core text,
add column processor_speed text;

update scraped set processor_brand=substring_index(processor,' ',1);


update scraped set num_core=
case
when processor like '%GHz%' then substring_index(substring_index(processor,', ',-2),' Core',1)
when processor like '%Core%' then substring_index(substring_index(processor,', ',-1),' Core',1)
else ''
end;

select num_core,count(*) from scraped group by num_core;

update scraped set num_core=
case
when num_core='Octa' then 8
when num_core='Hexa' then 6
when num_core='Quad' then 4
when num_core='Dual' then 2
when num_core='Deca' then 10
else NULL
end;


update scraped set processor_speed=
case
when processor like '%GHz%' then substring_index(substring_index(processor,', ',-1),' GHz',1)
else ''
end;

select processor,processor_speed from scraped;

-- ram column
alter table scraped add column ram_capacity int, add column internal_memory int;

update scraped set ram_capacity = substring_index(ram, ' ',1);

select ram_capacity,count(*) from scraped group by ram_capacity;

delete from scraped where ram like '%MB%';

update scraped set internal_memory=substring_index(substring_index(ram,', ',-1),' ',1);

select internal_memory,count(*) from scraped group by internal_memory;

update scraped set internal_memory=1024 where internal_memory=1;


-- battery column

alter table scraped add column battery_capacity int, add column has_fast_charging boolean, add column fast_charging int;

update scraped set battery_capacity=substring_index(battery,' ',1);

alter table scraped modify column has_fast_charging boolean default false;

update scraped set has_fast_charging=
case when battery like '%Fast Charging%' then true
else false
end;

update scraped set fast_charging=
case
when battery like binary '%W%' then substring_index(substring_index(battery,'W',1),'with ',-1)
else null
end;

-- display
alter table scraped add column screen_size float, add column refresh_rate int, add column resolution text;

update scraped set screen_size=substring_index(display,' ',1);

update scraped set refresh_rate=
case
when display like '%Hz%' then substring_index(substring_index(display,'Hz',1),', ',-1)
else null
end;

update scraped set resolution=substring_index(substring_index(display,'inches, ',-1),' px',1);


-- os 
update scraped set os=substring_index(os,' ',1);

-- camera

alter table scraped add column rear_num int, add column primary_camera_rear int,add column primary_camera_front int;

update scraped set rear_num=
case 
when substring_index(substring_index(camera,' Rear',1),' ',-1)='Triple' then 3
when substring_index(substring_index(camera,' Rear',1),' ',-1)='Dual' then 2
when substring_index(substring_index(camera,' Rear',1),' ',-1)='Quad' then 4
when substring_index(substring_index(camera,' Rear',1),' ',-1)='Penta' then 5

else 1
end;


update scraped set primary_camera_rear=substring_index(camera,' ',1);


update scraped set primary_camera_front=substring_index(substring_index(camera,'& ',-1),' ',1);


-- card 
alter table scraped add column extended_memory_available boolean,add column extended_memory int;

update scraped set extended_memory_available=
case 
when card like '%Not Supported%' then false
else true
end;

-- substring_index(substring_index(card,'upto ',-1),' ',1)


update scraped set extended_memory=
case
when card like '%upto%' then 
case 
when substring_index(substring_index(card,'upto ',-1),' ',1)=1 then 1024
when substring_index(substring_index(card,'upto ',-1),' ',1)=2 then 2048
else substring_index(substring_index(card,'upto ',-1),' ',1)
end
else null
end;


select card,extended_memory_available,extended_memory from scraped;

desc scraped;

alter table scraped
drop column processor,
drop column battery,
drop column ram,
drop column display,
drop column camera,
drop column card;













