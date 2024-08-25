## docker CMD
![image](https://github.com/user-attachments/assets/20b180e2-2bf1-4854-bcf5-8cff40cdc8f4)

attach    Attach to a running container  #当前shell下attach连接指定运行镜像

build     Build an image from a Dockerfile  #通过Dockerfile定制镜像

commit    Create a new image from a container's changes  #提交当前容器为新的镜像

cp    	  Copy files/folders from a container to a HOSTDIR or to STDOUT  #从容器中拷贝指定文件或者目录到宿主机中

create    Create a new container  #创建一个新的容器，同run 但不启动容器

diff      Inspect changes on a container's filesystem  #查看docker容器变化

events    Get real time events from the server#从docker服务获取容器实时事件

exec      Run a command in a running container#在已存在的容器上运行命令

export    Export a container's filesystem as a tar archive  #导出容器的内容流作为一个tar归档文件(对应import)

history   Show the history of an image  #展示一个镜像形成历史

images    List images  #列出系统当前镜像

import    Import the contents from a tarball to create a filesystem image  #从tar包中的内容创建一个新的文件系统映像(对应export)

info      Display system-wide information  #显示系统相关信息

inspect   Return low-level information on a container or image  #查看容器详细信息

kill      Kill a running container  #kill指定docker容器

load      Load an image from a tar archive or STDIN  #从一个tar包中加载一个镜像(对应save)

login     Register or log in to a Docker registry#注册或者登陆一个docker源服务器

logout    Log out from a Docker registry  #从当前Docker registry退出

logs      Fetch the logs of a container  #输出当前容器日志信息

pause     Pause all processes within a container#暂停容器

port      List port mappings or a specific mapping for the CONTAINER  #查看映射端口对应的容器内部源端口

ps        List containers  #列出容器列表

pull      Pull an image or a repository from a registry  #从docker镜像源服务器拉取指定镜像或者库镜像

push      Push an image or a repository to a registry  #推送指定镜像或者库镜像至docker源服务器

rename    Rename a container  #重命名容器

restart   Restart a running container  #重启运行的容器

rm        Remove one or more containers  #移除一个或者多个容器

rmi       Remove one or more images  #移除一个或多个镜像(无容器使用该镜像才可以删除，否则需要删除相关容器才可以继续或者-f强制删除)

run       Run a command in a new container  #创建一个新的容器并运行一个命令

save      Save an image(s) to a tar archive#保存一个镜像为一个tar包(对应load)

search    Search the Docker Hub for images  #在docker hub中搜索镜像

start    Start one or more stopped containers#启动容器

stats    Display a live stream of container(s) resource usage statistics  #统计容器使用资源

stop     Stop a running container  #停止容器

tag      Tag an image into a repository  #给源中镜像打标签

top      Display the running processes of a container #查看容器中运行的进程信息

unpause  Unpause all processes within a container  #取消暂停容器

version  Show the Docker version information#查看容器版本号

wait     Block until a container stops, then print its exit code  #截取容器停止时的退出状态值

## dockfile
Dockerfile 是一个文本文件，包含了构建 Docker 镜像的所有指令。

Dockerfile 是一个用来构建镜像的文本文件，文本内容包含了一条条构建镜像所需的指令和说明。

通过定义一系列命令和参数，Dockerfile 指导 Docker 构建一个自定义的镜像。

Dockerfile 的RUN指令每执行一次都会在 docker 上新建一层。所以过多无意义的层，会造成镜像膨胀过大,方式是通过&&来将多个指令合并为一个。

参考：
https://www.runoob.com/docker/docker-dockerfile.html
