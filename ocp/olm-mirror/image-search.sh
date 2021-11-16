#!/bin/bash

#for i in $(cat manifests/mapping.txt | grep -i registry.redhat.io | awk -F "/" '{print $3}' | awk -F "=" '{print $1}'); do if [ find /media/usb/ocp4.6/olm-mirror/images -name $i | grep \/ ]; then echo "$i"; fi; done
for i in $(cat manifests/mapping.txt | grep -i registry.redhat.io | awk -F "/" '{print"/" $2 "/" $3}' | awk -F "=" '{print $1}'); do    
FILE=/media/usb/ocp4.6/olm-mirror/images/$i
if [ ! -d "$FILE" ]; then	
    skopeo copy --all docker://registry.redhat.io$i dir:/media/usb/ocp4.6/olm-mirror/images$i 
fi;
done


 	
