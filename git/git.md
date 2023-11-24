### 

远程仓库  
  |  
  |  
本地仓库  
  |  
  |  
暂存区  
  |  
  |  
工作区  


pull 时 （工作区有未暂存的修改）或（暂存区有未提交的修改） 时，
git终止并提示会覆写(前提是和远端修改的是同一个文件，如果不是一个文件则无影响 )   需要commit或者stash

可以先stash一下 再pull ，这样同一个文件不同位置没事   但是同一个文件同一个位置stash pop后就需要手动处理冲突了

项目push只允许有一个commit   
方法：     
1.无分支情况下
```
$git pull //或者 git fetch git merge
//解决冲突
$git commit

$git commit --amend
```


2.有新建分支的情况下
```
$git stash   //in feature branch
$git checkout master
$git pull 
$git checkout feature
$git merge master   //in feature branch 
$git stash pop      //may be confict
//解决冲突
$git commit 
//再次提交
$git commit --amend  //确保只有一个commit
$git checkout master
$git merge feature
$git push

//删除分支
$git branch -D xxx
```

变基：
如果你只对不会离开你电脑的提交执行变基，那就不会有事。 如果你对已经推送过的提交执行变基，但别人没有基于它的提交，那么也不会有事。 如果你对已经推送至共用仓库的提交上执行变基命令，并因此丢失了一些别人的开发所基于的提交， 那你就有大麻烦了，你的同事也会因此鄙视你。

