#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
  username=$JIAGU_USERNAME
  password=$JIAGU_PASSWORD
  apkFile=$1
else
  username=$1
  password=$2
  apkFile=$3
fi

if [ ! -n "$apkFile" ]; then
  echo "Usage: $0 username password apkFile"
fi

buildDir="`pwd`/build"

# download the program
cd ~/
if [ ! -d ".jiagu" ]; then
  mkdir ".jiagu"
fi
cd .jiagu

if test -e "master.zip"; then
  zflag=" -z master.zip"
else
  zflag=""
fi
# origin url https://github.com/msdx/360-jiagu/archive/master.zip
curl -L -e ";auto" -o master.zip $zflag http://storage.githang.com/360-jiagu/archive/master.zip 

# extract
cd $buildDir
echo "Extract master.zip"
unzip -oq ~/.jiagu/master.zip -d .
if [ ! -d "jiagu" ]; then
  mv 360-jiagu-master jiagu
else
  cp -rf 360-jiagu-master/* jiagu
fi
cd jiagu && ./init.sh || exit 1

cd $buildDir/jiagu

# login
java -jar jiagu.jar -login $username $password
# remove unnecessary service config
java -jar jiagu.jar -config -
# process
for file in `find output -name "*.apk"`; do
  rm $file;
done
echo "Start process $apkFile"
java -jar jiagu.jar -jiagu $apkFile output || exit 1
enhancedApk=`find output -name "*.apk"`
echo "The enhanced apk is: $enhancedApk"
