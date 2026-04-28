ALTER TABLE Shift_work DROP CONSTRAINT IF EXISTS fk_type_shift;
ALTER TABLE Salon DROP CONSTRAINT IF EXISTS fk_salon_city;
ALTER TABLE Salon_owner DROP CONSTRAINT IF EXISTS fk_owner;
ALTER TABLE Salon_owner DROP CONSTRAINT IF EXISTS fk_salon;
ALTER TABLE Staff DROP CONSTRAINT IF EXISTS fk_staff_salon;
ALTER TABLE Staff DROP CONSTRAINT IF EXISTS fk_staff_type;
ALTER TABLE Staff DROP CONSTRAINT IF EXISTS fk_shift_work;
ALTER TABLE Master DROP CONSTRAINT IF EXISTS fk_master_salon;
ALTER TABLE Master DROP CONSTRAINT IF EXISTS fk_shift_work_;
ALTER TABLE Service_Salon DROP CONSTRAINT IF EXISTS fk_salon;
ALTER TABLE Service DROP CONSTRAINT IF EXISTS fk_type_service;
ALTER TABLE Service_Salon DROP CONSTRAINT IF EXISTS fk_service;
ALTER TABLE Master_Service DROP CONSTRAINT IF EXISTS fk_seice_mas;
ALTER TABLE Master_Service DROP CONSTRAINT IF EXISTS fk_master;
ALTER TABLE Master_Service_Client DROP CONSTRAINT IF EXISTS fk_msc;
ALTER TABLE Master_Service_Client DROP CONSTRAINT IF EXISTS fk_rclient;
ALTER TABLE Master_Service_Client DROP CONSTRAINT IF EXISTS fk_sclient;
ALTER TABLE Master_Service_Client DROP CONSTRAINT IF EXISTS fk_service;
ALTER TABLE Card DROP CONSTRAINT IF EXISTS fk_card_bank;
ALTER TABLE Discount DROP CONSTRAINT IF EXISTS fk_type_disc;
ALTER TABLE Regular_client DROP CONSTRAINT IF EXISTS fk_reg_disc;
ALTER TABLE Supply_materials DROP CONSTRAINT IF EXISTS fk_sup_un;
ALTER TABLE Materials DROP CONSTRAINT IF EXISTS fk_mat_sal;
ALTER TABLE Materials DROP CONSTRAINT IF EXISTS fk_mat_sup;
ALTER TABLE Materials DROP CONSTRAINT IF EXISTS fk_matc_type;
ALTER TABLE Material_Consuption DROP CONSTRAINT IF EXISTS fk_mat_serv;
ALTER TABLE Material_Consuption DROP CONSTRAINT IF EXISTS fk_master_serv;
ALTER TABLE Material_Consuption DROP CONSTRAINT IF EXISTS fk_mat_un;
ALTER TABLE Material_Consuption DROP CONSTRAINT IF EXISTS fk_matc_mat;
ALTER TABLE Tools DROP CONSTRAINT IF EXISTS fk_sup_tool;
ALTER TABLE Tools DROP CONSTRAINT IF EXISTS fk_sal_tool;
ALTER TABLE Supplier DROP CONSTRAINT IF EXISTS fk_com;
ALTER TABLE Supplier DROP CONSTRAINT IF EXISTS fk_city_;
ALTER TABLE Supplier DROP CONSTRAINT IF EXISTS fk_pay;
ALTER TABLE Supplier DROP CONSTRAINT IF EXISTS fk_salon;
ALTER TABLE Promo_Service DROP CONSTRAINT IF EXISTS fk_promo_disc;
ALTER TABLE Promo_Service DROP CONSTRAINT IF EXISTS fk_promotion;
ALTER TABLE Promo_Service DROP CONSTRAINT IF EXISTS fk_service;
ALTER TABLE Payment DROP CONSTRAINT IF EXISTS fk_type_pay;


