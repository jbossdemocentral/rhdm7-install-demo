#!/bin/sh
sed 's/registry.access.redhat.com\/rhdm-7/registry.access.redhat.com\/rhdm-7-tech-preview/g' rhdm70-image-streams.yaml > rhdm70-image-streams-tech-preview.yaml
