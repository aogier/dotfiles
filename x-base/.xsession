source .xsession.local

xset -b

#export PYTHONPATH=$HOME/dev/pythonpath

xrdb -merge ~/.Xdefaults

xscreensaver -nosplash&
/home/oggei/.local/bin/xscreensaver_events&

/usr/libexec/geoclue-2.0/demos/agent&
redshift-gtk -l geoclue2 &

nm-applet&

keepassxc ~/.local/passwords/*Passwords.kdbx &

birdtray&

dropbox start&

flameshot&

exec /usr/bin/i3
