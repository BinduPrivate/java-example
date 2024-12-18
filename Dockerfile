FROM ubuntu
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jdk 

RUN git clone https://github.com/BinduPrivate/java-example.git /app
WORKDIR /app
RUN mvn clean package
ADD https://downloads.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz /opt/
RUN mv /opt/apache-tomcat-9.0.98 /opt/tomcat
COPY /app/target/works-with-heroku-1.0.war /opt/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]