DROP TABLE IF EXISTS Shift_work;
DROP TABLE IF EXISTS Type_shift;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Salon ;
DROP TABLE IF EXISTS Owner_;
DROP TABLE IF EXISTS Salon_owner ;
DROP TABLE IF EXISTS Type_staff ;
DROP TABLE IF EXISTS Staff ;
DROP TABLE IF EXISTS Master ;
DROP TABLE IF EXISTS Type_service;
DROP TABLE IF EXISTS Service ;
DROP TABLE IF EXISTS Service_Salon ;
DROP TABLE IF EXISTS Master_Service;
DROP TABLE IF EXISTS Simple_client;
DROP TABLE IF EXISTS Regular_client;
DROP TABLE IF EXISTS Master_Service_Client CASCADE;
DROP TABLE IF EXISTS Type_payment;
DROP TABLE IF EXISTS Cash;
DROP TABLE IF EXISTS Bank ;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS Payment  ;
DROP TABLE IF EXISTS Discount ;
DROP TABLE IF EXISTS Type_discount ;
DROP TABLE IF EXISTS Promotion ;
DROP TABLE IF EXISTS Promo_Service ;
DROP TABLE IF EXISTS Units_measure;
DROP TABLE IF EXISTS Type_material;
DROP TABLE IF EXISTS Supply_materials;
DROP TABLE IF EXISTS Materials;
DROP TABLE IF EXISTS Material_Consuption ;
DROP TABLE IF EXISTS Tools ;
DROP TABLE IF EXISTS Supply_tools ;
DROP TABLE IF EXISTS Company ;
DROP TABLE IF EXISTS Supplier ;


CREATE TABLE Shift_work (
    id_shift SERIAL ,
	start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
	FK_type_shift INTEGER
);
ALTER TABLE Shift_work ADD CONSTRAINT pk_Shift_work PRIMARY KEY (id_shift);
ALTER TABLE Shift_work ADD CONSTRAINT CH_shift CHECK (start_time<end_time);


CREATE TABLE Type_shift (
    id_type_shift SERIAL PRIMARY KEY ,
	name_type TEXT
);


------------------------------------------------------------------------------------------------



CREATE TABLE City (
    id_city SERIAL ,
    name_city TEXT NOT NULL,
    code_city INTEGER NOT NULL
);
ALTER TABLE City ADD CONSTRAINT pk_City PRIMARY KEY (id_city);
ALTER TABLE City ADD CONSTRAINT CH_City CHECK (code_city > 0);
ALTER TABLE City ADD CONSTRAINT U_City UNIQUE (code_city);



CREATE TABLE Salon (
    id_salon SERIAL PRIMARY KEY,
    name_salon TEXT NOT NULL,
	adress TEXT NOT NULL,
    FK_city INTEGER NOT NULL
);


------------------------------------------------------------------------------------------------

CREATE TABLE Owner_ (
    id_owner SERIAL PRIMARY KEY,
	surname TEXT NOT NULL,
    name_ TEXT NOT NULL,
    par_name TEXT,
    telephone VARCHAR(15) NOT NULL,
    birth DATE NOT NULL
);
ALTER TABLE Owner_ ADD CONSTRAINT U_tel UNIQUE(telephone);


CREATE TABLE Salon_Owner (
	id_salon_owner SERIAL,
    FK_owner INTEGER NOT NULL,
    FK_salon INTEGER NOT NULL
);
ALTER TABLE Salon_owner ADD CONSTRAINT pk_salon_owner PRIMARY KEY(id_salon_owner);


--------------------------------------------------------------------------------------
CREATE TABLE Type_staff (
    id_type_staff SERIAL ,
    name_staff TEXT NOT NULL
);
ALTER TABLE Type_staff ADD CONSTRAINT pk_type_staff PRIMARY KEY (id_type_staff );


CREATE TABLE Staff (
    id_staff SERIAL,
    name_ TEXT NOT NULL,
    surname TEXT NOT NULL,
    par_name TEXT ,
    birth DATE NOT NULL,
    salary NUMERIC(10, 2),
    FK_salon INTEGER NOT NULL,
    FK_type_staff INTEGER NOT NULL,
	FK_shift_work INTEGER NOT NULL
);
ALTER TABLE Staff ADD CONSTRAINT pk_staff PRIMARY KEY(id_staff);


CREATE TABLE Master (
    id_master SERIAL,
    name_ TEXT NOT NULL,
    surname TEXT NOT NULL,
    par_name TEXT ,
    birth DATE NOT NULL,
    salary NUMERIC(10, 3),
    FK_salon INTEGER NOT NULL,
	FK_shift_work INTEGER NOT NULL
);
ALTER TABLE Master ADD CONSTRAINT pk_master PRIMARY KEY(id_master);



-------------------------------------------------------------------------------------

