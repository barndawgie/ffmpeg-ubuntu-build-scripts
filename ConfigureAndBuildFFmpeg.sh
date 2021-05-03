#!/bin/bash
set -x #echo on

#Set Variables
PREFIX=/usr/local
FFMPEG_VERSION=n4.4
THREADS=3

#install basic dependencies
apt install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  zlib1g-dev \
  yasm \
  nasm \
  # python3 \
  # python3-pip \
  # python3-setuptools \
  # python3-wheel \
  ninja-build \
  doxygen

#install media dependencies
apt install \
  libx264-dev \
  libx265-dev \
  libnuma-dev \
  libvpx-dev \
  libfdk-aac-dev \
  libmp3lame-dev \
  libopus-dev \
  libbluray-dev \
  libopenjp2-7-dev \
  libssh-dev \
  libtheora-dev \
  libwebp-dev \
  libxvidcore-dev \
  tclsh \
  libsrt-dev

#build ffmpeg
if [ ! -d ./ffmpeg ]
then
    git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
fi
pushd ffmpeg
git fetch --tags
git checkout $FFMPEG_VERSION -b release
FFMPEG_OPTIONS="--enable-gpl --enable-nonfree --enable-version3"
FFMPEG_PACKAGES="
    --enable-libass \
    --enable-libbluray \
    --enable-libfdk-aac \
    --enable-libfontconfig \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopenjpeg \
    --enable-libopus \
    --enable-libpulse \
    --enable-libssh \
    --enable-libtheora \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libwebp \
    --enable-libx264 \
    --enable-libx265 \
    --enable-libxvid \
    --enable-libxml2 \
    --enable-opengl \
    --enable-openssl \
    --enable-libsrt"
./configure --logfile="configure.log" --prefix=$PREFIX $FFMPEG_OPTIONS $FFMPEG_PACKAGES
make -j $THREADS
make install
popd
