DROP TABLE IF EXISTS pictures CASCADE;
DROP TABLE IF EXISTS comments_ CASCADE;
DROP TABLE IF EXISTS promo_master_service CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS sign_ups CASCADE;
DROP TABLE IF EXISTS slots CASCADE;
DROP TABLE IF EXISTS master_service CASCADE;
DROP TABLE IF EXISTS salon_services CASCADE;
DROP TABLE IF EXISTS salons_users CASCADE;
DROP TABLE IF EXISTS users_roles CASCADE;
DROP TABLE IF EXISTS salon CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS types_payments CASCADE;
DROP TABLE IF EXISTS promo CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS city CASCADE;


CREATE TABLE city (
id_city SERIAL NOT NULL,
name_city TEXT NOT NULL,
code_city INTEGER NOT NULL
);
ALTER TABLE city ADD CONSTRAINT pk_city PRIMARY KEY (id_city);
ALTER TABLE city ADD CONSTRAINT uq_city_code UNIQUE (code_city);
ALTER TABLE city ADD CONSTRAINT chk_city_code_positive CHECK (code_city > 0);

CREATE TABLE salon (
id_salon SERIAL NOT NULL,
name_salon TEXT NOT NULL,
salon_address TEXT NOT NULL,
fk_city INTEGER NOT NULL
);
ALTER TABLE salon ADD CONSTRAINT pk_salon PRIMARY KEY (id_salon);
ALTER TABLE salon ADD CONSTRAINT fk_salon_city FOREIGN KEY (fk_city) REFERENCES city (id_city);

CREATE TABLE roles (
id_role SERIAL NOT NULL,
name_role TEXT NOT NULL
);
ALTER TABLE roles ADD CONSTRAINT pk_roles PRIMARY KEY (id_role);
ALTER TABLE roles ADD CONSTRAINT uq_roles_name UNIQUE (name_role);

CREATE TABLE users (
id_user SERIAL NOT NULL,
first_name TEXT NOT NULL,
surname TEXT NOT NULL,
patrname TEXT,
telephone VARCHAR(32),
user_login VARCHAR(128),
user_birthday DATE
);
ALTER TABLE users ADD CONSTRAINT pk_users PRIMARY KEY (id_user);

CREATE TABLE users_roles (
fk_user INTEGER NOT NULL,
fk_role INTEGER NOT NULL
);
ALTER TABLE users_roles ADD CONSTRAINT pk_users_roles PRIMARY KEY (fk_user, fk_role);
ALTER TABLE users_roles ADD CONSTRAINT fk_users_roles_user FOREIGN KEY (fk_user) REFERENCES users (id_user) ON DELETE CASCADE;
ALTER TABLE users_roles ADD CONSTRAINT fk_users_roles_role FOREIGN KEY (fk_role) REFERENCES roles (id_role) ON DELETE CASCADE;

CREATE TABLE salons_users (
fk_salon INTEGER NOT NULL,
fk_user INTEGER NOT NULL
);
ALTER TABLE salons_users ADD CONSTRAINT pk_salons_users PRIMARY KEY (fk_salon, fk_user);
ALTER TABLE salons_users ADD CONSTRAINT fk_salons_users_salon FOREIGN KEY (fk_salon) REFERENCES salon (id_salon) ON DELETE CASCADE;
ALTER TABLE salons_users ADD CONSTRAINT fk_salons_users_user FOREIGN KEY (fk_user) REFERENCES users (id_user) ON DELETE CASCADE;

CREATE TABLE services (
id_service SERIAL NOT NULL,
service_name TEXT NOT NULL,
service_price NUMERIC(12,2) NOT NULL,
duration_minutes INTEGER NOT NULL DEFAULT 60
);
ALTER TABLE services ADD CONSTRAINT pk_services PRIMARY KEY (id_service);
ALTER TABLE services ADD CONSTRAINT chk_services_price CHECK (service_price >= 0);
ALTER TABLE services ADD CONSTRAINT chk_services_duration CHECK (duration_minutes > 0);

CREATE TABLE salon_services (
fk_salon INTEGER NOT NULL,
fk_service INTEGER NOT NULL
);
ALTER TABLE salon_services ADD CONSTRAINT pk_salon_services PRIMARY KEY (fk_salon, fk_service);
ALTER TABLE salon_services ADD CONSTRAINT fk_salon_services_salon FOREIGN KEY (fk_salon) REFERENCES salon (id_salon) ON DELETE CASCADE;
ALTER TABLE salon_services ADD CONSTRAINT fk_salon_services_service FOREIGN KEY (fk_service) REFERENCES services (id_service) ON DELETE CASCADE;

CREATE TABLE master_service (
id_master_service SERIAL NOT NULL,
fk_service INTEGER NOT NULL,
fk_user INTEGER NOT NULL,
is_active BOOLEAN NOT NULL DEFAULT true
);
ALTER TABLE master_service ADD CONSTRAINT pk_master_service PRIMARY KEY (id_master_service);
ALTER TABLE master_service ADD CONSTRAINT fk_master_service_service FOREIGN KEY (fk_service) REFERENCES services (id_service) ON DELETE RESTRICT;
ALTER TABLE master_service ADD CONSTRAINT fk_master_service_user FOREIGN KEY (fk_user) REFERENCES users (id_user) ON DELETE RESTRICT;
ALTER TABLE master_service ADD CONSTRAINT uq_master_service UNIQUE (fk_service, fk_user);

