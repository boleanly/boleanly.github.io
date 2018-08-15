#!/bin/bash

NEW_VERSION=$1

if [ -z "${NEW_VERSION}" ]; then
  read -p "Enter a new release version: "  NEW_VERSION
fi

echo "New Release Version ${NEW_VERSION}"

# Grab current version from index.html
CURRENT_VERSION=$(cat ../index.html | grep 'Current Version' | sed "s/.*<h1>.*: //" | sed "s/<\/h1>//" | sed "s/\r$//")
echo "Current Release: ${CURRENT_VERSION}"


# Replace current release with new release
git grep -l "${CURRENT_VERSION}" ../ | grep -v ../plugin.video.icdrama-boleanly/index.html | xargs sed -i "s/${CURRENT_VERSION}/${NEW_VERSION}/g"

# Create a new release zip
find plugin.video.icdrama-boleanly -type f -print | grep -v ".git" | zip -@ ../plugin.video.icdrama-boleanly/plugin.video.icdrama-boleanly-${NEW_VERSION}.zip

# Update Release index.html and MD5 hash
pushd ../plugin.video.icdrama-boleanly/
  ../src/kodidirlist.py > index.html
popd

md5=($(md5sum ../addons.xml))
echo -n $md5 > ../addons.xml.md5

eval `grep "repository.boleanly-kodi-repo" repository.boleanly-kodi-repo/addon.xml | awk '{print $3}'`
find repository.boleanly-kodi-repo -type f -print | grep -v ".git" | zip -@ ../repo/repository.boleanly-kodi-repo-$version.zip

# Update repo Release index.html and MD5 hash
pushd ../repo/
  ../src/kodidirlist.py > index.html
popd
echo
read -p "Press enter to continue..."