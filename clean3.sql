show create table scraped;
CREATE TABLE `smartphones` (
`id` int NOT NULL AUTO_INCREMENT,
   `name` text,
   `brand` text,
   `price` int DEFAULT NULL,
   `score` int DEFAULT NULL,
   `os` text,
   `sim` text,
   `has_5g` tinyint(1) DEFAULT NULL,
   `has_nfc` tinyint(1) DEFAULT NULL,
   `has_ir_blaster` tinyint(1) DEFAULT NULL,
   `processor_brand` text,
   `num_core` text,
   `processor_speed` text,
   `ram_capacity` int DEFAULT NULL,
   `internal_memory` int DEFAULT NULL,
   `battery_capacity` int DEFAULT NULL,
   `has_fast_charging` tinyint(1) DEFAULT '0',
   `fast_charging` int DEFAULT NULL,
   `screen_size` float DEFAULT NULL,
   `refresh_rate` int DEFAULT NULL,
   `resolution` text,
   `rear_num` int DEFAULT NULL,
   `primary_camera_rear` int DEFAULT NULL,
   `primary_camera_front` int DEFAULT NULL,
   `extended_memory_available` tinyint(1) DEFAULT NULL,
   `extended_memory` int DEFAULT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=1021 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 insert into smartphones (id,name,brand,price,score,os,sim,has_5g,has_nfc,has_ir_blaster,processor_brand,num_core,processor_speed,ram_capacity,internal_memory,battery_capacity,has_fast_charging,fast_charging,screen_size,refresh_rate,resolution,rear_num,primary_camera_rear,primary_camera_front,extended_memory_available,extended_memory)
 select id,name,brand,price,score,os,sim,has_5g,has_nfc,has_ir_blaster,processor_brand,num_core,processor_speed,ram_capacity,internal_memory,battery_capacity,has_fast_charging,fast_charging,screen_size,refresh_rate,resolution,rear_num,primary_camera_rear,primary_camera_front,extended_memory_available,extended_memory from scraped;
 
 select * from smartphones;
 





