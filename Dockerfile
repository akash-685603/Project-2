FROM tomcat:9.0

# Create a tomcat user and group
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war /usr/local/tomcat/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY conf/server.xml /usr/local/tomcat/conf/

# Adjust file permissions and ownership
RUN chmod 644 /usr/local/tomcat/conf/server.xml && \
    chown tomcat:tomcat /usr/local/tomcat/webapps/XYZtechnologies-1.0.war && \
    chown tomcat:tomcat /usr/local/tomcat/conf/server.xml

# Expose port 8081
EXPOSE 8081

# Ensure the Tomcat process runs as the tomcat user
USER tomcat

# Define the default command to run Tomcat
CMD ["catalina.sh", "run"]
