# Use the official Tomcat image from the Docker Hub
FROM tomcat:latest

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war /usr/local/tomcat/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY server.xml /usr/local/tomcat/conf/

# Expose port 8081
EXPOSE 8081
