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

This project uses GitHub Actions for complete CI/CD automation:

- **Builds** the application with Maven
- **Creates multi-platform Docker images** (AMD64 and ARM64)
- **Pushes images to Docker Hub** with proper versioning
- **Deploys to Render** automatically on main branch pushes

### Required GitHub Secrets

Add these secrets to your GitHub repository:

1. `DOCKERHUB_USERNAME` - Your Docker Hub username
2. `DOCKERHUB_TOKEN` - Your Docker Hub access token (not password)
3. `RENDER_API_KEY` - Your Render API key
4. `RENDER_SERVICE_ID` - Your Render service ID (e.g. `srv-XXXXXXXXXX`)

### Creating a Docker Hub Access Token

1. Go to [Docker Hub](https://hub.docker.com/)
2. Navigate to Account Settings → Security
3. Generate a new Access Token with **Read, Write, Delete** permissions
4. Add the token as `DOCKERHUB_TOKEN` in your GitHub repository secrets

### Setting up Render Deployment

1. **Create Render Account**: Sign up at [Render.com](https://render.com)
2. **Create a Web Service**: Click "New" → "Web Service"
3. **Configure the service**:
   - Environment: **Docker**
   - Port: `8080`
   - Auto-Deploy: **No** (deployments are triggered by GitHub Actions)
4. **Get your Render API Key**:
   - Go to Account Settings → API Keys → Create API Key
   - Add it as `RENDER_API_KEY` in your GitHub repository secrets
5. **Get your Service ID**:
   - Your service URL contains it: `https://dashboard.render.com/web/srv-XXXXXXXXXX`
   - Add the `srv-XXXXXXXXXX` value as `RENDER_SERVICE_ID` in your GitHub repository secrets

GitHub Actions will call the Render API directly to deploy the pre-built Docker image from Docker Hub, ensuring the exact same image that was built and tested is what runs in production.

### Creating the Docker Hub Repository

Before the first build, create a repository on Docker Hub:

1. Go to [Docker Hub](https://hub.docker.com/)
2. Click "Create Repository"
3. Set the name to `hello-world-app`
4. Make it **Public** or **Private** as preferred

### Post-Deployment

After successful deployment:
1. Render provides a public URL for your application
2. The `/hello` endpoint will be accessible at `https://your-app-name.onrender.com/hello`
3. You can add custom domains in the Render dashboard
4. Monitor logs and performance in the Render console

### Workflow Triggers

The CI/CD pipeline runs on:
- **Push to `main` branch**: Builds Docker image, pushes to Docker Hub, and deploys to Render
- **Pull requests to `main` branch**: Builds and tests only (no deployment)

### Image Tags

The workflow creates multiple tags:
- `latest` - Latest build from main branch
- Branch name - e.g., `main`
- SHA hash - For specific commits
- PR number - For pull requests
