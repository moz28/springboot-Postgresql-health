# Étape 1 : build du projet avec Maven
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Copier les fichiers sources
COPY pom.xml .
COPY src ./src

# Build du jar (sans tests pour accélérer)
RUN mvn clean package -DskipTests

# Étape 2 : image finale avec Java runtime
FROM eclipse-temurin:17-jre-alpine

# Copier le jar buildé depuis l'étape précédente
COPY --from=build target/*.jar app.jar

# Exposer le port sur lequel tourne ton app (ici 8089 selon ton YAML)
EXPOSE 8089

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "/app.jar"]

