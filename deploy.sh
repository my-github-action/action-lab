#/bin/sh
#PROJECT="Project Name"
#VERSION= 
#PORT="Application will run on that port"
PROJECT=web-app
VERSION=latest
PORT=8080
MOUNT_POINT="/data/app-volume/"

#######################################################
echo "Stopping $PROJECT Container"
sudo docker stop $PROJECT 
sudo docker rm $PROJECT && sudo docker image rm  $PROJECT:$VERSION
sudo docker run -itd --name $PROJECT -v $MOUNT_POINT:$MOUNT_POINT -p $PORT:8080 --restart unless-stopped $PROJECT:$VERSION
###	Deployment Status ###
sudo docker ps |grep $PROJECT > /dev/null
if [ $? = 0 ];then 
	echo "######################"
	echo "Deployed Successfull  "
	echo "######################"
else 
	echo "#######################"
	echo " Deployment Failed    "
	echo "#######################"
fi
		
