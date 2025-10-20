pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'devad14/harness-cd-pipeline'
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Aditya-1405/harness-cd-pipeline.git', credentialsId: 'github-creds'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_HUB_REPO%:%IMAGE_TAG% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    bat '''
                    echo %PASS% | docker login -u %USER% --password-stdin
                    docker push %DOCKER_HUB_REPO%:%IMAGE_TAG%
                    '''
                }
            }
        }

        stage('Update Manifests (optional)') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'GH_USER', passwordVariable: 'GH_PASS')]) {
                    bat '''
                    powershell -Command "(Get-Content deployment\\deployment.yaml) -replace 'image: .*', 'image: %DOCKER_HUB_REPO%:%IMAGE_TAG%' | Set-Content deployment\\deployment.yaml"
                    git config user.email "jenkins@example.com"
                    git config user.name "Jenkins"
                    git add deployment\\deployment.yaml
                    git commit -m "Update image tag to %IMAGE_TAG%"
                    git push origin main
                    '''
                }
            }
        }
    }
}