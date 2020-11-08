CREATE DATABASE PHARMNETWORK;

CREATE TABLE landlord(
    id_owner INT PRIMARY KEY,
    name VARCHAR(50),
    announcement_number INT,
    date_registration DATE
);

CREATE TABLE suburb(
    id_suburb INT PRIMARY KEY,
    name VARCHAR(20),
    availability_of_metro BOOLEAN,
    number_of_hospitals INT,
    number_of_conv_stores INT
);

CREATE TABLE city (
    id_city INT PRIMARY KEY,
    name VARCHAR(30),
    currency VARCHAR(50),
    number_of_airports INT,
    number_of_museums INT,
    number_of_railway_stations INT,
    average_salary FLOAT
);

CREATE TABLE client (
    id_client INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE announcement(
    id_post INT,
    text_description VARCHAR(10000),
    average_rating FLOAT,
    number_of_review INT,
    min_nights INT,
    max_nights INT,
    pledge FLOAT,
    cost_per_night FLOAT,
    type_house VARCHAR(50),
    square FLOAT,
    latitude FLOAT,
    longitude FLOAT,
    revelance BOOLEAN,
    id_owner INT,
    id_suburb INT,
    id_city INT,
    PRIMARY KEY (id_post),
    FOREIGN KEY (id_owner) REFERENCES(landlord),
    FOREIGN KEY (id_suburb) REFERENCES (suburb),
    FOREIGN KEY (id_city) REFERENCES (city)
);

CREATE TABLE comments (
    id_comment INT PRIMARY KEY,
    text VARCHAR(1000),
    number_of_likes INT,
    number_of_dislikes INT,
    grade_of_client INT,
    edition BOOLEAN,
    id_client INT,
    id_post INT,
    FOREIGN KEY (id_client) REFERENCES (client),
    FOREIGN KEY (id_post) REFERENCES (announcment)
);

CREATE TABLE booking_date (
    id_booking INT PRIMARY KEY,
    start_booking DATETIME,
    end_booking DATETIME,
    confirmation BOOLEAN,
    canceling BOOLEAN,
    id_owner INT,
    id_client INT,
    id_post INT,
    FOREIGN KEY (id_owner) REFERENCES (landlord),
    FOREIGN KEY (id_client) REFERENCES (client),
    FOREIGN KEY (id_post) REFERENCES (announcement)
);
