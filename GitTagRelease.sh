#!/bin/bash

VERSION=`git tag --list --sort=version:refname '1*' | tail -1`

VERSION_BITS=(${VERSION//./})

VNUM1=${VERSION_BITS[0]}
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}

NOTE=""

MAJOR=`git log -1 --pretty=%B | grep -i "major"`
MINOR=`git log -1 --pretty=%B | grep -i "minor"`

if [ "$MAJOR" ];
then
    echo "Update major version"
    NOTE="Update major version"
    VNUM1=$(($VNUM1+1))
    VNUM3=0
elif [  "$MINOR" ];
then
    echo "Update minor version"
    NOTE="Update minor version"
    VNUM2=$(($VNUM2+1))
    VNUM3=0
else
    echo "Update patch version"
    NOTE="Update patch version"
    VNUM3=$(($VNUM3+1))
fi

NEW_TAG="$VNUM1.$VNUM2.$VNUM3"

echo $NEW_TAG
echo $VERSION

gh release create "$NEW_TAG" -n "$NOTE"
gh release upload "$NEW_TAG" /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher.jar