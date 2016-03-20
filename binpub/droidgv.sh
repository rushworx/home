#/bin/bash
vboxheadless -s droidgv
sleep 10
#rdesktop -5 -K -r clipboard:CLIPBOARD 127.0.0.1 
rdesktop 127.0.0.1:3333
