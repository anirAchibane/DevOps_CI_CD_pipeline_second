# We use Tomcat 9 with JDK 11 (matches your project specs)
FROM tomcat:9.0-jdk11-openjdk

# 1. Clean up default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Download the PostgreSQL JDBC Driver
# Tomcat needs this library to talk to the database
ADD https://jdbc.postgresql.org/download/postgresql-42.2.2.jar /usr/local/tomcat/lib/

# 3. Copy your WAR file
COPY target/ywti-wa2021-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# 4. Copy the context configuration (We will create this file next)
# This file tells Tomcat where the database lives
COPY context.xml /usr/local/tomcat/conf/context.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]