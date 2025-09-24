pipeline {
    agent any

    environment {
        // Use the credentials ID you created in Jenkins
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        IMAGE_NAME = 'yourdockerhubusername/demo-app'
    }

    stages {
        stage('Pull from GitHub') {
            steps {
                // Pull code from the main branch
                git branch: 'master', url: 'https://github.com/niks1212/mavan_project.git'
            }
        }

        stage('Build with Maven') {
            steps {
                // Build the Maven project
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Login to Docker Hub using credentials
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $IMAGE_NAME:latest'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Stop and remove old container if exists
                sh 'docker stop demo-app || true'
                sh 'docker rm demo-app || true'

                // Run new container
                sh 'docker run -d -p 8081:8080 --name demo-app $IMAGE_NAME:latest'
            }
        }
    }

    triggers {
        // Automatically trigger on GitHub push
        githubPush()
    }
}

