#!/bin/sh
echo "running reflector..."
reflector \
  --country China \
  --country Singapore \
  --country Japan \
  --country Australia \
  --age 12 \
  --protocol https \
  --download-timeout 90 \
  --connection-timeout 90 \
  --threads $(grep -c processor /proc/cpuinfo) \
  --sort rate --save /etc/pacman.d/mirrorlist
