#!/bin/bash

set -e 

if [ "${DEBUG}" = 1 ]; then
  set -x
fi

trap 'bak_files' ERR
trap 'bak_files' EXIT

BDIR="$(dirname "$(readlink -f "$0")")"
OCP_RELEASE=4.14.31
OCP=$(echo ${OCP_RELEASE} | awk -F. '{print $1"."$2}')
REMOVABLE_MEDIA_PATH=/mnt
ARCHITECTURE=x86_64
LOCAL_REGISTRY=registry.domain:5000
LOCAL_REPOSITORY=ocp4/openshift4
PRODUCT_REPO=openshift-release-dev
LOCAL_SECRET_JSON=~/.docker/config.json
RELEASE_NAME=ocp-release

### please make sure docker is installed 
### download pull-secret file before you run the script
pull_secret()
{
  cat $BDIR/pull-secret.txt | jq . > $BDIR/pull.json
  sudo rsync $BDIR/pull.json ~/.docker/config.json
  rm -rf $BDIR/pull.json
}

oc_client()
{
  echo "Downloading oc client for OCP ${OCP_RELEASE}..."
  wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/openshift-client-linux.tar.gz" -O "$BDIR/openshift-client-linux-${OCP_RELEASE}.tar.gz"	
  tar -xvf $BDIR/openshift-client-linux-${OCP_RELEASE}.tar.gz
  sudo rsync -rv $BDIR/oc /usr/local/bin/
  sudo rsync -rv $BDIR/kubectl /usr/local/bin/
  sudo rm -rf $BDIR/oc $BDIR/kubectl $BDIR/README.md $BDIR/openshift-client-linux-${OCP_RELEASE}.tar.gz
}

copy_client()
{
  mkdir -p $BDIR/${OCP_RELEASE}/openshift-tools

  echo "Downloading oc client for OCP ${OCP_RELEASE}..."
  wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/openshift-client-linux.tar.gz" -O "$BDIR/${OCP_RELEASE}/openshift-tools/openshift-client-linux-${OCP_RELEASE}.tar.gz"

  echo "Downloading openshift-install client for OCP ${OCP_RELEASE}..."
  wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/openshift-install-linux.tar.gz" -O "$BDIR/${OCP_RELEASE}/openshift-tools/openshift-install-linux-${OCP_RELEASE}.tar.gz"

  echo "Downloading oc-mirror for OCP ${OCP_RELEASE}..."
  wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/oc-mirror.tar.gz" -O "$BDIR/${OCP_RELEASE}/openshift-tools/oc-mirror-${OCP_RELEASE}.tar.gz"
}

oc_mirror()
{
  echo "Downloading oc-mirror for OCP ${OCP_RELEASE}..."
  wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/oc-mirror.tar.gz" -O "$BDIR/oc-mirror-${OCP_RELEASE}.tar.gz"
  tar -xvf $BDIR/oc-mirror-${OCP_RELEASE}.tar.gz
  sudo rsync -rv $BDIR/oc-mirror /usr/local/bin/
  sudo rm -rf $BDIR/oc-mirror $BDIR/oc-mirror-${OCP_RELEASE}.tar.gz
  sudo chmod +x /usr/local/bin/oc-mirror
}

### prepare imageset-config.yaml before you proceed
mirror_images()
{
  mkdir -p $BDIR/${OCP_RELEASE}/metadata
  mkdir -p $BDIR/${OCP_RELEASE}/mirror
  sed -i.bak "s/ocp-release/${OCP_RELEASE}/g" $BDIR/imageset-config.yaml
  sed -i "s/ocp-version/${OCP}/g" $BDIR/imageset-config.yaml
  oc-mirror --config=$BDIR/imageset-config.yaml file://${OCP_RELEASE}/mirror
}
### run run-registry.sh
### oc-mirror --dest-skip-tls --dest-use-http --from=./ocp-release/mirror/mirror_seq1_000000.tar docker://localhost:5000 ## copy iamges to local registry

bak_files()
{
  mv $BDIR/imageset-config.yaml.bak $BDIR/imageset-config.yaml || true	
}


do_install()
{
  pull_secret
  oc_client
  copy_client
  oc_mirror
  mirror_images
}

do_install

exit 0
