# Jenkins Troubleshooting Guide

## Python Not Found Issue

If you're getting "command not found" errors for Python in Jenkins, here are the solutions:

### 1. Check Jenkins Job Configuration

Make sure your Jenkins job is configured to use the correct agent:

- **Pipeline**: Should use the `Jenkinsfile` with Docker agent
- **Freestyle**: Should be configured to run on the same executor as your pipeline
- **Agent**: Verify the job is running on the correct Jenkins node

### 2. Verify Docker Agent is Working

The `Jenkinsfile` uses a Docker agent with `python:3.11-slim`. If Python is not available:

```bash
# Check if Docker is running
docker --version

# Check if the Python image exists
docker images | grep python

# Pull the image manually if needed
docker pull python:3.11-slim
```

### 3. Check Jenkins Executor

If you're running commands manually in Jenkins console:

```bash
# Check which executor you're on
echo $NODE_NAME
echo $EXECUTOR_NUMBER

# Check if you're in the right workspace
pwd
ls -la
```

### 4. Manual Python Installation (if needed)

If you must run on a non-Docker agent, install Python manually:

```bash
# For Ubuntu/Debian
sudo apt-get update
sudo apt-get install python3 python3-pip

# For CentOS/RHEL
sudo yum install python3 python3-pip

# For macOS (if using Jenkins on Mac)
brew install python3
```

### 5. Use Virtual Environment

Create and activate a Python virtual environment:

```bash
# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 6. Check PATH and Aliases

```bash
# Check Python location
which python3
which python

# Check PATH
echo $PATH

# Check aliases
alias | grep python
```

### 7. Common Solutions

#### Solution 1: Use Full Paths
```bash
/usr/bin/python3 --version
/usr/bin/pip3 install -r requirements.txt
```

#### Solution 2: Create Symlinks
```bash
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/pip3 /usr/bin/pip
```

#### Solution 3: Use pyenv
```bash
# Install pyenv
curl https://pyenv.run | bash

# Install Python
pyenv install 3.11.0
pyenv global 3.11.0
```

### 8. Jenkins Configuration Issues

Check these Jenkins settings:

1. **Global Tool Configuration**: Ensure Python is configured as a tool
2. **Node Configuration**: Verify the node has Python installed
3. **Plugin Issues**: Update Jenkins and plugins
4. **Permission Issues**: Check file permissions and user access

### 9. Debug Commands

Add these to your pipeline for debugging:

```groovy
stage('Debug') {
    steps {
        sh '''
            echo "=== Environment Debug ==="
            echo "PATH: $PATH"
            echo "PYTHONPATH: $PYTHONPATH"
            echo "Current user: $(whoami)"
            echo "Current directory: $(pwd)"
            echo "Python locations:"
            which python3 || echo "python3 not found"
            which python || echo "python not found"
            echo "Docker info:"
            docker --version || echo "Docker not available"
        '''
    }
}
```

### 10. Quick Fix Checklist

- [ ] Verify Jenkins job uses the correct `Jenkinsfile`
- [ ] Check if Docker agent is working
- [ ] Ensure Python image is pulled
- [ ] Verify workspace and executor
- [ ] Check PATH and Python installation
- [ ] Use explicit Python commands (`python3`, `pip3`)
- [ ] Check Jenkins logs for errors

### 11. Alternative Approaches

If Docker agent continues to fail:

1. **Use Jenkins agent with pre-installed Python**
2. **Use shell agent with manual Python setup**
3. **Use cloud agents (AWS, Azure, GCP)**
4. **Use containerized Jenkins with Python support**

## Still Having Issues?

1. Check Jenkins system logs
2. Verify agent connectivity
3. Test with a simple pipeline first
4. Check Jenkins community forums
5. Review Jenkins documentation for your version 