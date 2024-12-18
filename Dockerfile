FROM ubuntu
RUN RUN apt update -y && apt install git -y && apt install openjdk-11-jdk -y && apt install maven -y
WORKDIR /app
RUN git clone https://github.com/BinduPrivate/java-example.git
WORKDIR /app/java-example
RUN mvn clean package
EXPOSE 8080
CMD ["java", "-war", "target/works-with-heroku-1.0.war"]


