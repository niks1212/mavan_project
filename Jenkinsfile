pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        DOCKER_IMAGE = "niks1212/maven-demo-app"
    }

    stages {
        stage('Checkout SCM') {
            steps { checkout scm }
        }

        stage('Build with Maven') {
            steps { sh 'mvn clean package -DskipTests' }
        }

        stage('Build Docker Image') {
            steps { sh 'docker build -t $DOCKER_IMAGE .' }
        }

        stage('Push Docker Image') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Run Docker Container') {
            steps { sh 'docker run -d -p 8081:8080 --name maven-demo-container $DOCKER_IMAGE' }
        }
    }
}

