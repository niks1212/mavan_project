# Use OpenJDK base image
FROM openjdk:11-jdk

# Set working directory
WORKDIR /app

# Copy the Maven-built JAR
COPY target/demo-app-1.0-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]

