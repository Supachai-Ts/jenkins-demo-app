pipeline {
    agent {
        docker {
            image 'docker:20.10.7'
            args '--entrypoint="" -u 0:0 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        HOME          = "${WORKSPACE}"
        DOCKER_CONFIG = "${WORKSPACE}/.docker"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Supachai-Ts/jenkins-demo-app.git'
            }
        }

        stage('Prep Docker Client') {
            steps {
                sh '''
                  mkdir -p "$DOCKER_CONFIG"
                  docker version
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build --platform=linux/amd64 -t jenkins-demo-app:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                  docker rm -f demo-app || true
                  docker run -d -p 5000:5000 --name demo-app jenkins-demo-app:latest
                '''
            }
        }
    }
}
