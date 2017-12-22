#!/bin/sh
sed 's/registry.access.redhat.com/brew-pulp-docker01.web.prod.ext.phx2.redhat.com:8888/g' rhdm70-image-streams.yaml > rhdm70-image-streams-internal.yaml

