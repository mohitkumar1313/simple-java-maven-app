# First Stage: Build the Maven application
FROM maven:3.8.6-openjdk-18-slim AS build
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src /app/src
RUN mvn clean package -DskipTests

#Second Stage: Create a minimal runtime image
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/my-new-app-2.0-SNAPSHOT.jar /app/my-new-app-2.0-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar"]
CMD ["my-new-app-2.0-SNAPSHOT.jar"]

