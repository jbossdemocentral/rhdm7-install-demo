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
Coming soon.


Supporting Articles
-------------------
- [Red Hat Decision Manager 7 released: How to get started in 3 easy steps](https://upload.wikimedia.org/wikipedia/commons/6/67/Learning_Curve_--_Coming_Soon_Placeholder.png)

Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - Red Hat Decision Manager 7.0.0.GA, installed on JBoss EAP 7.1.0.


![JBoss BRMS](https://github.com/jbossdemocentral/rhdm7-install-demo/blob/master/support/rhdm7.png?raw=true)
