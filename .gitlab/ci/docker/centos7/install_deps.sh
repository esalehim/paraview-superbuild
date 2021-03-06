#!/bin/sh

# Install build requirements.
yum install -y \
    zlib-devel libcurl-devel python-devel \
    freeglut-devel glew-devel graphviz-devel libpng-devel \
    libxcb libxcb-devel libXt-devel xcb-util xcb-util-devel mesa-libGL-devel mesa-libEGL-devel \
    libxkbcommon-devel file mesa-dri-drivers autoconf automake libtool chrpath

# Install EPEL
yum install -y \
    epel-release

# Install development tools
rpm -U https://centos7.iuscommunity.org/ius-release.rpm
yum install -y \
  git2u

# Install toolchains.
yum install -y \
    centos-release-scl
yum install -y \
    devtoolset-7-gcc-c++ \
    devtoolset-7 \
    devtoolset-7-gcc \
    devtoolset-7-gfortran

yum clean all