CREATE TABLE Type_service(
	id_type_service SERIAL PRIMARY KEY,
	name_type TEXT NOT NULL
);

CREATE TABLE Service(
	id_service SERIAL,
	name_service TEXT NOT NULL,
	price INTEGER NOT NULL,
	FK_type_service INTEGER NOT NULL
);
ALTER TABLE Service ADD CONSTRAINT pk_service PRIMARY KEY(id_service);


CREATE TABLE Service_Salon(
	id_service_salon SERIAL,
	FK_service INTEGER NOT NULL,
	FK_salon INTEGER NOT NULL
);
ALTER TABLE Service_Salon ADD CONSTRAINT pk_service_salon PRIMARY KEY(id_service_salon);

-----------------------------------------------------------------------------------------------------------


CREATE TABLE Master_Service(
	id_master_service SERIAL PRIMARY KEY,
	FK_service INTEGER NOT NULL,
	FK_master INTEGER NOT NULL,
	number_ SMALLINT NOT NULL
	
);


-----------------------------------------------------------------------------------------

CREATE TABLE Type_discount(
	id_type_discount SERIAL PRIMARY KEY,
	name_discount TEXT NOT NULL
);



CREATE TABLE Discount(
	id_discount SERIAL PRIMARY KEY,
	FK_type_discount INTEGER NOT NULL,
	discount_amount SMALLINT NOT NULL
);


CREATE TABLE Promotion(
	id_promotion SERIAL PRIMARY KEY,
	name_promotion TEXT NOT NULL,
	discription TEXT,
	date_start DATE NOT NULL,
	date_end DATE NOT NULL
);

ALTER TABLE Promotion ADD CONSTRAINT CH_promo CHECK (date_start<date_end);



CREATE TABLE Promo_Service(
	id_promo_service SERIAL PRIMARY KEY,
	FK_promotion INTEGER,
	FK_service INTEGER,
	FK_discount INTEGER NOT NULL
);
ALTER TABLE Promo_Service ADD CONSTRAINT fk_promotion FOREIGN KEY (FK_promotion)
	REFERENCES Promotion(id_promotion);
ALTER TABLE Promo_Service ADD CONSTRAINT fk_service FOREIGN KEY (FK_service)
	REFERENCES Service(id_service);

--------------------------------------------------------------------------

CREATE TABLE Simple_client(
	id_simple_client SERIAl PRIMARY KEY,
	name_ TEXT NOT NULL,
	surname TEXT NOT NULL,
	par_name TEXT,
	telephone VARCHAR(15) NOT NULL,
	email VARCHAR(20) NOT NULL
);
ALTER TABLE Simple_client ADD CONSTRAINT U_tel_client UNIQUE(telephone);
ALTER TABLE Simple_client ADD CONSTRAINT U_email_client UNIQUE(email);




CREATE TABLE Regular_client(
	id_regular_client SERIAl PRIMARY KEY,
	name_ TEXT NOT NULL,
	surname TEXT NOT NULL,
	par_name TEXT,
	telephone VARCHAR(15) NOT NULL,
	email VARCHAR(20) NOT NULL,
	FK_discount INTEGER NOT NULL --------------------------------
);
ALTER TABLE Regular_client ADD CONSTRAINT U_tel_rclient UNIQUE(telephone);
ALTER TABLE Regular_client ADD CONSTRAINT U_email_rclient UNIQUE(email);




CREATE TABLE Master_Service_Client (
    id_sign_up_ SERIAL PRIMARY KEY,
    FK_master_service INTEGER NOT NULL,
    FK_regular_client INTEGER,
    FK_simple_client INTEGER,
    datetime TIMESTAMP WITH TIME ZONE NOT NULL
);

------------------------------------------------------------------------

CREATE TABLE Type_payment (
    id_type_payment SERIAL PRIMARY KEY,
    name_type TEXT NOT NULL
);

CREATE TABLE Cash (
    id_type_payment SERIAL PRIMARY KEY,
    sum_perquisite NUMERIC(10, 3) DEFAULT 0 NOT NULL
);

CREATE TABLE Bank (
    id_bank SERIAL PRIMARY KEY,
    bank_commission NUMERIC(10, 3),
    name_bank TEXT NOT NULL
);

CREATE TABLE Card (
    id_type_payment SERIAL PRIMARY KEY,
    time_operation TIMESTAMP WITH TIME ZONE NOT NULL,
    FK_bank INTEGER NOT NULL
);





