FROM maven:3.9.9-eclipse-temurin-21
RUN useradd localhelp
ENV DB_HOST = mysql
WORKDIR /app
RUN chown -R localhelp:localhelp /app
USER localhelp
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]