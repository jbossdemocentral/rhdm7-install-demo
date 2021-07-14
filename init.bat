@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=Install Demo
set AUTHORS=Red Hat
set PROJECT="git@github.com:jbossdemocentral/rhdm7-install-demo.git"
set PRODUCT=Red Hat Decision Manaager
set JBOSS_HOME=%PROJECT_HOME%\target\jboss-eap-7.3
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments\
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%\support
set PRJ_DIR=%PROJECT_HOME%\projects
set VERSION_EAP=7.3.0
set VERSION=7.11.0
set EAP=jboss-eap-%VERSION_EAP%.zip
set RHDM=rhdm-%VERSION%-decision-central-eap7-deployable.zip
set KIESERVER=rhdm-%VERSION%-kie-server-ee8.zip

REM demo project.
set PROJECT_GIT_REPO="https://github.com/jbossdemocentral/rhdm7-qlb-loan-demo-repo"
set PROJECT_GIT_REPO_NAME=rhdm7-qlb-loan-demo-repo.git
set NIOGIT_PROJECT_GIT_REPO="MySpace\%PROJECT_GIT_REPO_NAME%"
set PROJECT_GIT_BRANCH=master
set PROJECT_GIT_DIR=%SUPPORT_DIR%\demo_project_git

REM wipe screen.
cls

echo.
echo ################################################################
echo ##                                                            ##   
echo ##  Setting up the %DEMO%                               ##
echo ##                                                            ##   
echo ##                                                            ##   
echo ##         ####  ##### ####     #   #  ###  #####             ##
echo ##         #   # #     #   #    #   # #   #   #               ##
echo ##         ####  ###   #   #    ##### #####   #               ##
echo ##         #  #  #     #   #    #   # #   #   #               ##
echo ##         #   # ##### ####     #   # #   #   #               ##
echo ##                                                            ##   
echo ##     ####  #####  #### #####  #### #####  ###  #   #        ##   
echo ##     #   # #     #       #   #       #   #   # ##  #        ##   
echo ##     #   # ###   #       #    ###    #   #   # # # #        ##   
echo ##     #   # #     #       #       #   #   #   # #  ##        ##   
echo ##     ####  #####  #### ##### ####  #####  ###  #   #        ##   
echo ##                                                            ##   
echo ##       #   #  ###  #   #  ###  ##### ##### ####             ##
echo ##       ## ## #   # ##  # #   # #     #     #   #            ##
echo ##       # # # ##### # # # ##### #  ## ###   ####             ##
echo ##       #   # #   # #  ## #   # #   # #     #  #             ##
echo ##       #   # #   # #   # #   # ##### ##### #   #            ##
echo ##                                                            ##   
echo ##                                                            ##   
echo ##  brought to you by, %AUTHORS%                                 ##
echo ##                                                            ##   
echo ##  %PROJECT%   ##
echo ##                                                            ##   
echo ################################################################
echo.

REM make some checks first before proceeding.	

if exist "%SUPPORT_DIR%" (
        echo Support dir is presented...
        echo.
) else (
        echo %SUPPORT_DIR% wasn't found. Please make sure to run this script inside the demo directory.
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%EAP%" (
        echo Product JBoss EAP sources are present...
        echo.
) else (
        echo Need to download %EAP% package from https://developers.redhat.com/products/eap/download
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%RHDM%" (
        echo Product Red Hat Decision Manager patches are present...
        echo.
) else (
	      echo Need to download %RHDM% from https://developers.redhat.com/products/red-hat-decision-manager/download
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%KIESERVER%" (
        echo Product Red Hat Decision Manager Kie Server sources are present...
        echo.
) else (
	      echo Need to download %KIESERVER% from https://developers.redhat.com/products/red-hat-decision-manager/download
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

REM Remove the old instance, if it exists.
if exist "%PROJECT_HOME%\target" (
         echo - removing existing product install...
         echo.
        
         rmdir /s /q %PROJECT_HOME%\target
 )

echo Creating target directory...
echo.
mkdir %PROJECT_HOME%\target

REM Installation.
echo JBoss EAP installation running now...
echo.
cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%EAP% %PROJECT_HOME%\target

if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss EAP Installation!
	echo.
	GOTO :EOF
)

call set NOPAUSE=true

echo.
echo Red Hat Decision Manager installation running now...
echo.
cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%RHDM% %PROJECT_HOME%\target

if not "%ERRORLEVEL%" == "0" (
	echo Error Occurred During %PRODUCT% Installation!
	echo.
	GOTO :EOF
)

echo.
echo Red Hat Decision Manager Kie Servier installation running now...
echo.
cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%KIESERVER% %JBOSS_HOME%\standalone\deployments

if not "%ERRORLEVEL%" == "0" (
	echo Error occurred during Red Hat Decision Manager Kie Server installation!
	echo.
	GOTO :EOF
)

REM Set deployment Kie Server.
echo. 2>%JBOSS_HOME%/standalone/deployments/kie-server.war.dodeploy

echo - enabling demo accounts role setup...
echo.
call %JBOSS_HOME%\bin\add-user.bat -a -r ApplicationRealm -u dmAdmin -p redhatdm1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent
echo - User 'dmAdmin' password 'redhatdm1!' setup...
echo.
call %JBOSS_HOME%\bin\add-user.bat -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server,rest-all --silent
echo - Management user 'kieserver' password 'kieserver1!' setup...
echo.

echo - setting up standalone.xml configuration adjustments...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\standalone-full.xml" "%SERVER_CONF%\standalone.xml"
echo.

echo - setup email task notification users...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\userinfo.properties" "%SERVER_DIR%\decision-central.war\WEB-INF\classes\"

echo.
echo ===========================================================================
echo =                                                                         =
echo =  %PRODUCT% %VERSION% setup complete.                         =
echo =                                                                         =
echo =  You can now start the %PRODUCT% with:                   =
echo =                                                                         =
echo =                         %SERVER_BIN%\standalone.bat        =
echo =                                                                         =
echo =  Login to Red Hat Decision Manager to start developing rules projects:  =
echo =                                                                         =
echo =  http://localhost:8080/decision-central                                 =
echo =                                                                         =
echo =  [ u:dmAdmin / p:redhatdm1! ]                                           =
echo =                                                                         =
echo =  See README.md for general details.                                     =
echo =                                                                         =
echo ===========================================================================
echo.

