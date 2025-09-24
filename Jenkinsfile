pipeline {
    agent any

    environment {
        PATH = "/usr/share/maven/bin:${env.PATH}"  // Ensure Maven is found
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        DOCKER_IMAGE = "niks1212/maven-demo-app"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            when {
                expression {
                    // Check if docker is available
                    sh(script: "which docker", returnStatus: true) == 0
                }
            }
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            when {
                expression { sh(script: "which docker", returnStatus: true) == 0 }
            }
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push $DOCKER_IMAGE"
            }
        }

        stage('Run Docker Container') {
            when {
                expression { sh(script: "which docker", returnStatus: true) == 0 }
            }
            steps {
                sh """
                docker rm -f maven-demo-container || true
                docker run -d -p 8081:8080 --name maven-demo-container $DOCKER_IMAGE
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}

