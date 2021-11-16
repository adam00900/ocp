OCP_RELEASE=$1
ARCHITECTURE=x86_64
LOCAL_REGISTRY=localhost:5000
LOCAL_REPOSITORY=ocp-release/openshift4
PRODUCT_REPO=openshift-release-dev
LOCAL_SECRET_JSON=/root/pull.json
RELEASE_NAME=ocp-release

echo "Sourcing ImageContentSourcePolicy for this release"

oc adm -a ${LOCAL_SECRET_JSON} release mirror \
  --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
  --to-dir=/media/usb/mirror \
  --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
  --to-release-image=${LOCAL_REGISTRY}/openshift/release-image \
  --dry-run > /media/usb/mirror/icsp.txt

echo "Mirroring containers for OCP ${OCP_RELEASE}..."

oc adm -a ${LOCAL_SECRET_JSON} release mirror \
  --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
  --to-dir=/media/usb/mirror

echo "Downloading oc client for OCP ${OCP_RELEASE}..."
wget "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${OCP_RELEASE}/openshift-client-linux.tar.gz" -O "/media/usb/mirror/openshift-client-linux-${OCP_RELEASE}.tar.gz"

echo "Downloading openshift-install client for OCP ${OCP_RELEASE}..."
wget "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${OCP_RELEASE}/openshift-install-linux.tar.gz" -O "/media/usb/mirror/openshift-install-linux-${OCP_RELEASE}.tar.gz"
