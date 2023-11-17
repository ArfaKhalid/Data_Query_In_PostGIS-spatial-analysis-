########################## InstallationOfPostgresqlAndPostGis ##########################

# We have to install 3 things for this
	# 1. Postgresql
	# 2. PgAdmin
	# 3. PostGis

# Let's install postgresql first
# For that go to following link

https://postgresapp.com/downloads.html
# Click on the download button
# Now the dmg file will download to laptop
# Now let's install pgadmin
# Cick on following link

https://www.postgresql.org/ftp/pgadmin/pgadmin4/

# Go to the latest version

https://www.postgresql.org/ftp/pgadmin/pgadmin4/v6.18/macos/

# Click on the following name - pgadmin*.dmg
# Download the dmg and install it

# Then open pgadmin and setup 

# Click on "Add New Server"

Name: loonyserver

# Switch to the Connection tab

Hostname: localhost

# Click on Save


# Set up the path for the command line (go to the terminal window and run this)


sudo mkdir -p /etc/paths.d &&
echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp


PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/ 

psql

# This should take you into the PSQL prompt

loonycorn=# 

# Type "quit" to exit


# Let's install PostGIS
# Got to our terminal and let's install
# Run following command
brew install postgis

# Then let's go to the pgadmin app again and do the extension with the postgis

# Right-click on Databases -> Create

# Create a new database "loonydb"

# Select Schemas under loonydb

# Click on the Query Tool icon on the top-left to bring up a new query window

CREATE EXTENSION postgis;

# This will be successful

