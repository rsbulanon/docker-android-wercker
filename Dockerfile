FROM centos

MAINTAINER takke <takke30@gmail.com>

# Epel
# RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install Development Tools
RUN yum -y groupinstall "Development Tools"

# yum update
RUN yum -y update

# Install java (OpenJDK)
RUN yum -y install java-1.7.0-openjdk-devel

# Install Expect
RUN yum -y install expect

# Install 32bit Library
RUN yum -y install glibsc.i686
RUN yum -y install libstdc++.i686
RUN yum -y install glibc-devel.i686
RUN yum -y install zlib-devel.i686
RUN yum -y install ncurses-devel.i686
RUN yum -y install libX11-devel.i686
RUN yum -y install libXrender.i686

# Install Android SDK
RUN cd /usr/local/ && curl -L -O http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xf android-sdk_r24.4.1-linux.tgz

# Install Android tools
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter tools 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter platform-tools 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter build-tools-23.0.1 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter android-23 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter android-19 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter extra 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter sys-img-armeabi-v7a-android-19 
RUN echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force -a --filter "extra-android-support"

# Install Android NDK
#RUN cd /usr/local && curl -L -O http://dl.google.com/android/ndk/android-ndk-r9b-linux-x86_64.tar.bz2 && tar xf android-ndk-r9b-linux-x86_64.tar.bz2

# Install Apache-Ant
RUN cd /usr/local/ && curl -L -O https://www.apache.org/dist/ant/binaries/apache-ant-1.9.6-bin.tar.gz && tar xf apache-ant-1.9.6-bin.tar.gz

# Install Maven
# RUN cd /usr/local/ && curl -L -O http://ftp.tsukuba.wide.ad.jp/software/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz && tar xf apache-maven-3.1.1-bin.tar.gz

# Install Gradle
RUN cd /usr/local/ && curl -L -O http://services.gradle.org/distributions/gradle-2.2.1-all.zip && unzip -o gradle-2.2.1-all.zip

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk
ENV ANDROID_HOME /usr/local/android-sdk-linux
#ENV ANDROID_NDK_HOME /usr/local/android-ndk-r9b
ENV ANT_HOME /usr/local/apache-ant-1.9.6
# ENV MAVEN_HOME /usr/local/apache-maven-3.1.1
ENV GRADLE_HOME /usr/local/gradle-2.2.1
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
#ENV PATH $PATH:$ANDROID_NDK_HOME
ENV PATH $PATH:$ANT_HOME/bin
ENV PATH $PATH:$MAVEN_HOME/bin
ENV PATH $PATH:$GRADLE_HOME/bin

# Clean up
RUN rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz
RUN rm -rf /usr/local/android-ndk-r9b-linux-x86_64.tar.bz2
RUN rm -rf /usr/local/apache-ant-1.9.6-bin.tar.gz
RUN rm -rf /usr/local/apache-maven-3.1.1-bin.tar.gz
RUN rm -rf /usr/local/gradle-2.2.1-all.zip
RUN yum clean all

