pipeline {
    agent { dockerfile true }
    stages {
        stage('Clone') {
            steps {
		sh 'sh -x clone.sh'
            }
        }
        stage('Build') {
            steps {
		sh 'sh -x build.sh'
            }
        }
    }
}
