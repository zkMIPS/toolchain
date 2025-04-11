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
        stage('Tarball') {
            steps {
		sh 'tar cJvf rust-staged.tar.xz rust-staged'
		sh 'sh -x tarball.sh'
            }
        }
        stage('Check') {
            steps {
		sh 'sh -x check.sh'
            }
        }
    }
}
