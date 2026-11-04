FROM maven:3.6.3-openjdk-8 AS build
WORKDIR /app
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git .

COPY Config.properties.template ./WebContent/Config.properties
RUN mvn clean package -DskipTests

FROM tomcat:8-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar /usr/local/tomcat/lib/

EXPOSE 8080

CMD sed -i \
    -e "s|\${DB_USER}|$DB_USER|g" \
    -e "s|\${DB_PORT}|$DB_PORT|g" \
    -e "s|\${DB_PASSWORD}|$DB_PASSWORD|g" \
    -e "s|\${DB_HOST}|$DB_HOST|g" \
    -e "s|\${DB_NAME}|$DB_NAME|g" \
    /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/Config.properties || true; \
    catalina.sh run