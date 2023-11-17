########################## UnderstandingGeographyBasics ################################

CREATE TABLE geometries (name text, geom geometry);


# Click on loonydb -> Schemas -> Tables and show that two tables are created

# Click on the "geometries" table and show the columns

# Right-click on "spatial_ref_sys" -> View/Edit data -> All Rows

# Note: The SPATIAL_REF_SYS table used by PostGIS is an (Open Geospatial Consortium (OGC)) OGC-compliant database table that defines the available spatial reference systems. It holds the numeric SRIDs and textual descriptions of the coordinate systems.
# http://postgis.net/workshops/postgis-intro/geometries.html#metadata-tables

# Click on loonydb -> Schemas -> Views and show that you have the "geometry_columns" view

# Right-click on "geometry_columns" -> View/Edit data -> All Rows


# Insert some geometry values

INSERT INTO geometries VALUES
  ('Point', 'POINT(0 0)'),
  ('Point', 'POINT(1 1)'),
  ('Point', 'POINT(1 2)'),
  ('Simple line', 'LINESTRING(1 2, 2 2)'),
  ('Linestring', 'LINESTRING(0 0, 1 1, 2 0, 1 0, 2 1, 3 0)'),
  ('Square', 'POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'),
  ('Rectangle', 'POLYGON((1 2, 3 2, 3 1, 1 1, 1 2))'),
  ('PolygonWithHole', 'POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(1 1, 1 2, 2 2, 2 1, 1 1))'),
  ('Collection', 'GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');
  
# Here we have 5 geometries 
# After inserting the values run queries and see the geometry of these 

# ST_AsText get the WKT or the Well-known Text format of the geometry data

# Run the following:

SELECT *, ST_AsText(geom) FROM geometries;

# "Point" "010100000000000000000000000000000000000000"  "POINT(0 0)"
# "Linestring"  "01020000000400000000000000000000000000000000000000000000000000F03F000000000000F03F0000000000000040000000000000F03F00000000000000400000000000000040"  "LINESTRING(0 0,1 1,2 1,2 2)"
# "Polygon" "0103000000010000000500000000000000000000000000000000000000000000000000F03F0000000000000000000000000000F03F000000000000F03F0000000000000000000000000000F03F00000000000000000000000000000000"  "POLYGON((0 0,1 0,1 1,0 1,0 0))"
# "PolygonWithHole" "01030000000200000005000000000000000000000000000000000000000000000000002440000000000000000000000000000024400000000000002440000000000000000000000000000024400000000000000000000000000000000005000000000000000000F03F000000000000F03F000000000000F03F0000000000000040000000000000004000000000000000400000000000000040000000000000F03F000000000000F03F000000000000F03F"  "POLYGON((0 0,10 0,10 10,0 10,0 0),(1 1,1 2,2 2,2 1,1 1))"
# "Collection"  "0107000000020000000101000000000000000000004000000000000000000103000000010000000500000000000000000000000000000000000000000000000000F03F0000000000000000000000000000F03F000000000000F03F0000000000000000000000000000F03F00000000000000000000000000000000"  "GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0,1 0,1 1,0 1,0 0)))"

# Click on the geom value of point and click on the icon nect to geom
# see a point

# Do the same thing for the following:
# Linestring
# Rectangle
# PolygonWithHole
# Collection


# Explore each of these geom 
# We can extract the X and Y coordinates using :

  # ST_X(geometry) - returns the X ordinate
  # ST_Y(geometry) - returns the Y ordinate


 
# Get the coordinates

  SELECT ST_X(geom), ST_Y(geom)
  FROM geometries
  WHERE name = 'Point';
  
###

# In this data we have two lines
# We can get the length of the line using the following query

# Select the each query and hit F5

  SELECT ST_asText(geom), ST_Length(geom)
  FROM geometries
  WHERE name = 'Simple line';

  SELECT ST_asText(geom), ST_Length(geom)
  FROM geometries
  WHERE name = 'Linestring';

# To get the start and end point use the following query

  SELECT ST_asText(geom), 
         ST_Length(geom), 
     ST_asText(ST_StartPoint(geom)), 
     ST_asTEXT(ST_EndPoint(geom))
  FROM geometries
  WHERE name = 'Linestring';
  
# Now, we have 3 different polygons

  SELECT name, ST_AsText(geom), ST_Area(geom), geom
  FROM geometries
  WHERE name LIKE 'Polygon%' or name LIKE 'Square' or name LIKE 'Rectangle';

# click on each and show it's shape

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

