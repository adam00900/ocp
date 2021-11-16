#!/bin/bash

source trident-source.sh
podman pull $trident
podman pull $trident_operator
podman pull $trident_autosupport
podman pull $csi_provisioner
podman pull $csi_attacher
podman pull $csi_resizer
podman pull $csi_snapshotter
podman pull $csi_node_driver_registrar

podman save -o /media/usb/trident/trident.tar --format oci-archive $trident
podman save -o /media/usb/trident/trident_operator.tar --format oci-archive $trident_operator
podman save -o /media/usb/trident/trident._autosupport.tar --format oci-archive $trident_autosupport
podman save -o /media/usb/trident/csi-provisioner.tar --format oci-archive $csi_provisioner
podman save -o /media/usb/trident/csi-attacher.tar --format oci-archive $csi_attacher
podman save -o /media/usb/trident/csi-resizer.tar --format oci-archive $csi_resizer
podman save -o /media/usb/trident/csi-snapshotter.tar --format oci-archive $csi_snapshotter
podman save -o /media/usb/trident/csi-node-driver-registrar.tar --format oci-archive $csi_node_driver_registrar

wget https://github.com/NetApp/trident/releases/download/v21.07.1/trident-installer-21.07.1.tar.gz
tar -xf trident-installer-21.07.1.tar.gz
cp -r ./trident-installer /media/usb/trident/
rm -rf trident-installer-21.07.1.tar.gz trident-installer
