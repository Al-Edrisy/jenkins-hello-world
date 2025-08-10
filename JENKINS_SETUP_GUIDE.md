# Jenkins Job Setup Guide

## Fix Python "Command Not Found" Issue

### **Problem Identified:**
You're currently in a Jenkins workspace called `my_python_flask_job` where Python is not available. This means your Jenkins job is **NOT** using the Docker agent from your `Jenkinsfile`.

### **Solution: Configure Jenkins Job Properly**

#### **Step 1: Check Current Job Type**

1. Go to your Jenkins dashboard
2. Click on your job (probably `my_python_flask_job`)
3. Look at the job type:
   - ✅ **Pipeline** = Good (but needs configuration)
   - ❌ **Freestyle** = Problem (needs conversion)

#### **Step 2: Convert to Pipeline Job (if Freestyle)**

If your job is currently Freestyle:

1. **Click "Configure" on your job**
2. **Scroll down to "Build" section**
3. **Change "Build" to "Pipeline"**
4. **Click "Save"**

#### **Step 3: Configure Pipeline to Use Your Jenkinsfile**

1. **Click "Configure" again**
2. **In Pipeline section, select "Pipeline script from SCM"**
3. **Choose "Git" as SCM**
4. **Repository URL**: `https://github.com/Al-Edrisy/jenkins-hello-world.git`
5. **Credentials**: Select your GitHub credentials
6. **Branch**: `main`
7. **Script Path**: `Jenkinsfile`
8. **Click "Save"**

#### **Step 4: Verify Docker Agent Configuration**

Your `Jenkinsfile` should have this agent configuration:

```groovy
agent {
    docker {
        image 'python:3.11-slim'
        args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
}
```

#### **Step 5: Test the Configuration**

1. **Click "Build Now" on your job**
2. **Check the console output**
3. **Look for the "Verify Environment" stage**
4. **You should see Python being detected**

### **Alternative: Quick Test Job**

If you want to test quickly, create a new Pipeline job:

1. **Click "New Item"**
2. **Enter name**: `test-python-pipeline`
3. **Select "Pipeline"**
4. **Click "OK"**
5. **In Pipeline section, select "Pipeline script from SCM"**
6. **Configure as in Step 3 above**
7. **Save and run**

### **Expected Output**

When working correctly, you should see:

```
[Pipeline] stage
[Pipeline] { (Verify Environment)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ echo 'Checking Python installation...'
Checking Python installation...
+ which python3
/usr/local/bin/python3
+ python3 --version
Python 3.11.x
+ which pip3
/usr/local/bin/pip3
+ pip3 --version
pip 23.x.x
```

### **If Still Not Working**

#### **Check 1: Docker on Jenkins Server**
```bash
# On your Jenkins server, run:
docker --version
docker images | grep python
```

#### **Check 2: Jenkins Plugins**
Ensure these plugins are installed:
- Docker Pipeline
- Git
- Credentials Binding

#### **Check 3: Jenkins System Configuration**
1. Go to "Manage Jenkins" → "System Configuration"
2. Check if Docker is properly configured
3. Verify Docker daemon is accessible

#### **Check 4: Node Configuration**
1. Go to "Manage Jenkins" → "Nodes"
2. Check if your job is running on the correct node
3. Verify the node has Docker access

### **Quick Commands to Run**

In your current Jenkins workspace, run these to debug:

```bash
# Check if you're in Docker container
ls -la /.dockerenv

# Check Docker availability
docker --version

# Check Python locations
find / -name python3 2>/dev/null | head -5

# Check current environment
env | grep -i python
env | grep -i docker
```

### **Common Issues and Fixes**

| Issue | Solution |
|-------|----------|
| Job not using Jenkinsfile | Convert to Pipeline job |
| Docker not available | Install Docker plugin and configure |
| Python not in container | Check Docker agent configuration |
| Wrong workspace | Verify job configuration |
| Permission issues | Check Jenkins user permissions |

### **Next Steps After Fix**

1. **Run the test job**
2. **Verify Python is available**
3. **Check all pipeline stages work**
4. **Monitor the build logs**
5. **Test the complete pipeline**

### **Need More Help?**

1. Check Jenkins system logs
2. Verify agent connectivity
3. Test with a simple pipeline first
4. Check Jenkins community forums 