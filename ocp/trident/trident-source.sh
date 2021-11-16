#!/bin/bash

# Kubernetes Version >> v1.20.0 | trident version >> 21.07.0
# To check what container images are needed to install Trident based on your Kubernetes current version go to https://netapp-trident.readthedocs.io/en/stable-v21.07/support/requirements.html

trident="netapp/trident:21.07.0"
trident_operator="netapp/trident-operator:21.07.0"
trident_autosupport="netapp/trident-autosupport:21.01"
csi_provisioner="k8s.gcr.io/sig-storage/csi-provisioner:v2.1.1"
csi_attacher="k8s.gcr.io/sig-storage/csi-attacher:v3.1.0"
csi_resizer="k8s.gcr.io/sig-storage/csi-resizer:v1.1.0"
csi_snapshotter="k8s.gcr.io/sig-storage/csi-snapshotter:v4.1.1"
csi_node_driver_registrar="k8s.gcr.io/sig-storage/csi-node-driver-registrar:v2.1.0"
