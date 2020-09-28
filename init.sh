#!/bin/sh 
DEMO="Install Demo"
AUTHORS="Red Hat"
PROJECT="git@github.com:jbossdemocentral/rhdm7-install-demo.git"
PRODUCT="Red Hat Decision Manager"
JBOSS_HOME=./target/jboss-eap-7.3
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects
VERSION_EAP=7.3.0
VERSION=7.8.0
EAP=jboss-eap-$VERSION_EAP.zip
RHDM=rhdm-$VERSION-decision-central-eap7-deployable.zip
KIESERVER=rhdm-$VERSION-kie-server-ee8.zip

# wipe screen.
clear 

echo
echo "###############################################################"
echo "##                                                           ##"   
echo "##  Setting up the ${DEMO}                              ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##         ####  ##### ####     #   #  ###  #####            ##"
echo "##         #   # #     #   #    #   # #   #   #              ##"
echo "##         ####  ###   #   #    ##### #####   #              ##"
echo "##         #  #  #     #   #    #   # #   #   #              ##"
echo "##         #   # ##### ####     #   # #   #   #              ##"
echo "##                                                           ##"   
echo "##     ####  #####  #### #####  #### #####  ###  #   #       ##"   
echo "##     #   # #     #       #   #       #   #   # ##  #       ##"   
echo "##     #   # ###   #       #    ###    #   #   # # # #       ##"   
echo "##     #   # #     #       #       #   #   #   # #  ##       ##"   
echo "##     ####  #####  #### ##### ####  #####  ###  #   #       ##"   
echo "##                                                           ##"   
echo "##       #   #  ###  #   #  ###  ##### ##### ####            ##"
echo "##       ## ## #   # ##  # #   # #     #     #   #           ##"
echo "##       # # # ##### # # # ##### #  ## ###   ####            ##"
echo "##       #   # #   # #  ## #   # #   # #     #  #            ##"
echo "##       #   # #   # #   # #   # ##### ##### #   #           ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##  brought to you by, ${AUTHORS}                               ##"   
echo "##                                                           ##"   
echo "##  ${PROJECT}   ##"
echo "##                                                           ##"   
echo "###############################################################"
echo

# make some checks first before proceeding.	

if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
	echo "Product EAP sources are present..."
	echo
else
	echo "Need to download $EAP package from https://developers.redhat.com/products/eap/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

if [ -r $SRC_DIR/$RHDM ] || [ -L $SRC_DIR/$RHDM ]; then
	echo "Product RHDM sources are present..."
	echo
else
	echo "Need to download $RHDM from https://developers.redhat.com/products/red-hat-decision-manager/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

if [ -r $SRC_DIR/$KIESERVER ] || [ -L $SRC_DIR/$KIESERVER ]; then
	echo "Product RHDM Kie Server sources are present..."
	echo
else
	echo "Need to download $KIESERVER from https://developers.redhat.com/products/red-hat-decision-manager/download"
	echo "and place it in the $SRC_DIR directory to proceed..."
	echo
	exit
fi

# Remove the old JBoss instance, if it exists.
if [ -x $JBOSS_HOME ]; then
	echo "  - removing existing installation directory..."
	echo
	rm -rf ./target
fi

# Installation.
echo "JBoss EAP installation running now..."
echo
mkdir -p ./target
unzip -qo $SRC_DIR/$EAP -d ./target

if [ $? -ne 0 ]; then
	echo "Error occurred during JBoss EAP installation!"
	echo
	exit
fi

echo "Red Hat Decision Manager installation running now..."
echo
unzip -qo $SRC_DIR/$RHDM -d ./target 

if [ $? -ne 0 ]; then
	echo "Error occurred during $PRODUCT installation!"
	echo
	exit
fi

echo "Red Hat Decision Manager KIE Server installation running now..."
echo
unzip -qo $SRC_DIR/$KIESERVER -d $JBOSS_HOME/standalone/deployments 

if [ $? -ne 0 ]; then
	echo "Error occurred during $PRODUCT installation!"
	echo
	exit
fi

# Set deployment Kie Server.
touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy

echo "  - enabling demo accounts role setup..."
echo
echo "  - User 'dmAdmin' password 'redhatdm1!' setup..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u dmAdmin -p redhatdm1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent 

if [ $? -ne 0 ]; then
	echo "Error occurred during user add dmAdmin!"
	echo
	exit
fi

echo "  - management user 'kieserver' password 'kieserver1!' setup..."
echo
$JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server,rest-all --silent

if [ $? -ne 0 ]; then
	echo "Error occurred during user add kieserver!"
	echo
	exit
fi

echo "  - setting up standalone-full.xml configuration adjustments..."
echo
cp $SUPPORT_DIR/standalone-full.xml $SERVER_CONF/standalone.xml

echo "  - setup email notification users..."
echo
cp $SUPPORT_DIR/userinfo.properties $SERVER_DIR/decision-central.war/WEB-INF/classes/

echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo
echo "==========================================================================="
echo "=                                                                         ="
echo "=  $PRODUCT $VERSION setup complete.                         ="
echo "=                                                                         ="
echo "=  You can now start the $PRODUCT with:                   ="
echo "=                                                                         ="
echo "=                         $SERVER_BIN/standalone.sh        ="
echo "=                                                                         ="
echo "=  Login to Red Hat Decision Manager to start developing rules projects:  ="
echo "=                                                                         ="
echo "=  http://localhost:8080/decision-central                                 ="
echo "=                                                                         ="
echo "=  [ u:dmAdmin / p:redhatdm1! ]                                           ="
echo "=                                                                         ="
echo "=  See README.md for general details.                                     ="
echo "=                                                                         ="
echo "==========================================================================="
echo
