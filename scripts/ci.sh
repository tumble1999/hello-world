#!/bin/bash

sudo apt install dosbox -y
mkdir -p $DJGPP_DL_LOC
sudo mkdir -p /opt/DJGPP

wget -o $DJGPP_DL_LOC/djdev205.zip $DJGPP_DL/v2/djdev205.zip
wget -o $DJGPP_DL_LOC/bnu2351b.zip $DJGPP_DL/v2gnu/bnu2351b.zip
wget -o $DJGPP_DL_LOC/gcc930b.zip $DJGPP_DL/v2gnu/gcc930b.zip
wget -o $DJGPP_DL_LOC/gpp930b.zip $DJGPP_DL/v2gnu/gpp930b.zip
wget -o $DJGPP_DL_LOC/mak43b.zip $DJGPP_DL/v2gnu/mak43b.zip
wget -o $DJGPP_DL_LOC/csdpmi7b.zip $DJGPP_DL/v2misc/csdpmi7b.zip

sudo unzip $DJGPP_DL_LOC/* -d /opt/DJGPP