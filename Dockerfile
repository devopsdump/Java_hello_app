# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17-slim AS build
# Set the working directory in the container
WORKDIR /usr/src/app
# Copy the pom.xml file to the container
COPY pom.xml ./
# Copy the entire project to the container
COPY . .
# Build the application
RUN mvn clean package
# Stage 2: Create a lightweight image to run the application
FROM tomcat:9.0-jdk17-openjdk-slim
# Copy the WAR file from the build stage to the container's webapps directory
COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps/
# Copy the WAR file from the build stage to the container's webapps directory
COPY Lab6A.war /usr/local/tomcat/webapps/
# Expose the port the application runs on (Tomcat default is 8080)
EXPOSE 8080
# Command to run the application
CMD ["catalina.sh", "run"]
