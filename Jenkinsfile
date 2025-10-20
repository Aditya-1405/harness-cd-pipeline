pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'devad14/harness-cd-pipeline' // change this
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Aditya-1405/harness-cd-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_HUB_REPO:$IMAGE_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_HUB_REPO:$IMAGE_TAG'
                }
            }
        }

        stage('Update Manifests (optional)') {
            steps {
                sh '''
                sed -i "s|image: .*$|image: ${DOCKER_HUB_REPO}:${IMAGE_TAG}|" deployment/deployment.yaml
                git config user.email "jenkins@example.com"
                git config user.name "Jenkins"
                git add deployment/deployment.yaml
                git commit -m "Update image tag to ${IMAGE_TAG}"
                git push origin main
                '''
            }
        }
    }
}
