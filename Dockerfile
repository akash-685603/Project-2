FROM tomcat:9.0

# Create a tomcat user and group
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat

# Copy the WAR file into the Tomcat webapps directory
COPY target/XYZtechnologies-1.0.war /usr/local/tomcat/webapps/

# Copy the custom server.xml file into the Tomcat conf directory
COPY conf/server.xml /usr/local/tomcat/conf/
<<<<<<< HEAD

RUN chmod 644 /usr/local/tomcat/conf/server.xml

# Use root to adjust permissions
USER root
RUN chown -R tomcat:tomcat ${CATALINA_HOME}/webapps/XYZtechnologies-1.0.war && \
    chown -R tomcat:tomcat ${CATALINA_HOME}/conf/server.xml
=======

# Adjust file permissions and ownership
RUN chmod 644 /usr/local/tomcat/conf/server.xml && \
    chown tomcat:tomcat /usr/local/tomcat/webapps/XYZtechnologies-1.0.war && \
    chown tomcat:tomcat /usr/local/tomcat/conf/server.xml
>>>>>>> 2b4a3f9a047e28d5bed70e187706ffe2302abd1f

# Expose port 8081
EXPOSE 8081

<<<<<<< HEAD
# Debug step to verify file placement
RUN ls -l ${CATALINA_HOME}/webapps/
RUN ls -l ${CATALINA_HOME}/conf/

=======
>>>>>>> 2b4a3f9a047e28d5bed70e187706ffe2302abd1f
# Ensure the Tomcat process runs as the tomcat user
USER tomcat

# Define the default command to run Tomcat
CMD ["catalina.sh", "run"]
