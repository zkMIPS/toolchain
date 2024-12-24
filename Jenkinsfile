pipeline {
    agent { dockerfile true }
    environment {
        PATH="/home/jenkins/.cargo/bin:${env.PATH}"
    }
    stages {
        stage('Rustup') {
            steps {
		sh 'pwd'
		sh 'echo $PATH'
		sh 'id'
		sh 'rustc --version'
		sh 'which rustc'
            }
        }
    }
}
