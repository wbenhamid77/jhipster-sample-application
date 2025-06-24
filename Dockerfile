FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Étape 2 : image d'exécution
FROM openjdk:17-jdk-slim
VOLUME /tmp
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
