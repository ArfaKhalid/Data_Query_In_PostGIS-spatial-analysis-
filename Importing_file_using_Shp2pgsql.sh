########################## ImportingAFileUsingShp2pgsql ################################

# http://postgis.net/workshops/postgis-intro/loading_data.html#shapefiles-what-s-that

# When we will install postgresql , shp2pgsql will install with that

# The shp2pgsql data loader converts ESRI Shape files into SQL suitable for insertion into a PostGIS/PostgreSQL database either in geometry or geography format

# Open up the Finder window to show cb_2017_us_state_20m/ folder

# Expand the folder and show the contents of the folder

# Let's go to the terminal and redirect to the file location

# List the contents of the current directory and show the folder cb_2017_us_state_20m/ is in here

ls

# Then run the following command 

shp2pgsql -I -s 4269 ./cb_2017_us_state_20m.shp public.us_state_20 | psql -d loonydb -p 5432

# We can see this is successful, let's go and see the data in pgadmin

# We can see the table has created
# Then run following command to see the data

SELECT * FROM us_state_20;

# We can see 52 rows
# Click on geom column and click on the icon
# We see the map of the states in US


SELECT stusps, name, geom from us_state_20 where stusps in ('CA', 'NY', 'WA', 'TX');

# Click on geom column and click on the icon

# This show the 4 selected states in the map