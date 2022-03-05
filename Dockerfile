FROM maven AS build
RUN useradd -m -d /app roboshop
USER roboshop
WORKDIR /app
COPY src src
COPY pom.xml pom.xml
RUN mvn clean package

#Run Image
FROM httpd
RUN useradd -m -d /app roboshop
USER roboshop
WORKDIR /app
COPY src src
COPY --from=build /app/target/shipping-1.0.jar /app/target/shipping-1.0.jar
CMD ["java","-jar","target/shipping-1.0.jar"]