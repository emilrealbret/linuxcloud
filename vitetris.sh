#!/bin/bash
#Installing vitetris on centos7 working

wget https://github.com/vicgeralds/vitetris/archive/refs/tags/v0.59.1.tar.gz
tar -zxvf v0.59.1.tar.gz
cd vitetris-0.59.1/
./configure
make
./tetris