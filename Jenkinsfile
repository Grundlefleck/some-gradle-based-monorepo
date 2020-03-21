pipeline {
    agent any

    stages {
        stage('Check') {
            steps {
                ./gradlew :core-domain:check
            }
        }
    }
}