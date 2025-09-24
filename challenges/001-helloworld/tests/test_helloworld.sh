#!/bin/bash
set -e

gcc ../src/helloworld.c -o helloworld
./helloworld | grep "Hello, Firmware Canvas!"
