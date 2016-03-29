#include proprietary stuff for work, if that file exists
if [ -f /home/carl/.bashrc-work ]; then
	source /home/carl/.bashrc-work
fi

#preferred switches 
alias palemoon="palemoon -ProfileManager -new-instance"
alias mtr4="mtr -4 --report-cycles=40 --report -o LDRS NBAW"
alias mtr6="mtr -6 --report-cycles=40 --report -o LDRS NBAW"
alias rdesktop="rdesktop -g 1280x1024"

#shortcuts
alias edithosts="sudoedit /etc/hosts; sudo service dns-clean restart;"
#alias chromium-proxy="chromium-browser --proxy-server="socks5://localhost:33333""
alias nmapmail="nmap -p 110,143,993,995,25,465,587"
alias lsh="ls|head"

#functions
function pingssh { ping "$1"; ssh root@"$1"; }; export pingssh
function vpingssh { ping "$1"; vssh root@"$1"; }; export vpingssh
function fpingclean { fping -g "$1" 2>/dev/null | grep -v unreach ;}; export fpingclean

#derps
alias grpe="echo derp!"
