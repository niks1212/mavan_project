# Use OpenJDK as base
FROM openjdk:11-jre-slim

# Copy the JAR file built by Maven
COPY target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

