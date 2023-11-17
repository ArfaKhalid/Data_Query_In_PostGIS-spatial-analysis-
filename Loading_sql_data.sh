
########################## LoadingSQLData ################################

# Create a sql file and import the file in it to work with it
# Create a sql file roads.sql with following content

BEGIN;
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (1,'LINESTRING(191232 243118,191108 243242)','Jeff Rd');
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (2,'LINESTRING(189141 244158,189265 244817)','Geordie Rd');
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (3,'LINESTRING(192783 228138,192612 229814)','Paul St');
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (4,'LINESTRING(189412 252431,189631 259122)','Graeme Ave');
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (5,'LINESTRING(190131 224148,190871 228134)','Phil Tce');
INSERT INTO roads (road_id, roads_geom, road_name)
  VALUES (6,'LINESTRING(198231 263418,198213 268322)','Dave Cres');
COMMIT;

# After saving the file in local machine
# Come back to the pgadmin and run following command to create a table with geospatial data

CREATE TABLE ROADS (road_id serial, roads_geom geometry(LINESTRING, 4326), road_name text);

# Next let's go to the local machine terminal 
# Run the following query to import the sql file and connect to the data

psql -d loonycorn -f roads.sql -p 5430

# After executing will get result as follows

INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
COMMIT

# run the following query in pgadmin

SELECT * FROM ROADS;

# It will return all the data which got inserted in the table

# Write query to retrieve some data

SELECT road_id, ST_AsText(roads_geom) AS geom, road_name FROM roads;

# Run following query 

SELECT road_id, road_name 
  FROM roads 
  WHERE roads_geom ~= ST_GeomFromText('LINESTRING(191232 243118,191108 243242)');