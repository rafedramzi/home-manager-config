#!/bin/bash
export GBM_BACKEND=nvidia-drm
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export WLR_DRM_NO_ATOMIC=1
export WLR_NO_HARDWARE_CURSORS=1
export XDG_CURRENT_DESKTOP=sway
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0

export GBM_BACKEND=nvidia-drm
export WLR_NO_HARDWARE_CURSORS=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export WLR_DRM_NO_ATOMIC=1

#export WLR_DRM_NO_MODIFIERS=1
#export WLR_DRM_DEVICES=/dev/dri/by-path/pci-0000:05:00.0-card
export WLR_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
#export WLR_DRM_DEVICES=/dev/dri/card0
#dbus-run-session sway --unsupported-gpu
LOG_FILE=$(date +%s)
sway --unsupported-gpu --debug 2>> ~/Debug/sway/$LOG_FILE-err.log 1>> ~/Debug/sway/$LOG_FILE.log
