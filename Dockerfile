# Use a specific version of the Tomcat image from the Docker Hub
FROM tomcat:9.0

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat

# Create a tomcat user and group if they don't exist
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war ${CATALINA_HOME}/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY server.xml ${CATALINA_HOME}/conf/

# Use root to adjust permissions
USER root
RUN chown -R tomcat:tomcat ${CATALINA_HOME}/webapps/XYZtechnologies-1.0.war && \
    chown -R tomcat:tomcat ${CATALINA_HOME}/conf/server.xml || true

# Expose port 8081 (ensure Tomcat is configured to listen on this port)
EXPOSE 8081

# Modify Tomcat's server.xml to listen on port 8081
RUN sed -i 's/port="8080"/port="8081"/g' ${CATALINA_HOME}/conf/server.xml

# Ensure the Tomcat process runs as the tomcat user
USER tomcat

# Define the default command to run Tomcat
CMD ["catalina.sh", "run"]
