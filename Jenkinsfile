pipeline {
    agent {
        label 'build-angular-stable'
    }
    stages {
        stage('Checkout') {
            steps{
                dir('/root/workspace/derekpedersen-spa-angular') {
                    checkout scm
                }
            }
        }
        stage('Build') {
            steps{
                dir('/root/workspace/derekpedersen-spa-angular') {
                    sh 'make build'
                }
            }
        }
        stage('Docker') {
            steps {
                dir('/root/workspace/derekpedersen-spa-angular') {
                    sh 'make docker'
                }
            }
        }
        stage('Publish') {
            when {
                expression { env.BRANCH_NAME == 'master' }
            }
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/derekpedersen-spa-angular') {
                        sh 'make publish'
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                expression { env.BRANCH_NAME == 'master' }
            }
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/derekpedersen-spa-angular') {
                        sh 'make deploy'
                    }
                }
            }
        }
    }
}