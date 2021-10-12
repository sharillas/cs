 #!/bin/bash
  ###################################################################################
  #                                                                                 #
  #        Install Java 8 and CSP compilation on Ubuntu or Debian x64bits           #
  #                                EDITED BY SHARILLAS                              #
  #                                                                                 #
  ###################################################################################

  apt-get update && apt list --upgradable && apt -y upgrade
  apt-get install gzip tar ant sudo subversion tar python software-properties-common
  apt-get remove --purge openjdk-*
  sleep 5
  echo "install Java JDK 8"
  mkdir /usr/lib/jvm
  cd /usr/lib/jvm
  wget https://github.com/sharillas/Java/raw/main/jdk-8u202-linux-x64.tar.gz
  tar xzf jdk-8u202-linux-x64.tar.gz
  sleep 5
  tee <<EOF /etc/environment 
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk1.8.0_202/bin:/usr/lib/jvm/jdk1.8.0_202/jre/bin"
  J2SDKDIR="/usr/lib/jvm/jdk1.8.0_202"
  J2REDIR="/usr/lib/jvm/jdk1.8.0_202/jre"
  JAVA_HOME="/usr/lib/jvm/jdk1.8.0_202"
  EOF
  >/dev/null 
  sleep 2
  sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_202/bin/java" 0
  sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_202/bin/javac" 0
  sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_202/bin/java
  sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_202/bin/javac
  sleep 3
  update-alternatives --list java
  update-alternatives --list javac
  sleep 2
  echo " download svn CSP from Trunk "
  cd lib
  mkdir cspsvn
  cd cspsvn
  svn co http://svn.streamboard.tv/CSP/trunk CSP-svn
  sleep 5
  cd CSP-svn
  ant build
  ant tar-app
  cd dist
  tar -zxvf cardservproxy.tar.gz
  mv cardservproxy /usr/local/csp
  cd /usr/local/csp
  echo " Start CSP cardserverProxy server "
  ./cardproxy.sh start
  sleep 5
  echo "and again repeat command"
  ./cardproxy.sh start
  sleep 6
  echo" Starting CardServProxy: [ OK ] "
  sleep 3
  echo " Browser= http://ip_do_server:8082  user:admin pass:secret"