CREATE TABLE slots (
id_master_slot SERIAL NOT NULL,
slot_start_at TIMESTAMPTZ NOT NULL,
slot_end_at TIMESTAMPTZ NOT NULL,
fk_master_service INTEGER NOT NULL
);
ALTER TABLE slots ADD CONSTRAINT pk_slots PRIMARY KEY (id_master_slot);
ALTER TABLE slots ADD CONSTRAINT fk_slots_master_service FOREIGN KEY (fk_master_service) REFERENCES master_service (id_master_service) ON DELETE CASCADE;
ALTER TABLE slots ADD CONSTRAINT chk_slots_interval CHECK (slot_start_at < slot_end_at);



CREATE TABLE sign_ups (
id_sign_up SERIAL NOT NULL,
fk_master_slot INTEGER NOT NULL,
fk_user INTEGER NOT NULL,
sign_up_status VARCHAR(32) NOT NULL DEFAULT 'confirmed'
);
ALTER TABLE sign_ups ADD CONSTRAINT pk_sign_ups PRIMARY KEY (id_sign_up);
ALTER TABLE sign_ups ADD CONSTRAINT fk_sign_ups_slot FOREIGN KEY (fk_master_slot) REFERENCES slots (id_master_slot) ON DELETE RESTRICT;
ALTER TABLE sign_ups ADD CONSTRAINT fk_sign_ups_client FOREIGN KEY (fk_user) REFERENCES users (id_user) ON DELETE RESTRICT;
ALTER TABLE sign_ups ADD CONSTRAINT chk_sign_ups_status CHECK (sign_up_status IN ('draft','confirmed','paid','completed','cancelled','no_show'));

CREATE TABLE types_payments (
id_type_payment SERIAL NOT NULL,
payment_type_name TEXT NOT NULL
);
ALTER TABLE types_payments ADD CONSTRAINT pk_types_payments PRIMARY KEY (id_type_payment);



CREATE TABLE payments (
id_payment SERIAL NOT NULL,
payment_status VARCHAR(32) NOT NULL DEFAULT 'pending',
payment_amount NUMERIC(12,2) NOT NULL,
prepayment_amount NUMERIC(12,2)NOT NULL,
payment_paid_at TIMESTAMPTZ,
fk_sign_up INTEGER NOT NULL,
fk_type_payment INTEGER NOT NULL
);
ALTER TABLE payments ADD CONSTRAINT pk_payments PRIMARY KEY (id_payment);
ALTER TABLE payments ADD CONSTRAINT fk_payments_sign_up FOREIGN KEY (fk_sign_up) REFERENCES sign_ups (id_sign_up) ON DELETE RESTRICT;
ALTER TABLE payments ADD CONSTRAINT fk_payments_type FOREIGN KEY (fk_type_payment) REFERENCES types_payments (id_type_payment);
ALTER TABLE payments ADD CONSTRAINT chk_payments_amount CHECK (payment_amount >= 0);
ALTER TABLE payments ADD CONSTRAINT chk_payments_prepayment_nonneg CHECK (prepayment_amount IS NULL OR prepayment_amount >= 0);



CREATE TABLE promo (
id_promotion SERIAL NOT NULL,
name_promotion TEXT NOT NULL,
discount_percent NUMERIC(5,2) NOT NULL,
promo_description TEXT
);
ALTER TABLE promo ADD CONSTRAINT pk_promo PRIMARY KEY (id_promotion);
ALTER TABLE promo ADD CONSTRAINT chk_promo_discount CHECK (discount_percent >= 0 AND discount_percent <= 100);

CREATE TABLE promo_master_service (
id_master_promo SERIAL NOT NULL,
promo_period_start DATE NOT NULL,
promo_period_end DATE NOT NULL,
fk_promotion INTEGER NOT NULL,
fk_master_service INTEGER NOT NULL
);


ALTER TABLE promo_master_service ADD CONSTRAINT pk_promo_master_service PRIMARY KEY (id_master_promo);
ALTER TABLE promo_master_service ADD CONSTRAINT fk_pms_promo FOREIGN KEY (fk_promotion) REFERENCES promo (id_promotion) ON DELETE CASCADE;
ALTER TABLE promo_master_service ADD CONSTRAINT fk_pms_master_service FOREIGN KEY (fk_master_service) REFERENCES master_service (id_master_service) ON DELETE CASCADE;
ALTER TABLE promo_master_service ADD CONSTRAINT chk_pms_dates CHECK (promo_period_start <= promo_period_end);



CREATE TABLE comments_ (
id_comment SERIAL NOT NULL,
fk_user INTEGER NOT NULL,
fk_master_service INTEGER NOT NULL,
comment_body TEXT NOT NULL,
star_rating SMALLINT NOT NULL
);


ALTER TABLE comments_ ADD CONSTRAINT pk_comments PRIMARY KEY (id_comment);
ALTER TABLE comments_ ADD CONSTRAINT fk_comments_user FOREIGN KEY (fk_user) REFERENCES users (id_user) ON DELETE RESTRICT;
ALTER TABLE comments_ ADD CONSTRAINT fk_comments_master_service FOREIGN KEY (fk_master_service) REFERENCES master_service (id_master_service) ON DELETE CASCADE;
ALTER TABLE comments_ ADD CONSTRAINT chk_comments_rating CHECK (star_rating >= 1 AND star_rating <= 5);



CREATE TABLE pictures (
id_picture SERIAL NOT NULL,
picture_filename TEXT NOT NULL,
picture_file_extension VARCHAR(16) NOT NULL,
picture_url TEXT NOT NULL,
fk_master_service INTEGER NOT NULL
);
ALTER TABLE pictures ADD CONSTRAINT pk_pictures PRIMARY KEY (id_picture);
ALTER TABLE pictures ADD CONSTRAINT fk_pictures_master_service FOREIGN KEY (fk_master_service) REFERENCES master_service (id_master_service) ON DELETE CASCADE;

