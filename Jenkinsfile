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
                    sh '''
                        gh release create 1.0.2
                        gh release upload 1.0.2 /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher-*-SNAPSHOT.jar
                    ''' }
            }
    }
} 




