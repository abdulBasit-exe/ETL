# first start the postgres server and connect to psql server
# start_postgres
# psql --username=postgres --host=localhost
# connect to database called template1
# \c template1
# Now we would first make table in PostgreSQL where we would be loading out data in future.
# "CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));"  

# ETL Script 
# Here we have a url of a file containing some data, for Extracting that data we would first use wget command to get that file


wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# As the file is in .gz format, we would unzip it using gunzip

gunzip web-server-access-log.txt.gz

# Extraction 
echo "Extracting..." 
# We only have to extract the first four coloumns and save them in another file called extracted_Data.txt

cut -d"#" -f1-4 web-server-access-log.txt > extracted_data.txt

# Transform
echo "Transforming..."

# Transformed the extracted data and saved it in another csv file format.
tr "#" "," < extracted-data.txt > transformed-data.csv

# For loading phase we would be loading the transformed data into the table created in the start.

# loading Phase
echo "Loading..."

echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost


# We have loaded the data now in order to query the result we will run the above command:
# echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost