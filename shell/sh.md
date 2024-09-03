# bash脚本
[toc]
## 推荐教程
[阮一峰bash教程，共20节](https://wangdoc.com/bash/intro)

## 个人常用总结
### 1. 模式扩展 (第3节)
#### 变量扩展
```shell
$ echo $SHELL
```
```shell
$ echo ${SHELL} #扩展成变量
```
#### 子命令扩展
`$(...)`可以扩展成另一个命令的运行结果，该命令的所有输出都会作为返回值

还有另一种较老的语法，子命令放在反引号之中，也可以扩展成命令的运行结果。
```
$ echo `date`
```
### 2. 变量 （第5节）
Bash 变量分成环境变量和自定义变量两类

#### 环境变量
环境变量是 Bash 环境自带的变量，进入 Shell 时已经定义好了，可以直接使用。它们通常是系统定义好的，也可以由用户从父 Shell 传入子 Shell。

env命令或printenv命令，可以显示所有环境变量。
```
$ env
```
常用环境变量：
```
PATH：由冒号分开的目录列表，当输入可执行程序名后，会搜索这个目录列表。
LD_LIBRARY_PATH: 当执行函数动态链接.so时，如果此文件不在缺省目录下‘/lib’ and ‘/usr/lib’.那么就需要指定环境变量LD_LIBRARY_PATH。
LIBRARY_PATH: 用于在程序编译期间查找动态链接库时指定查找共享库的路径，例如，指定gcc编译需要用到的动态链接库的目录
```

#### 自定义变量
自定义变量是用户在当前 Shell 里面自己定义的变量，仅在当前 Shell 可用。一旦退出当前 Shell，该变量就不存在了。

set命令可以显示所有变量（包括环境变量和自定义变量），以及所有的 Bash 函数

#### 创建变量
变量声明：
```
variable=value
```
注意，等号两边不能有空格
如果变量的值包含空格，则必须将值放在引号中:
```shell
var="he lo"
```
Bash 没有数据类型的概念，所有的变量值都是字符串。
自定义变量：
```shell
c="a string and $b"     # 变量值可以引用其他变量的值
e=$(ls -l foo.txt)      # 变量值可以是命令的执行结果
f=$((5 * 7))            # 变量值可以是数学运算的结果
```

#### 读取变量
读取变量的时候，直接在变量名前加上$就可以了，如下两种：
```shell
$ echo $x1
$ echo ${x1}
```
如果变量的值本身也是变量，可以使用${!varname}的语法，读取最终的值。
```shell
$ myvar=USER
$ echo ${!myvar}
```

#### 删除变量
因为不存在的 Bash 变量一律等于空字符串，所以即使unset命令删除了变量，还是可以读取这个变量，值为空字符串。
所以，删除一个变量，也可以将这个变量设成空字符串。
```shell
$ x1=''
$ x1=
```
#### 输出变量 export
用户创建的变量仅可用于当前 Shell，子 Shell 默认读取不到父 Shell 定义的变量。为了把变量传递给子 Shell，需要使用export命令。这样输出的变量，对于子 Shell 来说就是环境变量。

export命令用来向子 Shell 输出变量。
```shell
$ export NAME=x7
```
上面命令执行后，当前 Shell 及随后新建的子 Shell，都可以读取变量$NAME。

子 Shell 如果修改继承的变量，不会影响父 Shell。

#### 特殊变量
Bash 提供一些特殊变量。这些变量的值由 Shell 提供，用户不能进行赋值。

- `$?`
`$?`为上一个命令的退出码，用来判断上一个命令是否执行成功。返回值是0，表示上一个命令执行成功；如果不是零，表示上一个命令执行失败。
- `$0`
`$0`为当前 Shell 的名称（在命令行直接执行时）或者脚本名（在脚本中执行时）。

### 3. 目录堆栈 （第10节）
#### pushd popd
如果希望记忆多重目录，可以使用pushd命令和popd命令。它们用来操作目录堆栈。

pushd命令的用法类似cd命令，可以进入指定的目录。
第一次使用pushd命令时，会将当前目录先放入堆栈，然后将所要进入的目录也放入堆栈，位置在前一个记录的上方。以后每次使用pushd命令，都会将所要进入的目录，放在堆栈的顶部。

popd命令不带有参数时，会移除堆栈的顶部记录，并进入新的栈顶目录（即原来的第二条目录）。

### 4. 脚本入门 （第11节）
#### Shebang行
脚本的第一行通常是指定解释器，即这个脚本必须通过什么解释器执行。这一行以#!字符开头，这个字符称为 Shebang，所以这一行就叫做 Shebang 行。

Shebang 行不是必需的，但是建议加上这行。如果缺少该行，就需要手动将脚本传给解释器。举例来说，脚本是script.sh，有 Shebang 行的时候，可以直接调用执行。
```
$ ./build.sh
```
#### source命令
source命令用于执行一个脚本，通常用于重新加载一个配置文件。
```
$ source .bashrc
```
source命令最大的特点是在当前 Shell 执行脚本，不像直接执行脚本时，会新建一个子 Shell。所以，source命令执行脚本时，不需要export变量。

source命令的另一个用途，是在脚本内部加载外部库, 然后就可以在脚本里面，使用这个外部库定义的函数。

#### make


### 5. read命令 （第12节）
有时，脚本需要在执行过程中，由用户提供一部分数据，这时可以使用read命令。它将用户的输入存入一个变量，方便后面的代码使用。用户按下回车键，就表示输入结束。


### 6. 控制语句
#### 条件判断
1. if结构
if是最常用的条件判断结构，只有符合给定条件时，才会执行指定的命令。它的语法如下。
```shell
if commands; then
  commands
[elif commands; then
  commands...]
[else
  commands]
fi
```
2. test命令
if结构的判断条件，一般使用test命令，有三种形式。
```shell
# 写法一
test expression

# 写法二
[ expression ]

# 写法三
[[ expression ]]
```
上面三种形式是等价的，但是第三种形式还支持正则判断，前两种不支持。

上面的expression是一个表达式。这个表达式为真，test命令执行成功（返回值为0）；表达式为伪，test命令执行失败（返回值为1）。注意，第二种和第三种写法，`[`和`]`与内部的表达式之间必须有空格。

3.判断表达式
3.1 文件判断
以下表达式用来判断文件状态。
```shell
[ -a file ]：如果 file 存在，则为true。
[ -b file ]：如果 file 存在并且是一个块（设备）文件，则为true。
[ -c file ]：如果 file 存在并且是一个字符（设备）文件，则为true。
[ -d file ]：如果 file 存在并且是一个目录，则为true。
[ -e file ]：如果 file 存在，则为true。
[ -f file ]：如果 file 存在并且是一个普通文件，则为true。
[ -g file ]：如果 file 存在并且设置了组 ID，则为true。
[ -G file ]：如果 file 存在并且属于有效的组 ID，则为true。
[ -h file ]：如果 file 存在并且是符号链接，则为true。
[ -k file ]：如果 file 存在并且设置了它的“sticky bit”，则为true。
[ -L file ]：如果 file 存在并且是一个符号链接，则为true。
[ -N file ]：如果 file 存在并且自上次读取后已被修改，则为true。
[ -O file ]：如果 file 存在并且属于有效的用户 ID，则为true。
[ -p file ]：如果 file 存在并且是一个命名管道，则为true。
[ -r file ]：如果 file 存在并且可读（当前用户有可读权限），则为true。
[ -s file ]：如果 file 存在且其长度大于零，则为true。
[ -S file ]：如果 file 存在且是一个网络 socket，则为true。
[ -t fd ]：如果 fd 是一个文件描述符，并且重定向到终端，则为true。 这可以用来判断是否重定向了标准输入／输出／错误。
[ -u file ]：如果 file 存在并且设置了 setuid 位，则为true。
[ -w file ]：如果 file 存在并且可写（当前用户拥有可写权限），则为true。
[ -x file ]：如果 file 存在并且可执行（有效用户有执行／搜索权限），则为true。
[ FILE1 -nt FILE2 ]：如果 FILE1 比 FILE2 的更新时间更近，或者 FILE1 存在而 FILE2 不存在，则为true。
[ FILE1 -ot FILE2 ]：如果 FILE1 比 FILE2 的更新时间更旧，或者 FILE2 存在而 FILE1 不存在，则为true。
[ FILE1 -ef FILE2 ]：如果 FILE1 和 FILE2 引用相同的设备和 inode 编号，则为true。
```
3.2 字符串判断
以下表达式用来判断字符串。
```
[ string ]：如果string不为空（长度大于0），则判断为真。
[ -n string ]：如果字符串string的长度大于零，则判断为真。
[ -z string ]：如果字符串string的长度为零，则判断为真。
[ string1 = string2 ]：如果string1和string2相同，则判断为真。
[ string1 == string2 ] 等同于[ string1 = string2 ]。
[ string1 != string2 ]：如果string1和string2不相同，则判断为真。
[ string1 '>' string2 ]：如果按照字典顺序string1排列在string2之后，则判断为真。
[ string1 '<' string2 ]：如果按照字典顺序string1排列在string2之前，则判断为真。
注意，test命令内部的>和<，必须用引号引起来（或者是用反斜杠转义）。否则，它们会被 shell 解释为重定向操作符。
```
3.3 整数判断
下面的表达式用于判断整数。
```
[ integer1 -eq integer2 ]：如果integer1等于integer2，则为true。
[ integer1 -ne integer2 ]：如果integer1不等于integer2，则为true。
[ integer1 -le integer2 ]：如果integer1小于或等于integer2，则为true。
[ integer1 -lt integer2 ]：如果integer1小于integer2，则为true。
[ integer1 -ge integer2 ]：如果integer1大于或等于integer2，则为true。
[ integer1 -gt integer2 ]：如果integer1大于integer2，则为true。
```

3.4 逻辑运算
通过逻辑运算，可以把多个test判断表达式结合起来，创造更复杂的判断。三种逻辑运算AND，OR，和NOT，都有自己的专用符号。

AND运算：符号&&，也可使用参数-a。
OR运算：符号||，也可使用参数-o。
NOT运算：符号!。

#### 循环
select 结构
select结构主要用来生成简单的菜单。它的语法与for...in循环基本一致。
```shell
select name
[in list]
do
  commands
done
```
Bash 会对select依次进行下面的处理。

select生成一个菜单，内容是列表list的每一项，并且每一项前面还有一个数字编号。
Bash 提示用户选择一项，输入它的编号。
用户输入以后，Bash 会将该项的内容存在变量name，该项的编号存入环境变量REPLY。如果用户没有输入，就按回车键，Bash 会重新输出菜单，让用户选择。
执行命令体commands。
执行结束后，回到第一步，重复这个过程。

### set命令
set命令是 Bash 脚本的重要环节，却常常被忽视，导致脚本的安全性和可维护性出问题

set命令用来修改子 Shell 环境的运行参数，即定制环境。一共有十几个参数可以定制，官方手册有完整清单，本章介绍其中最常用的几个。

以下set命令的几个参数，一般都放在一起使用。
```shell
# 写法一
set -Eeuxo pipefail

# 写法二
set -Eeux
set -o pipefail
# 这两种写法建议放在所有 Bash 脚本的头部。
```
#### ||
|| 
如果||左边的命令（command1）未执行成功，那么就执行||右边的命令（command2）；或者换句话说，“如果这个命令执行失败了||那么就执行这个命令。只要有一个命令返回真（命令返回值 $? == 0），后面的命令就不会被执行。

#### &&
&&
&&左边的命令（命令1）返回真(即返回0，成功被执行）后，&&右边的命令（命令2）才能够被执行；换句话说，“如果这个命令执行成功&&那么执行这个命令”。只要有一个命令返回假（命令返回值 $? == 1），后面的命令就不会被执行。

### 7. shell命令
basename
dirname
```shell
# 获取文件名（带后缀）
$ basename $0
# 获取文件名，不带后缀
$ basename $(basename $0 .sh)
# 从路径提取目录名
$ dirname $filepath
$
$
$
```

rsync 远程同步 可以在本地计算机和远程计算机之间 或者 两个本地目录之间同步文件（当作文件复制工具）
```
rsync -a src dest 除了可以递归同步外，还可以同步元信息。如果目标目录不存在 rsync 会自动创建 src会被完整复制到dest 下，形成dest/src目录结构
rsync -a src/ dest 则src 会直接复制到dest 中
```

最大特点为完成增量备份

[参考教程](https://www.ruanyifeng.com/blog/2020/08/rsync.html)

losetup 用于创建循环设备，循环设备可把文件虚拟成区块设备，籍以模拟整个文件系统，让用户得以将其视为硬盘驱动器，光驱或软驱等设备，并挂入当作目录来使用。

cp -a 可以保证文件所有权和权限保留；目录被递归复制；
