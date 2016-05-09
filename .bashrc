if [ -f /home/carl/work/bashrc-work ]; then	source /home/carl/.bashrc-work; fi
if [ -f /home/carl/.bashrc-priv ]; then	source /home/carl/.bashrc-priv; fi

alias node="nodejs"

#---- preferred switches ----
alias palemoon="palemoon -new-instance"
alias mtr4="mtr -4 --report-cycles=40 --report-wide -o LDRS NBAW"
alias mtr6="mtr -6 --report-cycles=40 --report-wide -o LDRS NBAW"
alias rdesktop="rdesktop -g 1280x1024"
alias thunderbird="thunderbird --profilemanager --new-instance"

#---- shortcuts ----
alias edithosts="sudoedit /etc/hosts; sudo service dns-clean restart;"
#alias chromium-proxy="chromium-browser --proxy-server="socks5://localhost:33333""
alias nmapmail="nmap -p 110,143,993,995,25,465,587"
alias lsh="ls|head"

#---- functions ----
function pingrssh { ping "$1"; ssh root@"$1"; }; export pingssh
function pingvssh { ping "$1"; vssh root@"$1"; }; export vpingssh
function fpingclean { fping -g "$1" 2>/dev/null | grep -v unreach ;}; export fpingclean
#function whois { whois "$1" | less; }; export whois

#----	path ----
PATH=$PATH:~/binpub/
if [ -d /home/carl/binwork ]; then PATH=$PATH:~/binwork/; fi
if [ -d /home/carl/binpriv ]; then PATH=$PATH:~/binpriv/; fi

#---- derps ----
# apt-get install sl
alias grpe="echo derp!"
alias yum="while true; do sl; done"

#---- Base16 Shell ----
#BASE16_SHELL="$HOME/binpub/base16-default.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
