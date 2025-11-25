pipeline {
    agent any

    tools {
        maven 'M3' 
    }

    stages {
        stage('Checkout') {
            steps {
                // This downloads your code from GitHub
                checkout scm
            }
        }
        stage('Compile') {
            steps {
                echo 'Compiling...'
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Running Tests...'
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging...'
                // Skips tests here since we just ran them
                sh 'mvn package -DskipTests' 
            }
        }
    }
}