USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

CREATE OR REPLACE DATABASE my_db;

CREATE OR REPLACE SCHEMA my_schema;

//Creating a permanent table
CREATE OR REPLACE TABLE permanent_table
(
ID INT,
NAME STRING()
)

ALTER TABLE permanent_table SET DATA_RETENTION_TIME_IN_DAYS= 90;

//Creating transiet table
CREATE OR REPLACE TRANSIENT TABLE transient_table
(
ID INT,
NAME STRING()
);

ALTER TABLE transient_table SET DATA_RETENTION_TIME_IN_DAYS=1;

CREATE OR REPLACE TEMPORARY TABLE temporary_table
(
ID INT,
NAME STRING()
);

ALTER TABLE temporary_table SET DATA_RETENTION_TIME_IN_DAYS= 1;

SHOW TABLES



INSERT INTO PERMANENT_TABLE (ID,NAME) VALUES
(1, 'Brian'),
(2, 'Muriiki'),
(3, 'Jane');

INSERT INTO TEMPORARY_TABLE VALUES
(1, 'John'),
(2, 'Doe'),
(3, 'Jane'),
(4,'James');


SELECT *
FROM PERMANENT_TABLE

//Creating standard views
CREATE OR REPLACE VIEW permanent_table_view AS 
SELECT *
FROM PERMANENT_TABLE

//Querying the views
SELECT *
FROM permanent_table_view

//Creating secure views
CREATE OR REPLACE SECURE VIEW secure_table_view AS 
SELECT *
FROM PERMANENT_TABLE
WHERE ID=1

//Querying the views
SELECT *
FROM secure_table_view

//Creating materialized views
CREATE OR REPLACE MATERIALIZED VIEW materialized_table_view AS 
SELECT *
FROM PERMANENT_TABLE
WHERE ID=2

//Querying the views
SELECT *
FROM materialized_table_view


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
LOADING DATA FROM S3 BUCKET TO SNOWFLAKE

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MY_DB.MY_SCHEMA;

CREATE OR REPLACE TABLE city(
  city_id STRING,
  city_name STRING
);

//Creating storage integration
CREATE OR REPLACE STORAGE INTEGRATION s3_int
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER= 'S3'
ENABLED= TRUE
STORAGE_AWS_ROLE_ARN= 'arn:aws:iam::876762732779:role/snowflakerole'
STORAGE_ALLOWED_LOCATIONS= ('s3://snoflake-project-brian/')

//Describe storage integration
DESC INTEGRATION s3_int;

//Create file format
CREATE OR REPLACE FILE FORMAT my_csv_format
    TYPE ='CSV'
    FIELD_DELIMITER= ','
    RECORD_DELIMITER= '\n';

//Create external stage
CREATE OR REPLACE STAGE my_s3_stage
    STORAGE_INTEGRATION = s3_int
    URL= 's3://snoflake-project-brian/'
    FILE_FORMAT = my_csv_format;

list @my_s3_stage;

COPY INTO city
FROM @my_s3_stage
FILE_FORMAT= (FORMAT_NAME=my_csv_format)































