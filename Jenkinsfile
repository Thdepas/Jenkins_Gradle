pipeline {
  agent any

    stages {
        stage('Clone') {
            steps {
                 sh "rm -rf *"
                 sh "git clone https://github.com/Thdepas/Jenkins_Gradle.git"

            }
        }
        stage('Build') {
                steps {
                    sh 'cd Jenkins_Gradle && chmod +x gradlew && ./gradlew clean build'
                }
        }
        stage ('Release to Github') {
                steps {
                    sh 'cd Jenkins_Gradle && chmod +x GitTagRelease.sh && ./GitTagRelease.sh'

                }
        }
    }
}
é