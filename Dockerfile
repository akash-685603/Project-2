# Use the official Tomcat image from the Docker Hub
FROM tomcat:latest

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war /usr/local/tomcat/webapps/

# Expose port 8080 to access the Tomcat server
EXPOSE 8080
