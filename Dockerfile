# Build Stage
FROM maven AS BUILD
WORKDIR /app
COPY . /app
RUN cd ./target; ls
RUN mvn clean package -Dmaven.test.skip=true

# Deployment Stage
FROM tomcat:9.0-alpine
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=BUILD /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]


