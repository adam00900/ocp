OCP_RELEASE=$1
INDEX_RELEASE=v4.7
ARCHITECTURE=x86_64
LOCAL_REGISTRY=localhost:5000
LOCAL_REPOSITORY=olm-mirror/redhat-operator-index:v4.7
PRODUCT_REPO=openshift-release-dev
LOCAL_SECRET_JSON=/root/pull.json
RELEASE_NAME=ocp-catalog

echo "Sourcing ImageContentSourcePolicy for this release"

oc adm  catalog mirror \
  localhost:5000/olm-mirror/redhat-operator-index:${INDEX_RELEASE} \
  ${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
  --insecure \
  --manifests-only \
  --index-filter-by-os='linux/amd64' \
  --to-manifests='./manifests'

echo "Mirroring operators for OCP ${OCP_RELEASE}..."

for i in $(cat manifests/mapping.txt | grep -i registry.redhat.io | awk -F "/" '{print"/" $2 "/" $3}' | awk -F "/" '{print"/" $2}' | awk '!seen[$0]++'); do mkdir /root/olm-mirror/images/$i; done

for i in $(cat manifests/mapping.txt | grep -i registry.redhat.io | awk -F "/" '{print"/" $2 "/" $3}' | awk -F "=" '{print $1}');do skopeo copy --all docker://registry.redhat.io$i dir:/root/olm-mirror/images$i; done

for i in $(cat manifests/mapping.txt | grep -i registry.redhat.io | awk -F "/" '{print $3}' | a find ./images -name $i | grep \/ || echo "File not found"; done

echo "Downloading opm client for OCP ${OCP_RELEASE}..."
wget "https://mirror.openshift.com/pub/openshift-v4/${ARCHITECTURE}/clients/ocp/${OCP_RELEASE}/opm-linux.tar.gz" -O "/root/mirror/openshift-opm-linux-${OCP_RELEASE}.tar.gz"

echo "Downloading grpcurl client ..."
wget "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.2/grpcurl_1.8.2_linux_${ARCHITECTURE}.tar.gz" -O "/root/mirror/grpcurl-1.8.2-linux.tar.gz"
