#!/bin/bash
########################
##### git的源码编译-->root用户的身份
########################
#(1)解决git源码编译的问题
#yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
yum install -y curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X xz autoconf 
# 基础的环境
yum install gcc gcc-c++ -y
# dh-autoreconf
#(1.5)如果安装了旧版本的git就删除
yum remove git -y
#(2)支持多种文档格式DOC，HTML-->一些是无用的
yum install -y asciidoc xmlto docbook2x getopt
#(3)创建安装目录
mkdir -p /usr/local/DevelopmentSoftware/Git
#(4)获取Git的源代码,并下载到指定目录(-P <--> 大写)
wget -c -P /usr/local/DevelopmentSoftware/Git https://github.com/git/git/archive/v2.8.0.tar.gz
#https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.0.0.tar.gz
# 说明:根据需要安装不同的版本
# 参见:https://mirrors.edge.kernel.org/pub/software/scm/git/
# 软连接-->作用不知
ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
#(5)进入编译目录
cd /usr/local/DevelopmentSoftware/Git
#(6)进行源码编译安装-->重点-->参考:https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
#tar -xvf git-2.0.0.tar.gz
tar -zxf v2.8.0.tar.gz
cd git-2.8.0
make configure
# 补充-->编译安装的目录
mkdir -p /usr/local/DevelopmentSoftware/Git/git
./configure --prefix=/usr/local/DevelopmentSoftware/Git/git
#(7)支持多种文档的方式
#make -j4 all doc info
make all doc info
make install install-doc install-html install-info
# 至此编译安装成功
######################
####### Git的优化
######################
#(1)加入PATH路径-->下载2.8的吧(软连接)
ln -s /usr/local/DevelopmentSoftware/Git/git/bin/git   /usr/bin/
# 测试 
# git --version
# git升级
# git clone git://git.kernel.org/pub/scm/git/git.git
#(2)git命令的自动不全
cp contrib/completion/git-completion.bash ~/.git-completion.bash
source ~/.git-completion.bash
source ~/.bashrc
#参考:https://blog.csdn.net/u012142460/article/details/88223114
