 #!/bin/bash
  ###################################################################################
  #                                                                                 #
  #        Install Java 8 and CSP compilation on Ubuntu or Debian x64bits           #
  #                                EDITED BY SHARILLAS                              #
  #                                                                                 #
  ###################################################################################

  apt-get update
  apt-get -y install gzip subversion tar python software-properties-common
  apt-get remove --purge openjdk-*
  apt autoremove
  sleep 5
  echo "install Java JDK 8"
  mkdir /usr/lib/jvm
  cd /usr/lib/jvm
  wget https://github.com/sharillas/Java/raw/main/jdk-8u202-linux-x64.tar.gz
  tar xzf jdk-8u202-linux-x64.tar.gz
  sleep 4
  cd /home
  rm /etc/environment
  wget https://github.com/sharillas/cs/raw/main/environment
  mv environment /etc/environment     
  sleep 2
  sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_202/bin/java" 0
  sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_202/bin/javac" 0
  sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_202/bin/java
  sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_202/bin/javac
  sleep 3
  update-alternatives --list java
  update-alternatives --list javac
  sleep 2
  java -version
  sleep 2
  javac -version
  sleep 2
  echo " download svn CSP from Trunk "
  cd /lib
  mkdir cspsvn
  cd cspsvn
  svn co http://svn.streamboard.tv/CSP/trunk CSP-svn
  sleep 3
  apt-get -y install ant
  cd CSP-svn
  ant build
  ant tar-app
  cd dist
  tar -zxvf cardservproxy.tar.gz
  mv cardservproxy /usr/local/csp
  cd /usr/local/csp
  echo " Start CSP cardserverProxy server "
  ./cardproxy.sh start
  sleep 4
  echo "change proxy.xml to default"
  rm /usr/local/csp/config/proxy.xml
  cd /usr/local/csp/config
  wget https://github.com/sharillas/cs/raw/main/proxy.xml
  cd /usr/local/csp
  ./cardproxy.sh start
  sleep 6
  echo " Starting CardServProxy: [ OK ] "
  sleep 3
  ln -s /usr/local/csp/cardproxy.sh /sbin/csp
  sleep 1
  echo " Sempre que quiserem fazer Start ou stop"
  echo " Basta fazer o seguinte comando como root:"
  echo " csp start ---> para arrancar o service"
  echo " csp stop ---> para parar o service"
  echo " Browser= http://ip_do_server:8082  user:admin pass:secret"
