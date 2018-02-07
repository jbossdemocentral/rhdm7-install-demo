Red Hat Decision Manager 7 Install Demo
=======================================
Project to automate the installation of this product without preconfiguration beyond a single admin user.

There are four options available to you for using this demo; local, Docker, Openshift Online and Red Hat CDK OpenShift Enterprise.

Software
--------
The following software is required to run this demo:
- [JBoss EAP 7.1 zip archive](https://developers.redhat.com/download-manager/file/jboss-eap-7.1.0.zip)
- [Red Hat Decision Manager: Decision Central 7.0.0.GA deployable for EE7](https://upload.wikimedia.org/wikipedia/commons/6/67/Learning_Curve_--_Coming_Soon_Placeholder.png)
- [Red Hat Decision Manager: KIE-Server 7.0.0.GA deployable for EE7](https://upload.wikimedia.org/wikipedia/commons/6/67/Learning_Curve_--_Coming_Soon_Placeholder.png)
- [7-Zip](http://www.7-zip.org/download.html) (Windows only): to overcome the Windows 260 character path length limit, we need 7-Zip to unzip the Decision Manager deployable.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/jbossdemocentral/rhdm7-install-demo/archive/master.zip)

2. Add the EAP zip archive and Decision Manager deployables to installs directory.

3. Run 'init.sh' or 'init.ps1' file.

4. Start the runtime: `./target/jboss-eap-7.1/bin/standalone.sh'` or `.\target\jboss-eap-7.1\bin\standalone.ps1`

5. Login to http://localhost:8080/decision-central  (u:dmAdmin / p:redhatdm1!)

6. Enjoy installed and configured Red Hat Decision Manager 7.


Option 2 - Run in Docker
-----------------------------------------
The following steps can be used to configure and run the demo in a container

1. [Download and unzip.](https://github.com/jbossdemocentral/rhdm7-install-demo/archive/master.zip)

2. Add the EAP zip archive and Decision Manager deployables to installs directory.

3. Run the 'init-docker.sh' or 'init-docker.ps1' file.

4. Start the container: `docker run -it -p 8080:8080 -p 9990:9990 jbossdemocentral/rhdm7-install-demo`

5. Login to http://&lt;DOCKER_HOST&gt;:8080/decision-central  (u:dmAdmin / p:redhatdm1!)

7. Enjoy installed and configured Red Hat Decision Manager7.


Option 3 - Install on OpenShift
-----------------------------------------------------
OpenShift can be installed several ways, so the following instructions only depend upon the `oc` client being connected to an instance of OpenShift.

**To deploy this demo:**

1. Clone this repo: https://github.com/jbossdemocentral/rhdm7-install-demo
2. Within the cloned directory, `cd` into `support/openshift`
3. Run `./provision.sh setup rhdm7-install --with-imagestreams true`

The `--with-imagestreams true` parameter installs the DM7 image streams and templates into the project namespace instead of the `openshift` namespace (for which you need admin rights). If you already have the required image-streams and templates installed in your OpenShift environment in the `openshift` namespace, you can omit the `--with-imagestreams true` from the setup command.

NOTE: One of the demo images expects a [Persistent Volume](https://docs.openshift.com/container-platform/3.6/architecture/additional_concepts/storage.html) which has both `ReadWriteOnce` (RWO) *and* `ReadWriteMany` (RWX) Access Types. If no PVs matching this description are available, deployment of that image will fail until a PV of that type is available.

**To undeploy this demo:**

1. Run `./provision delete rhdm7-install`

Supporting Articles
-------------------
- [Red Hat Decision Manager 7 released: How to get started in 3 easy steps](https://upload.wikimedia.org/wikipedia/commons/6/67/Learning_Curve_--_Coming_Soon_Placeholder.png)

Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - Red Hat Decision Manager 7.0.0.GA, installed on JBoss EAP 7.1.0.


![JBoss BRMS](https://github.com/jbossdemocentral/rhdm7-install-demo/blob/master/support/rhdm7.png?raw=true)
