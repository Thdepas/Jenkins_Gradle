#!/bin/bash

VERSION=`git tag --list --sort=version:refname '1*' | tail -1`

VERSION_BITS=(${VERSION//./})

MAJOR=${VERSION_BITS[0]}
MINOR=${VERSION_BITS[1]}
PATCH=${VERSION_BITS[2]}

NOTE=""

if git log -1 --pretty=%B |  -Fxq "[MAJOR]";
then
    echo "Update major version"
    NOTE="Update major version"
    MAJOR=$(($MAJOR+1))
    MINOR=0
    PATCH=0
elif git log -1 --pretty=%B | grep -Fxq "[MINOR]";
then
    echo "Update minor version"
    NOTE="Update minor version"
    MINOR=$(($MINOR+1))
    PATCH=0
else
    echo "Update patch version"
    NOTE="Update patch version"
    VNUM3=$(($PATCH+1))
fi

NEW_TAG="$MAJOR.$MINOR.$PATCH"

gh release create "$NEW_TAG" -n "$NOTE"
gh release upload "$NEW_TAG" /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher.jar