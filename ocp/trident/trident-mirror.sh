#!/bin/bash

# Kubernetes Version >> v1.20.0 | trident version >> 21.07.0
# To check what container images are needed to install Trident based on your Kubernetes current version go to https://netapp-trident.readthedocs.io/en/stable-v21.07/support/requirements.html

mkdir /media/usb/trident
mkdir /media/usb/trident/netapp
skopeo copy docker://netapp/trident:21.07 dir:/media/usb/trident/netapp/trident:21.07
skopeo copy docker://netapp/trident-operator:21.07 dir:/media/usb/trident/netapp/trident-operator:21.07
skopeo copy docker://netapp/trident-autosupport:21.01 dir:/media/usb/trident/netapp/trident-autosupport:21.01
skopeo copy docker://k8s.gcr.io/sig-storage/csi-provisioner:v2.1.1 dir:/media/usb/trident/netapp/csi-provisioner:v2.1.1
skopeo copy docker://k8s.gcr.io/sig-storage/csi-attacher:v3.1.0 dir:/media/usb/trident/netapp/csi-attacher:v3.1.0
skopeo copy docker://k8s.gcr.io/sig-storage/csi-resizer:v1.1.0 dir:/media/usb/trident/netapp/csi-resizer:v1.1.0
skopeo copy docker://k8s.gcr.io/sig-storage/csi-snapshotter:v4.1.1 dir:/media/usb/trident/netapp/csi-snapshotter:v4.1.1
skopeo copy docker://k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.1.0 dir:/media/usb/trident/netapp/csi-node-driver-registrar:v2.1.0

wget https://github.com/NetApp/trident/releases/download/v21.07.1/trident-installer-21.07.1.tar.gz
tar -xf trident-installer-21.07.1.tar.gz
cp -r ./trident-installer /media/usb/trident/
rm -rf trident-installer-21.07.1.tar.gz trident-installer
cp trident-upload.sh /media/usb/trident/
