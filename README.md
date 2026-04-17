# Hello World Spring Boot Application

A minimal Spring Boot web application that provides a simple "Hello World" REST endpoint.

## Features

- **Hello World Endpoint**: GET `/hello` returns "Hello World"
- **Minimal Setup**: Clean, lightweight Spring Boot application
- **REST API**: Built with Spring Web

## Quick Start

### Prerequisites
- Java 21 or higher
- Maven 3.6+

### Running the Application

1. Clone or navigate to the project directory
2. Run the application:
   ```bash
   mvn spring-boot:run
   ```

3. The application will start on `http://localhost:8080`

### Testing the Endpoint

Once the application is running, test the hello endpoint:

```bash
curl http://localhost:8080/hello
```

Expected response: `Hello World`

## Project Structure

```
src/
├── main/
│   ├── java/com/sujay/demo/
│   │   ├── App.java              # Main Spring Boot application class
│   │   └── HelloController.java  # REST controller with /hello endpoint
│   └── resources/
│       └── application.properties # Spring Boot configuration
└── test/                         # (Empty - no tests currently)
```

## Technologies Used

- **Spring Boot 4.0.0** - Framework for building the web application
- **Spring Web** - For REST API functionality
- **Maven** - Build tool and dependency management
- **Java 21** - Programming language

## Docker

The application uses a multi-stage Docker build with Maven for building and AWS Corretto for runtime.

### Building the Docker Image Locally

```bash
# Build the Docker image
docker build -t hello-world-app .

# Run the container
docker run -p 8080:8080 hello-world-app
```

### Accessing the Application
Once the container is running, access the hello endpoint:
```bash
curl http://localhost:8080/hello
```

## CI/CD

This project uses GitHub Actions for continuous integration and deployment.

### Automated Docker Build and Deployment

The GitHub Actions workflow automatically:
- Builds the application with Maven
- Creates a multi-platform Docker image (AMD64 and ARM64)
- Pushes the image to Docker Hub

### Required GitHub Secrets

To enable Docker Hub deployment, add these secrets to your GitHub repository:

1. `DOCKERHUB_USERNAME` - Your Docker Hub username
2. `DOCKERHUB_TOKEN` - Your Docker Hub access token (not password)

### Creating a Docker Hub Access Token

1. Go to [Docker Hub](https://hub.docker.com/)
2. Navigate to Account Settings → Security
3. Generate a new Access Token with **Read, Write, Delete** permissions
4. Add the token as `DOCKERHUB_TOKEN` in your GitHub repository secrets

### Creating the Docker Hub Repository

Before the first build, create a repository on Docker Hub:

1. Go to [Docker Hub](https://hub.docker.com/)
2. Click "Create Repository"
3. Set the name to `hello-world-app` (or update the workflow if you prefer a different name)
4. Make it **Public** or **Private** as preferred
5. The workflow will automatically push images to `yourusername/hello-world-app`

### Workflow Triggers

The Docker build workflow runs on:
- Push to `main` branch
- Pull requests to `main` branch

### Image Tags

The workflow creates multiple tags:
- `latest` - Latest build from main branch
- Branch name - e.g., `main`
- SHA hash - For specific commits
- PR number - For pull requests
