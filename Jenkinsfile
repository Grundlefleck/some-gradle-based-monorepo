pipeline {
    agent any

    stages {
        stage('Check') {
            steps {
                sh './gradlew :core-domain:check'
            }
        }
    }
}