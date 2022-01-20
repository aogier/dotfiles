#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
    read line
    gov=`cat /sys/devices/system/cpu/*/cpufreq/scaling_governor | awk '{ printf("%s", toupper(substr($0,1,1)))} END {print ""}'`
    freq=`cpufreq-info -fm`
    turbo=`grep 1 /sys/devices/system/cpu/intel_pstate/no_turbo >/dev/null || echo ' T '`
    append='{"name":"cpufreq","instance":"main","full_text":"'"$freq [$gov]$turbo"'"},'
    echo $line | sed -r 's/\[(\{.*)/\['"$append"'\1/' || exit 1
done
