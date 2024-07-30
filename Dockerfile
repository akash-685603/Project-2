FROM tomcat:9.0

# Create tomcat user and group
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set environment variable for Tomcat home
ENV CATALINA_HOME=/usr/local/tomcat

# Copy the WAR file into the webapps directory
COPY target/XYZtechnologies-1.0.war ${CATALINA_HOME}/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY conf/server.xml ${CATALINA_HOME}/conf/

# Adjust file permissions and ownership
RUN chown -R tomcat:tomcat ${CATALINA_HOME}/conf \
    && chmod -R 755 ${CATALINA_HOME}/conf

# Expose port
EXPOSE 8081

# Modify server.xml to listen on port 8081 (if necessary)
RUN sed -i 's/8080/8081/' ${CATALINA_HOME}/conf/server.xml

# Run Tomcat
USER tomcat
CMD ["catalina.sh", "run"]
