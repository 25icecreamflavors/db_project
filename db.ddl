CREATE DATABASE HOUSES;

CREATE TABLE landlord (
    id_owner INT PRIMARY KEY,
    name VARCHAR(50),
    announcement_number INT,
    date_registration DATE
);

CREATE TABLE suburb (
    id_suburb INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(20),
    availability_of_metro BIT,
    number_of_hospitals INT,
    number_of_conv_stores INT
);

CREATE TABLE city (
    id_city INT IDENTITY(1,1) PRIMARY KEY,
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

CREATE TABLE announcement (
    id_post INT IDENTITY(1,1) PRIMARY KEY,
    text_description VARCHAR(8000),
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
    revelance BIT,
    id_owner INT,
    id_suburb INT,
    id_city INT,
    FOREIGN KEY (id_owner) REFERENCES landlord(id_owner),
    FOREIGN KEY (id_suburb) REFERENCES suburb(id_suburb),
    FOREIGN KEY (id_city) REFERENCES city(id_city)
);

CREATE TABLE comments (
    id_comment INT IDENTITY(1,1) PRIMARY KEY,
    text VARCHAR(1000),
    number_of_likes INT,
    number_of_dislikes INT,
    grade_of_client INT,
    edition BIT,
    id_client INT,
    id_post INT,
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_post) REFERENCES announcement(id_post)
);

CREATE TABLE booking_date (
    id_booking INT IDENTITY(1,1) PRIMARY KEY,
    start_booking DATETIME,
    end_booking DATETIME,
    confirmation BIT,
    canceling BIT,
    id_owner INT,
    id_client INT,
    id_post INT,
    FOREIGN KEY (id_owner) REFERENCES landlord(id_owner),
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_post) REFERENCES announcement(id_post)
);


// СREATING PROCEDURE FOR ADDING INFO
GO
CREATE PROCEDURE AddSuburb
    @name NVARCHAR(20),
    @metro BIT,
    @hospital INT,
    @shops INT
AS
INSERT INTO suburb
VALUES(@name, @metro, @hospital, @shops);

GO
CREATE PROCEDURE AddCity
    @name VARCHAR(30),
    @currency  VARCHAR(50),
    @airports INT,
    @museums INT,
    @train INT,
    @salary INT
AS
INSERT INTO city
VALUES(@name, @currency, @airports, @museums, @train, @salary);

GO
CREATE PROCEDURE AS HousesCitiesInfo
BEGIN
  SELECT name AS City, currency AS Currency, number_of_airports AS Airports, 
    number_of_railway_stations AS [Train stations], number_of_museums AS Museums
  FROM city
END;

GO
CREATE PROCEDURE Houses.RentAveragePrices As
    SELECT AVG(cost_per_night) AS [Average price], id_city AS city
    FROM Houses.announcement
    GROUP BY id_city
 
 
 
// Get posts by chosen city 
GO
CREATE PROCEDURE get_posts_bycity
@city NVARCHAR(50) AS
    SELECT announcement.id_post, city.name 
    FROM announcement LEFT JOIN city ON announcement.id_city = city.id_city
    WHERE city.name = @city;
    
    
    
// Useful trigger for increasing value after insert
GO
CREATE TRIGGER post_addition ON announcement
    AFTER INSERT
    AS
      UPDATE landlord
      SET landlord.announcement_number = landlord.announcement_number + 1
      FROM inserted
      LEFT JOIN landlord
      ON inserted.id_owner = landlord.id_owner
      WHERE landlord.id_owner =  inserted.id_owner;
