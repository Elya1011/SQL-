CREATE TABLE IF NOT EXISTS department (
	id SERIAL PRIMARY KEY, 
	name varchar(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS boss_table (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(60) NOT NULL,
	last_name VARCHAR(60) NOT NULL,
	department_id INTEGER NOT NULL REFERENCES department(id)
);


create table if not exists employee (
	first_name VARCHAR(60) NOT NULL,
	last_name VARCHAR(60) NOT NULL,
	department_id INTEGER NOT NULL REFERENCES department(id),
	boss_id INTEGER NOT NULL REFERENCES boss_table(id)
);
	