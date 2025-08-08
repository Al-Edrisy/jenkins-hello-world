pipeline {
    agent {
        docker {
            image 'python:3.11'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        GIT_CREDENTIALS = credentials('d1ab74e8-9583-4548-84f6-8b487952eae2')
    }
    stages {
        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'pytest'
            }
        }
        stage('Custom Steps') {
            steps {
                // Run commands individually in sh steps so they run inside Docker container
                sh 'echo "Hello World From ${BUILD_URL} By ${CHANGE_AUTHOR}"'
                sh 'ls -ltr'
                sh 'echo "1234567890123456789" > test.txt'
                sh 'ls -ltr'
                sh '''
                    git config user.name "Al-Edrisy"
                    git config user.email "salehfree33@gmailcom"
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
}
