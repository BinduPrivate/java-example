FROM alpine:latest AS checkout
RUN apk add git
RUN git clone https://github.com/BinduPrivate/java-example.git
WORKDIR /java-example

FROM maven:3.8.6-amazoncorretto-11 AS build
WORKDIR /app
COPY --from=checkout /java-example
RUN mvn clean package

FROM artisantek/tomcat:1
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]

