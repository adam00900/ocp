!#bin/bash
LOCAL_REGISTRY=<registry:port>

skopeo copy dir:/media/usb/trident/netapp/trident:21.07 docker://${LOCAL_REGISTRY}/trident:21.07
skopeo copy dir:/media/usb/trident/netapp/trident-operator:21.07 docker://${LOCAL_REGISTRY}/trident-operator:21.07
skopeo copy dir:/media/usb/trident/netapp/trident-autosupport:21.01 docker://${LOCAL_REGISTRY}/trident-autosupport:21.01
skopeo copy dir:/media/usb/trident/netapp/csi-provisioner:v2.1.1 docker://${LOCAL_REGISTRY}/csi-provisioner:v2.1.1
skopeo copy dir:/media/usb/trident/netapp/csi-attacher:v3.1.0 docker://${LOCAL_REGISTRY}/trident:21.07
skopeo copy dir:/media/usb/trident/netapp/csi-resizer:v1.1.0 docker://${LOCAL_REGISTRY}/trident:21.07
skopeo copy dir:/media/usb/trident/netapp/csi-snapshotter:v4.1.1 docker://${LOCAL_REGISTRY}/trident:21.07
skopeo copy dir:/media/usb/trident/netapp/csi-node-driver-registrar:v2.1.0 docker://${LOCAL_REGISTRY}/trident:21.07
