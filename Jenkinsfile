pipeline {
    agent {
        docker {
            image 'python:3.11-slim'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        GIT_CREDENTIALS = credentials('d1ab74e8-9583-4548-84f6-8b487952eae2')
        PYTHONPATH = "${WORKSPACE}"
    }
    stages {
        stage('Verify Environment') {
            steps {
                script {
                    echo "Checking Python installation..."
                    sh '''
                        which python3
                        python3 --version
                        which pip3
                        pip3 --version
                        echo "Current directory: $(pwd)"
                        echo "Python path: $PYTHONPATH"
                        ls -la
                    '''
                }
            }
        }
        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh '''
                    pip3 install --upgrade pip
                    pip3 install -r requirements.txt
                    pip3 list
                '''
            }
        }
        stage('Run Tests') {
            steps {
                sh '''
                    python3 -m pytest tests/ -v
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                sh '''
                    docker --version
                    docker build -t jenkins-flask-app .
                    docker images | grep jenkins-flask-app
                '''
            }
        }
        stage('Run Docker Container') {
            steps {
                sh '''
                    docker run -d --name flask-app -p 9090:9090 jenkins-flask-app
                    sleep 5
                    curl -f http://localhost:9090 || echo "Container health check failed"
                '''
            }
            post {
                always {
                    sh '''
                        docker stop flask-app || true
                        docker rm flask-app || true
                    '''
                }
            }
        }
        stage('Custom Steps') {
            steps {
                sh '''
                    echo "Hello World From ${BUILD_URL} By ${CHANGE_AUTHOR}"
                    ls -ltr
                    echo "1234567890123456789" > test.txt
                    ls -ltr
                '''
                sh '''
                    git config user.name "Al-Edrisy"
                    git config user.email "salehfree33@gmail.com"
                    git add test.txt
                    git commit -m "We add the test file." || echo "No changes to commit"
                    git remote set-url origin https://${GIT_CREDENTIALS_USR}:${GIT_CREDENTIALS_PSW}@github.com/Al-Edrisy/jenkins-hello-world.git
                    git push origin main || echo "Push failed, check credentials"
                '''
            }
        }
        stage('Build Complete') {
            steps {
                echo 'Build finished successfully!'
            }
        }
    }
    post {
        always {
            echo "Build completed with result: ${currentBuild.result}"
            sh '''
                echo "Cleaning up workspace..."
                docker system prune -f || true
            '''
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed! Check the logs for details."
        }
    }
}
