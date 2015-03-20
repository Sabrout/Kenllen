CREATE TABLE users(
user_id SERIAL PRIMARY KEY ,
fname varchar(255) ,
lname varchar(255) ,
uname varchar(255) ,
password_digest varchar(255),
remember_digest varchar,
phone integer ,
email varchar(255) ,
address varchar,
reports INTEGER DEFAULT 0,
CHECK (phone>0)
);

CREATE TABLE report_user(
accused_id SERIAL REFERENCES users(user_id)  ON UPDATE CASCADE ON DELETE CASCADE,
user_id SERIAL REFERENCES users(user_id)  ON UPDATE CASCADE ON DELETE CASCADE,
report_type varchar(255),
PRIMARY KEY(accused_id,user_id)
);

CREATE TABLE report_art(
art_id SERIAL REFERENCES users(user_id)  ON UPDATE CASCADE ON DELETE CASCADE,
user_id SERIAL REFERENCES users(user_id)  ON UPDATE CASCADE ON DELETE CASCADE,
report_type varchar(255),
PRIMARY KEY(art_id,user_id)
);

CREATE TABLE admins(
admin_id SERIAL PRIMARY KEY ,
uname varchar(255) ,
password_digest varchar(255) ,
email varchar(255)
);

CREATE TABLE shops(
shop_id SERIAL PRIMARY KEY ,
shop_name char(50) ,
shop_desc varchar(255)
);

CREATE TABLE arts(
art_id SERIAL PRIMARY KEY ,
art_name varchar(255) ,
shop_id SERIAL REFERENCES shops(shop_id) ON UPDATE CASCADE ON DELETE CASCADE,
price money NOT NULL ,
art_desc varchar(255) ,
insp char(30) ,
category varchar(255)
);
CREATE TABLE art_images(
art_id SERIAL REFERENCES arts(art_id) ON UPDATE CASCADE ON DELETE CASCADE ,
image_id SERIAL ,
PRIMARY KEY(art_id,image_id)
);

CREATE TABLE bought_art(
buyer_id SERIAL REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
art_id SERIAL REFERENCES arts(art_id) ON UPDATE CASCADE ON DELETE CASCADE ,
PRIMARY KEY(buyer_id,art_id)
);


CREATE TABLE comment_art(
comment_id SERIAL ,
user_id SERIAL REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
art_id SERIAL REFERENCES arts(art_id) ON UPDATE CASCADE ON DELETE CASCADE,
content text ,
time_stamp timestamp ,
PRIMARY KEY(comment_id,user_id)
);

CREATE TABLE rate_art(
art_id SERIAL REFERENCES arts(art_id) ON UPDATE CASCADE ON DELETE CASCADE,
user_id SERIAL REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
value integer DEFAULT 0 ,
PRIMARY KEY(user_id,art_id) ,
CHECK (value>=0 AND value<=5)
);
