#!/bin/sh
. ./init-properties.sh

# wipe screen.
clear

echo
echo "#################################################################"
echo "##                                                             ##"
echo "##  Setting up the ${DEMO}       ##"
echo "##                                                             ##"
echo "##                                                             ##"
echo "##     ####  #   # ####    #   #   #####    #   #              ##"
echo "##     #   # #   # #   #  # # # #     #      # #               ##"
echo "##     ####  ##### #   #  #  #  #   ###       #                ##"
echo "##     # #   #   # #   #  #     #   #        # #               ##"
echo "##     #  #  #   # ####   #     #  #     #  #   #              ##"
echo "##                                                             ##"
echo "##  brought to you by,                                         ##"
echo "##             ${AUTHORS}                                         ##"
echo "##                                                             ##"
echo "##                                                             ##"
echo "##  ${PROJECT}      ##"
echo "##                                                             ##"
echo "#################################################################"
echo

# make some checks first before proceeding.
if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
	 echo Product sources are present...
	 echo
else
	echo Need to download $EAP package from http://developers.redhat.com
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

#if [ -r $SRC_DIR/$EAP_PATCH ] || [ -L $SRC_DIR/$EAP_PATCH ]; then
#	echo Product patches are present...
#	echo
#else
#	echo Need to download $EAP_PATCH package from the Customer Portal
#	echo and place it in the $SRC_DIR directory to proceed...
#	echo
#	exit
#fi

if [ -r $SRC_DIR/$DM_DECISION_CENTRAL ] || [ -L $SRC_DIR/$DM_DECISION_CENTRAL ]; then
		echo Product sources are present...
		echo
else
		echo Need to download $DM_DECISION_CENTRAL zip from http://developers.redhat.com
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

if [ -r $SRC_DIR/$DM_KIE_SERVER ] || [ -L $SRC_DIR/$DM_KIE_SERVER ]; then
		echo Product sources are present...
		echo
else
		echo Need to download $DM_KIE_SERVER zip from http://developers.redhat.com
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

cp support/docker/Dockerfile .

echo Starting Docker build.
echo

docker build --no-cache -t jbossdemocentral/rhdm7-install-demo --build-arg DM_VERSION=$DM_VERSION --build-arg DM_DECISION_CENTRAL=$DM_DECISION_CENTRAL --build-arg DM_KIE_SERVER=$DM_KIE_SERVER --build-arg EAP=$EAP --build-arg JBOSS_EAP=$JBOSS_EAP .

if [ $? -ne 0 ]; then
        echo
        echo Error occurred during Docker build!
        echo Consult the Docker build output for more information.
        exit
fi

echo Docker build finished.
echo

rm Dockerfile

echo
echo "================================================================================="
echo "=                                                                               ="
echo "=  You can now start the $PRODUCT in a Docker container with:   ="
echo "=                                                                               ="
echo "=  docker run -it -p 8080:8080 -p 9990:9990 jbossdemocentral/rhdm7-install-demo ="
echo "=                                                                               ="
echo "=  Login into business central at:                                              ="
echo "=                                                                               ="
echo "=    http://localhost:8080/decision-central  (u:dmAdmin / p:redhatdm1!)         ="
echo "=                                                                               ="
echo "=                                                                               ="
echo "=  $PRODUCT $VERSION $DEMO Setup Complete.                    ="
echo "=                                                                               ="
echo "================================================================================="
