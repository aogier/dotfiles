#!/bin/sh

val=$(xrandr --query | awk '/^DisplayPort-1/ {split($3,a, "+"); print a[3]}')

case "$1" in
    up)
        xrandr --output DisplayPort-1 --pos 0x$((val + 1))
        ;;
    down)
        xrandr --output DisplayPort-1 --pos 0x$((val - 1))
        ;;
esac
