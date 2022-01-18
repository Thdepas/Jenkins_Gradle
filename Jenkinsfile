pipeline {
    agent {
        // Define agent details here
    }
    environment {
        GITHUB_ACCESS_KEY_ID     = credentials('jenkins-GITHUB-secret-key-id')
        GITHUB_SECRET_ACCESS_KEY = credentials('jenkins-GITHUB-secret-access-key')
    }

    stages {
        stage('Clone') {
            steps {
                 sh "rm -rf *"
                 sh "git clone https://github.com/Thdepas/Jenkins_Gradle.git"

            }
        }
        
        stage('Build') {
            steps {
                withGradle {
                    sh 'gradle build'
                }
            }
        }
        stage('Unit Tests') {
            steps {
                    junit '**/build/test-results/test/TEST-*.xml'
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') 
            }
        }
        

       