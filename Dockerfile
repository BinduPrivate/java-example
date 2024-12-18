FROM ubuntu
RUN RUN apt update -y && apt install git -y && apt install openjdk-11-jdk -y && apt install maven -y
WORKDIR /app
RUN git clone https://github.com/BinduPrivate/java-example.git
WORKDIR /app/java-example
RUN mvn clean package
EXPOSE 8080
CMD ["java", "-war", "target/maven-project"]


FROM maven:amazoncorretto as build
WORKDIR /javaapp
COPY . .
RUN mvn clean install

FROM adhig93/tomcat-conf
COPY --from=build /javaapp/target/*.war /usr/local/tomcat/webapps/
