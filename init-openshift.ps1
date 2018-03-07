Function Write-Host-Header($echo) {
  Write-Output ""
  Write-Output "########################################################################"
  Write-Output "$echo"
  Write-Output "########################################################################"
}

$PRJ_DEMO_NAME=((./support/openshift/provision.ps1 info rhdm7-install 2>&1 | Select-String -Pattern "Project name") -split "\s+")[2]

Write-Host "Project Demo Name: $PRJ_DEMO_NAME "

# Check if the project exists
#oc get project $PRJ_DEMO_NAME > $null 2>&1
oc get project $PRJ_DEMO_NAME > $null 2>&1
$PRJ_EXISTS=$?

if ($PRJ_EXISTS) {
  Write-Output "$PRJ_DEMO_NAME already exists. Deleting project."
  ./support/openshift/provision.ps1 -command delete -demo rhdm7-install

  # Wait until the project has been removed.
  Write-Output "Waiting for OpenShift to clean deleted project."
  Start-Sleep -s 20
}

Write-Output "Provisioning Red Hat Decision Manager 7 Install Demo."
./support/openshift/provision.ps1 -command setup -demo rhdm7-install -with-imagestreams
Write-Output "Setup completed."
