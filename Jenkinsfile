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
        stage('Build & Push Docker') {
            steps {
                script {
                    // Uses the credentials ID you just created: 'docker-hub-credentials'
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        
                        // Replace 'YOUR_USERNAME' with your actual Docker Hub username!
                        // We tag the image with the Build ID so every version is unique
                        def customImage = docker.build("anirachibane/ywti-project:${env.BUILD_ID}")
                        
                        // Push the image to Docker Hub
                        customImage.push()
                        
                        // Also push it as 'latest' so it's easy to find
                        customImage.push('latest')
                    }
                }
            }
        }
    }
}