CREATE TABLE Payment(
    id_sign_up SERIAL PRIMARY KEY,
    sum_payment NUMERIC NOT NULL,
	sum_prepayment NUMERIC,
	date_payment TIMESTAMP WITH TIME ZONE NOT NULL,
	FK_type_payment INTEGER,
	FK_Master_Service_Client INTEGER
);

ALTER TABLE Payment ADD CONSTRAINT fk_master_serv FOREIGN KEY (FK_Master_Service_Client)
	REFERENCES Master_Service_Client(id_sign_up_);
ALTER TABLE Payment ADD CONSTRAINT fk_type_pay FOREIGN KEY (FK_type_payment)
	REFERENCES Type_payment(id_type_payment);
	
---------------------------------------------------------------------------------------------


CREATE TABLE Company (
    id_company SERIAL PRIMARY KEY,
    name_company TEXT NOT NULL
);



CREATE TABLE Supplier (
    id_supplier SERIAL PRIMARY KEY,
    surname TEXT NOT NULL,
    name_ TEXT NOT NULL,
    par_name TEXT NOT NULL,
    FK_city INTEGER NOT NULL,
    FK_company INTEGER NOT NULL,
	FK_Salon INTEGER NOT NULL
);


CREATE TABLE Supply_Tools (
    id_supply_tools SERIAL PRIMARY KEY,
    name_sup TEXT NOT NULL,
	cost_sup NUMERIC NOT NULL,
    count_sup INTEGER NOT NULL,
    date_supply DATE NOT NULL,
    FK_supplier INTEGER NOT NULL
);



CREATE TABLE Type_material (
    id_type_material SERIAL PRIMARY KEY,
    name_type TEXT NOT NULL
);



CREATE TABLE Units_measure (
    id_units_measure SERIAL PRIMARY KEY,
    short_name CHAR(4) NOT NULL,
    long_name TEXT NOT NULL
);


CREATE TABLE Supply_materials (
    id_supply_materials SERIAL PRIMARY KEY,
    count_mat INTEGER NOT NULL,
    date_supply DATE NOT NULL,
    cost_sup NUMERIC NOT NULL,
    FK_supplier INTEGER ,
    FK_units_measure INTEGER 
);


CREATE TABLE Materials (
    id_material SERIAL PRIMARY KEY,
	name_material TEXT NOT NULL,
	expiration_date DATE NOT NULL,
    FK_salon INTEGER NOT NULL,
	FK_supply_materials INTEGER NOT NULL,
    FK_type_material INTEGER NOT NULL
);




CREATE TABLE Material_Consuption (
    id_consuption SERIAL PRIMARY KEY,
    size_consuption INTEGER,
    FK_survice INTEGER NOT NULL,
	FK_units_measure INTEGER NOT NULL,
    FK_material INTEGER 
);


CREATE TABLE Tools (
    id_tools SERIAL PRIMARY KEY,
	name_tool TEXT NOT NULL,
    FK_supply_tools INTEGER NOT NULL,
    FK_salon INTEGER NOT NULL
);




ALTER TABLE Staff ADD CONSTRAINT fk_shift_work FOREIGN KEY (FK_shift_work)
	REFERENCES Shift_work(id_shift) ;
	

ALTER TABLE Shift_work ADD CONSTRAINT fk_type_shift FOREIGN KEY (FK_type_shift)
	REFERENCES Type_shift(id_type_shift) ;
		
ALTER TABLE Salon ADD CONSTRAINT fk_salon_city FOREIGN KEY (FK_city)
	REFERENCES City(id_city);
	
ALTER TABLE Salon_Owner ADD CONSTRAINT fk_owner FOREIGN KEY (FK_owner)
	REFERENCES Owner_(id_owner);
	
ALTER TABLE Salon_Owner ADD CONSTRAINT fk_salon FOREIGN KEY (FK_salon)
	REFERENCES Salon(id_salon);
	
ALTER TABLE Staff ADD CONSTRAINT fk_staff_salon FOREIGN KEY (FK_salon)
	REFERENCES Salon(id_salon);
	
ALTER TABLE Staff ADD CONSTRAINT fk_staff_type FOREIGN KEY (FK_type_staff)
	REFERENCES Type_staff(id_type_staff);
	
