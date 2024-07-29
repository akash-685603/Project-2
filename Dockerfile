FROM tomcat:9.0

# Create a tomcat user and group
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war ${CATALINA_HOME}/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY conf/server.xml /usr/local/tomcat/conf/

RUN chmod 644 /usr/local/tomcat/conf/server.xml

# Use root to adjust permissions
USER root
RUN chown -R tomcat:tomcat ${CATALINA_HOME}/webapps/XYZtechnologies-1.0.war && \
    chown -R tomcat:tomcat ${CATALINA_HOME}/conf/server.xml

# Expose port 8081
EXPOSE 8081

# Debug step to verify file placement
RUN ls -l ${CATALINA_HOME}/webapps/
RUN ls -l ${CATALINA_HOME}/conf/

# Ensure the Tomcat process runs as the tomcat user
USER tomcat

# Define the default command to run Tomcat
CMD ["catalina.sh", "run"]
