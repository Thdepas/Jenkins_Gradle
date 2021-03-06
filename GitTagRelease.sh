#!/bin/bash

unset VERSION

VERSION=`git for-each-ref --format="%(refname:short)" --sort=-authordate --count=1 refs/tags`

VERSION_BITS=${VERSION//./}

MAJOR="${VERSION_BITS:0:1}"
MINOR="${VERSION_BITS:1:1}"
PATCH="${VERSION_BITS:2:1}"

NOTE=""

if git log -1 --pretty=%B |  grep -i "MAJOR";
then
    echo "Update major version"
    NOTE="Update major version"
    MAJOR=$((MAJOR+1))
    MINOR=0
    PATCH=0
elif git log -1 --pretty=%B | grep -i "MINOR";
then
    echo "Update minor version"
    NOTE="Update minor version"
    MINOR=$((MINOR+1))
    PATCH=0
elif git log -1 --pretty=%B | grep -i "PATCH";
then
    echo "Update patch version"
    NOTE="Update patch version"
    PATCH=$((PATCH+1))
else
    MINOR=$((MINOR+1))
    echo "Update minor version"
    NOTE="Update minor version"

fi

NEW_TAG="$MAJOR.$MINOR.$PATCH"

echo $NEW_TAG

gh release create "$NEW_TAG" -n "$NOTE"
gh release upload "$NEW_TAG" /var/jenkins_home/workspace/Caersar/Jenkins_Gradle/build/libs/caesars-cipher.jar


