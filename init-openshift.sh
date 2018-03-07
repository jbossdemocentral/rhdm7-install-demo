#!/bin/sh

function echo_header() {
  echo
  echo "########################################################################"
  echo $1
  echo "########################################################################"
}

PRJ_DEMO_NAME=$(./support/openshift/provision.sh info rhdm7-install | awk '/Project name/{print $3}')

# Check if the project exists
oc get project $PRJ_DEMO_NAME > /dev/null 2>&1
PRJ_EXISTS=$?

if [ $PRJ_EXISTS -eq 0 ]; then
   echo_header "RHDM7 Install Demo project already exists. Deleting project."
   ./support/openshift/provision.sh delete rhdm7-install
   # Wait until the project has been removed
   echo_header "Waiting for OpenShift to clean deleted project."
   sleep 20
else if [ ! $PRJ_EXISTS -eq 1 ]; then
	echo "An error occurred communicating with your OpenShift instance."
	echo "Please make sure that your logged in to your OpenShift instance with your 'oc' client."
  exit 1
  fi
fi

echo_header "Provisioning Red Hat Decision Manager 7 Install Demo."
./support/openshift/provision.sh setup rhdm7-install --with-imagestreams
echo_header "Setup completed."
