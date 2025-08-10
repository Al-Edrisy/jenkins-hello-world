# Jenkins Hello World Project

A simple Flask application with Jenkins CI/CD pipeline for learning purposes.

## Project Structure

```
jenkins-hello-world/
├── app.py                 # Simple Flask application
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker configuration
├── Jenkinsfile           # Jenkins pipeline definition
├── tests/
│   └── test_app.py      # Basic tests
└── README.md             # This file
```

## What This Project Demonstrates

- **Flask Web Application**: Simple "Hello from Docker!" message
- **Jenkins Pipeline**: Complete CI/CD pipeline with multiple stages
- **Docker Integration**: Containerization and testing
- **Testing**: Basic pytest setup
- **Git Operations**: Automated git commits and pushes

## Jenkins Pipeline Stages

1. **Clone Repo**: Checkout source code
2. **Install Dependencies**: Install Python packages
3. **Run Tests**: Execute pytest
4. **Build Docker Image**: Create Docker container
5. **Run Docker Container**: Test the application
6. **Custom Steps**: Git operations and file creation
7. **Build Complete**: Final success message

## Prerequisites

- Jenkins server with Docker support
- Docker installed and running
- Python 3.9+ (for local development)
- Git repository access

## Local Development

```bash
# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py

# Run tests
pytest

# Build Docker image
docker build -t jenkins-flask-app .

# Run Docker container
docker run -p 9090:9090 jenkins-flask-app
```

## Jenkins Setup

1. **Install Jenkins**: Use the official Jenkins Docker image or system package
2. **Install Plugins**: 
   - Docker Pipeline
   - Git
   - Credentials Binding
3. **Configure Credentials**: Add GitHub credentials in Jenkins
4. **Create Pipeline**: Use this repository as the source
5. **Run Pipeline**: Trigger the build manually or on code changes

## Key Learning Points

- **Pipeline Syntax**: Declarative pipeline structure
- **Docker Integration**: Running containers in Jenkins
- **Environment Variables**: Using Jenkins credentials
- **Post Actions**: Cleanup after stages
- **Git Operations**: Automated version control
- **Error Handling**: Graceful failure handling

## Customization

- Modify `app.py` to change the application
- Update `Jenkinsfile` to add new pipeline stages
- Add more tests in `tests/` directory
- Modify `Dockerfile` for different base images

## Troubleshooting

- Ensure Docker daemon is running
- Check Jenkins credentials configuration
- Verify GitHub repository access
- Monitor Jenkins logs for detailed error messages

## Next Steps

- Add more complex application logic
- Implement additional testing scenarios
- Add deployment stages to different environments
- Integrate with other tools (SonarQube, Artifactory, etc.) 