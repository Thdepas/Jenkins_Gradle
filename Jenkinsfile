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
                    sh """
                        VERSION=`git tag --list --sort=version:refname '1*' | tail -1`

                        VERSION_BITS=(${VERSION//./})

                        VNUM1=${VERSION_BITS[0]}
                        VNUM2=${VERSION_BITS[1]}
                        VNUM3=${VERSION_BITS[2]} """

                sh '  MAJOR=`git log --format=%B -n 1 HEAD | grep "#major"`
                      MINOR=`git log --format=%B -n 1 HEAD | grep "#minor"`
                        
                       if [ "$MAJOR" ]; 
                       then
                            echo "Update major version"
                            VNUM1=${(VNUM1+1)}
                            VNUM2=0
                            VNUM3=0
                        elif [ "$MINOR" ]; 
                        then
                            echo "Update minor version"
                            VNUM2=${(VNUM2+1)}
                            VNUM3=0
                        else
                            echo "Update patch version"
                            VNUM3=${(VNUM3+1)}
                        fi 

                        NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
                         
                        gh release create $NEW_TAG
                        gh release upload $NEW_TAG /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher.jar '

                 }
            }
    }
}




