# Build stage
FROM maven:3.9.6-amazoncorretto-21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml first to leverage Docker layer caching for dependencies
COPY pom.xml .

# Download dependencies (this layer will be cached if pom.xml hasn't changed)
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM amazoncorretto:21

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar .

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]