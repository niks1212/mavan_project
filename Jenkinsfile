pipeline {
    agent {
        docker {
            image 'maven:3.9.4-openjdk-17'  // Maven + Java ready
            args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock' // cache Maven deps & allow Docker commands
        }
    }

    environment {
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
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push $DOCKER_IMAGE"
            }
        }

        stage('Run Docker Container') {
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

