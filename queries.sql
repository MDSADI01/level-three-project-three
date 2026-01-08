create table users (
  user_id serial primary key,
  name varchar(150) not null,
  email varchar(100) not null,
  phone varchar(15) not null,
  role varchar(20) not null check (role in ('Admin','Customer')) 
  
)



create table vehicles (
  vehicle_id serial primary key,
  name varchar(150) not null,
  type varchar(20)  not null check (type in ('bike','car','truck')),
  model int not null,
  registration_number varchar(20) unique not null,
  rental_price numeric(10,2) not null,
  status varchar(50) not null check (status in ('available', 'rented', 'maintenance'))
)

  

create table bookings (
  booking_id serial primary key,
  user_id int not null references users(user_id) on delete cascade,
  vehicle_id int not null references vehicles(vehicle_id) on delete cascade,
  start_date date not null,
  end_date date not null,
  status varchar(20) not null check (status in ('pending', 'confirmed', 'completed', 'cancelled')),
  total_cost numeric(10,2) not null
)








select 
  b.booking_id, 
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
  from bookings as b 
join users u on b.user_id = u.user_id 
join vehicles as v on b.vehicle_id = v.vehicle_id
where u.role = 'Customer' order by b.booking_id




select
    *
from vehicles as v
where not exists (
    select 1
    from bookings as b
    where b.vehicle_id = v.vehicle_id
);



select * from vehicles as v
where v.type = 'car'


select v.name as vehicle_name,count(b.booking_id) as total_bookings
from vehicles as v
  join bookings as b on v.vehicle_id = b.vehicle_id
group by v.name
having count(b.booking_id) > 2 


