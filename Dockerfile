FROM maven:alpine as build
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src
RUN mvn package -Dmaven.test.skip=true


FROM openjdk:8-jdk-alpine
ARG JAR_FILE=/target/sample-0.0.1-SNAPSHOT.jar
COPY --from=build ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-Djava.security.edg=file:/dev/./urandom","-jar","/app.jar"]
