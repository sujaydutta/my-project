# Use the official AWS Corretto 21 image as the base image
FROM amazoncorretto:21

# Install Maven
RUN yum update -y && \
    yum install -y maven && \
    yum clean all

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

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]