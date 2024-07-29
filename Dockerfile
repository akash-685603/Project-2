# Use the official Tomcat image as the base image
FROM tomcat:9.0

# Create a tomcat user and group
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war /usr/local/tomcat/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY conf/server.xml ${CATALINA_HOME}/conf/

# Adjust file permissions and ownership
RUN chmod 644 ${CATALINA_HOME}/conf/server.xml && \
    chown -R tomcat:tomcat ${CATALINA_HOME}/webapps/XYZtechnologies-1.0.war && \
    chown -R tomcat:tomcat ${CATALINA_HOME}/conf/server.xml

# Expose port 8081
EXPOSE 8081

# Ensure the Tomcat process runs as the tomcat user
USER tomcat

# Define the default command to run Tomcat
CMD ["catalina.sh", "run"]