ALTER TABLE Master ADD CONSTRAINT fk_master_salon FOREIGN KEY (FK_salon)
	REFERENCES Salon(id_salon);

ALTER TABLE Master ADD CONSTRAINT fk_shift_work_ FOREIGN KEY (FK_shift_work)
	REFERENCES Shift_work(id_shift) ;
	
ALTER TABLE Service_Salon ADD CONSTRAINT fk_salon FOREIGN KEY (FK_salon)
	REFERENCES Salon(id_salon);

ALTER TABLE Service ADD CONSTRAINT fk_type_service FOREIGN KEY (FK_type_service)
	REFERENCES Type_service(id_type_service);
	
ALTER TABLE Service_Salon ADD CONSTRAINT fk_service FOREIGN KEY (FK_service)
	REFERENCES Service(id_service);

ALTER TABLE Master_Service ADD CONSTRAINT fk_seice_mas FOREIGN KEY (FK_service)
	REFERENCES Service(id_service);
	
ALTER TABLE Master_Service ADD CONSTRAINT fk_master FOREIGN KEY (FK_master)
	REFERENCES Master(id_master);
	
ALTER TABLE Master_Service_Client  ADD CONSTRAINT fk_msc FOREIGN KEY (FK_master_service)
	REFERENCES Master_Service(id_master_service);
	
ALTER TABLE Master_Service_Client ADD CONSTRAINT fk_rclient FOREIGN KEY (FK_regular_client) 
	REFERENCES Regular_client(id_regular_client);
	
ALTER TABLE Master_Service_Client ADD CONSTRAINT fk_sclient FOREIGN KEY (FK_simple_client) 
	REFERENCES Simple_client(id_simple_client);


	
ALTER TABLE Card ADD CONSTRAINT fk_card_bank FOREIGN KEY (FK_bank)
	REFERENCES Bank(id_bank);
	
ALTER TABLE Discount ADD CONSTRAINT fk_type_disc FOREIGN KEY(FK_type_discount)
	REFERENCES Type_discount(id_type_discount);

ALTER TABLE Regular_client ADD CONSTRAINT fk_reg_disc FOREIGN KEY(FK_discount)
	REFERENCES Discount(id_discount);

ALTER TABLE Promo_Service ADD CONSTRAINT fk_promo_disc FOREIGN KEY(FK_discount)
	REFERENCES Discount(id_discount);

ALTER TABLE Supply_materials ADD CONSTRAINT fk_sup_un FOREIGN KEY(FK_units_measure)
	REFERENCES Units_measure(id_units_measure);

ALTER TABLE Materials ADD CONSTRAINT fk_mat_sal FOREIGN KEY(FK_salon)
	REFERENCES Salon(id_salon);
	
ALTER TABLE Materials ADD CONSTRAINT fk_mat_sup FOREIGN KEY(FK_supply_materials)
	REFERENCES Supply_materials(id_supply_materials);
	
ALTER TABLE Materials ADD CONSTRAINT fk_matc_type FOREIGN KEY(FK_type_material)
	REFERENCES Type_material(id_type_material);
	
ALTER TABLE Material_Consuption ADD CONSTRAINT fk_mat_serv FOREIGN KEY(FK_survice)
	REFERENCES Service(id_service);
	
ALTER TABLE Material_Consuption ADD CONSTRAINT fk_mat_un FOREIGN KEY(FK_units_measure)
	REFERENCES Units_measure(id_units_measure);
	
ALTER TABLE Material_Consuption ADD CONSTRAINT fk_matc_mat FOREIGN KEY(FK_material)
	REFERENCES Materials(id_material);
	
ALTER TABLE Tools ADD CONSTRAINT fk_sup_tool FOREIGN KEY (FK_supply_tools)
	REFERENCES Supply_Tools(id_supply_tools );
	
ALTER TABLE Tools ADD CONSTRAINT fk_sal_tool FOREIGN KEY (FK_salon) 
	REFERENCES Salon(id_salon);

ALTER TABLE Supplier ADD CONSTRAINT fk_com FOREIGN KEY (FK_company)
	REFERENCES Company(id_company);

ALTER TABLE Supplier ADD CONSTRAINT fk_city_ FOREIGN KEY (FK_city)
    REFERENCES City(id_city);
	
ALTER TABLE Supplier ADD CONSTRAINT fk_salon FOREIGN KEY (FK_salon)
	REFERENCES Salon(id_salon);








	