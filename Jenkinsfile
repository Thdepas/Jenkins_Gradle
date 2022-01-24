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
                    #!/bin/bash
                    VERSION=`git describe --abbrev=0 --tags --always`
                    VERSION_BITS=(${VERSION//./ })
                    
                    VNUM1=${VERSION_BITS[0]}
                    VNUM2=${VERSION_BITS[1]}
                    VNUM3=${VERSION_BITS[2]}
                    VNUM1=`echo $VNUM1 | sed 's/v//'`

                    MAJOR=`git log --format=%B -n 1 HEAD | grep '#major'`
                    MINOR=`git log --format=%B -n 1 HEAD | grep '#minor'`

                    if [ "$MAJOR" ]; then
                        echo "Update major version"
                        VNUM1=$((VNUM1+1))
                        VNUM2=0
                        VNUM3=0
                    elif [ "$MINOR" ]; then
                        echo "Update minor version"
                        VNUM2=$((VNUM2+1))
                        VNUM3=0
                    else
                        echo "Update patch version"
                        VNUM3=$((VNUM3+1))
                    fi

                    NEW_TAG="v$VNUM1.$VNUM2.$VNUM3"

                    echo "Updating $VERSION to $NEW_TAG"


                    GIT_COMMIT=`git rev-parse HEAD`
                    NEEDS_TAG=`git describe --contains $GIT_COMMIT --always 2>/dev/null`

                    if [ -z "$NEEDS_TAG" ]; then
                        echo "Tagged with $NEW_TAG (Ignoring fatal:cannot describe - this means commit is untagged) "
                        gh release create $NEW_TAG
                        gh release upload $NEW_TAG /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher-$NEW_TAG-SNAPSHOT.jar'
                    else
                        echo "Already a tag on this commit"
                    fi
                    ''' }
            }
    }
} 




