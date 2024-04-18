FROM maven:3.8.4-openjdk-11-slim as maven_builder

ENV HOME=/app

WORKDIR $HOME

ADD pom.xml $HOME

RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]

ADD . $HOME

RUN ["mvn","clean","package","-T","2C","-DskipTests=true"]

FROM tomcat:9.0-jdk11-openjdk-slim

COPY --from=maven_builder /app/target/hello-2.0.war /usr/local/tomcat/webapps.dist

# Expose the port the application runs on (Tomcat default is 8080)
EXPOSE 8080

# Command to run the application
CMD ["catalina.sh", "run"]


