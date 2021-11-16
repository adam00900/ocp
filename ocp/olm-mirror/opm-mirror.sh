#!/bin/bash

opm index prune \
    -f registry.redhat.io/redhat/redhat-operator-index:v4.7 \
    -p cluster-logging,amq7-cert-manager-operator,elasticsearch-operator,jaeger-product,kiali-ossm,rhsso-operator,servicemeshoperator,kubevirt-hyperconverged \
    -t localhost:5000/olm-mirror/redhat-operator-index:v4.7

podman push localhost:5000/olm-mirror/redhat-operator-index:v4.7
