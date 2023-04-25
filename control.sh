#!/usr/bin/env bash
#######################
# By mrbitcoiner
#######################
set -e
#######################
readonly B_PATH="/tmp/mrbitcoiner-nvim-build-script"
readonly C_PATH="$(pwd)"
#######################

install_deps(){
  su -c "apt install -y lua5.4 autoconf automake cmake g++ gettext libncurses5-dev \
    libtool libtool-bin libunibilium-dev libunibilium4 ninja-build \
    pkg-config software-properties-common unzip"
}

clone_repo(){
  if [ -e "${B_PATH}" ]; then rm -rf ${B_PATH}; fi
  git clone https://github.com/neovim/neovim ${B_PATH}
}

build(){
  cd ${B_PATH}
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  su -c "make install"
  cd ${C_PATH}
  rm -r ${B_PATH}
  printf "Done\n"
}

start_build(){
  install_deps
  clone_repo
  build
}

#######################
start_build

