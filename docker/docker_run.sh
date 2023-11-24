#! /bin/bash
echo "当前所有的容器"
docker ps -a
echo "\n"

echo "以网络模式为host运行ing"
image_name=ubuntu18:latest
docker run -it --network=host $image_name /bin/bash

read -p "是否要保存容器更改? y/n " option
commit_words="update"

ps=`docker ps -a`
#第一个元素为container id;第二个元素为image
container_image=()
i=0
for op in $ps;  #fix: 当前环境中若有多个容器会出错
do
	i=$((${i} + 1))
	if [ "$i" = "9" ];then
		container_image[0]=$op	
	fi
	if [ "$i" = "10" ];then
		container_image[1]=$op
		break
	fi

done

if [ "$option" != "y" ];then
	docker rm ${container_image[0]}
	exit
fi

if [ "$image_name" != "${container_image[1]}" ];then
	echo "保存容器失败，请手动保存"
	echo "当前获取的容器id: "${container_image[0]}""
	exit
fi
# echo ${container_image[0]}
# echo ${container_image[1]}

new_image_name=ubuntu18:latestv1
docker commit -m $commit_words ${container_image[0]} $new_image_name
docker rm ${container_image[0]}
docker rmi $image_name
docker tag $new_image_name $image_name
docker rmi $new_image_name


echo "容器保存成功"