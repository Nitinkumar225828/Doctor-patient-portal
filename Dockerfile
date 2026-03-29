FROM maven:3.9-eclipse-temurin-8 AS build

WORKDIR /app

COPY pom.xml ./
RUN mvn -B -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -B -DskipTests clean package

FROM tomcat:9.0-jdk8-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
RUN sed -i 's/port="8080"/port="10000"/' /usr/local/tomcat/conf/server.xml

COPY --from=build /app/target/Doctor-Patient-Portal.war /usr/local/tomcat/webapps/Doctor-Patient-Portal.war

ENV DB_DRIVER=org.h2.Driver
ENV DB_URL=jdbc:h2:mem:hospital;MODE=MySQL;DATABASE_TO_LOWER=TRUE;DB_CLOSE_DELAY=-1
ENV BOOTSTRAP_DB=true

EXPOSE 10000

CMD ["catalina.sh", "run"]
