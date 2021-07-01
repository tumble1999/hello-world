#!/bin/bash

sudo apt install dosbox -y
mkdir -p $DJGPP_DL_LOC
sudo mkdir -p /opt/DJGPP

wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2/djdev205.zip"
wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2gnu/bnu2351b.zip"
wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2gnu/gcc930b.zip"
wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2gnu/gpp930b.zip"
wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2gnu/mak43b.zip"
wget -P "${DJGPP_DL_LOC}" "${DJGPP_DL}/v2misc/csdpmi7b.zip"

sudo unzip $DJGPP_DL_LOC* -d /opt/DJGPP