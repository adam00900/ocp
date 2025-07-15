## Openshift Release Mirror

1. Please make sure Docker is installed 

1. Download valid pull-secret 

1. Prepare imageset-config.yaml

1. run the release-mirror script 

   ```bash
   bash release-mirror.sh
   ```

1. run the run-registry script 

   ```bash
   bash run-registry.sh
   ``` 
   
1. copy images to local registry(example)

   ```bash
   oc-mirror --dest-skip-tls --dest-use-http --from=./ocp-release/mirror/mirror_seq1_000000.tar docker://localhost:5000
   ```

