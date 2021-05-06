#!/bin/sh

repo="http://100.26.240.37:8081"
groupId=$1
artifactId=$2
version=$3

# optional
classifier=$4
type=$5

if [[ $type == "" ]]; then
  type="jar"
fi
if [[ $classifier != "" ]]; then
  classifier="-${classifier}"
fi

groupIdUrl="${groupId//.//}"
filename="${artifactId}-${version}${classifier}.${type}"

if [[ ${version} == *"SNAPSHOT"* ]]; then repo_type="maven-snapshots"; else repo_type="maven-releases"; fi

if [[ $repo_type == "maven-releases" ]]
 then
   wget --no-check-certificate "${repo}/repository/maven-releases/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${version}${classifier}.${type}" -O ${filename} -k
 else
   versionTimestamped=$(wget -q -O- --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml" | grep -m 1 \ | sed -e 's/\(.*\)<\/value>/\1/' | sed -e 's/ //g')

   wget --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${versionTimestamped}${classifier}.${type}" -O ${filename}
 fi