## NOTE: 4326 is the most common spatial reference for storing a referencing data across the entire world. It serves as the default for both the PostGIS spatial database and the GeoJSON standard. It is also used by default in most web mapping libraries. 
# Because of its use in GPS, 4326 is generally assumed to be the spatial reference when talking about "latitude" or "longitude".


### Example 

# Now, let's add in real life points of places in UK and see the points in map

# Past DROP, CREATE, and INSERT commands all at once

# Select each command in turn and hit F5 to run that command

DROP TABLE IF EXISTS UKPlaces;

CREATE TABLE UKPlaces (
  sensor_id VARCHAR(50) PRIMARY KEY NOT NULL,
  name TEXT,
  longitude VARCHAR(50),
  latitude VARCHAR(50),
  country TEXT,
  sensorLocation GEOMETRY
);


INSERT INTO UKPlaces (sensor_id, name, longitude, latitude, country, sensorLocation) VALUES 
('S1', 'York', -1.080278, 53.958332, 'UK', ST_GeomFromText('POINT(-1.080278 53.958332)',4326)),
('S2', 'Worcester', -2.220000, 52.192001, 'UK', ST_GeomFromText('POINT(-2.220000 52.192001)',4326)),
('S3', 'Winchester', -1.308000, 51.063202, 'UK', ST_GeomFromText('POINT(-0.138702 51.063202)',4326)),
('S4', 'Wells', -2.647000, 51.209000, 'UK', ST_GeomFromText('POINT(-2.647000 51.209000)',4326)),
('S5', 'Wakefield', -1.490000, 53.680000, 'UK', ST_GeomFromText('POINT(-1.490000 53.680000)',4326)),
('S6', 'Truro', -5.051000, 50.259998, 'UK', ST_GeomFromText('POINT(-5.051000 50.259998)',4326)),
('S7', 'Sunderland', -1.381130, 54.906101, 'UK', ST_GeomFromText('POINT(-1.381130 54.906101)',4326));



# Now, query the table

SELECT * FROM UKPlaces;

# CLick on the geom column and plot

# We can see the world map and the points being plotted

# Query for specific places

 SELECT sensorLocation FROM UKGeom 
 WHERE name='Wells' OR name='Truro';

# Select the geom coloumn and click on plot

# We can see the two points in the world map

# We can calculae the distance between the two places using the following query

SELECT ST_Distance(geometry(a.sensorLocation), geometry(b.sensorLocation))
FROM UKPlaces a, UKPlaces b
WHERE a.name='Wells' AND b.name='Truro';

# The result is 2.584534928377638

# Now, if we search in google the distance between Wells and Truro, it is 250kms approximately
# As we have calculated it for geometry we got this value
# The units for spatial reference 4326 are degrees. So our answer is 2.584 degrees

# http://postgis.net/workshops/postgis-intro/geography.html
# In order to calculate a meaningful distance, we must treat geographic coordinates not as approximate Cartesian coordinates but rather as true spherical coordinates.
# We must measure the distances between points as true paths over a sphere – a portion of a great circle.
# PostGIS provides this functionality through the geography type.

#Calculate it using geography

SELECT ST_Distance(geography(a.sensorLocation), geography(b.sensorLocation))
FROM UKPlaces a, UKPlaces b
WHERE a.name='Wells' AND b.name='Truro';

# We see now it shows 199856.34597716 mts ie 200kms 

# Switch over to maps.google.com

maps.google.com

# Type in Wells, UK
# Directions
# Type in Truro, UK
# Show the distance is about 155 miles (roughly 200km)


# Find all places within 250kms of London (the coordinate value is for London)

SELECT name FROM UKPlaces 
WHERE ST_DWithin(sensorLocation, 
                 ST_GeomFromText('POINT(-0.138702 51.501220)',4326)::geography, 
                 250000);

# Should be
# "Worcester"
# "Winchester"
# "Wells"


# Now lets check the distance between some other place and verify the value
# We can also plot the line between these two places

SELECT ST_Distance(geography(a.sensorLocation), geography(b.sensorLocation)), 
       ST_MakeLine(a.sensorLocation, b.sensorLocation)
FROM UKPlaces a, UKPlaces b
WHERE a.name='Winchester' AND b.name='Wells';

# Now click on the st_makeline column and plot
# We can see the line between the two places

# From the query we also get the sitance between the two places in meters

SELECT ST_Distance(geography(a.sensorLocation), geography(b.sensorLocation)),
      ST_MakeLine(a.sensorLocation, b.sensorLocation)
FROM UKGeom a, UKGeom b
WHERE a.name='York' AND b.name='Sunderland';

# We see the result is 110kms

# Google the distance between these two places, we see it's 130kms 

# Which is the correct value