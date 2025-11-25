pipeline {
    agent any

    tools {
        maven 'M3' 
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // This 'sonar-server' name must match what you just configured in Jenkins
                withSonarQubeEnv('sonar-server') {
                    // This runs the analysis and pushes results to your SonarQube server
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package -DskipTests' 
            }
        }
    }
}