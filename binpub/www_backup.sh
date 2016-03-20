#/bin/bash

##
##	simple backup script to create .tar.gz of website and make it availalbe
##	for download by client.
##

##=================================================================================
## need to verify i'm using nice / ionice correctly before relying on this script
##
## check ionice priority:
## ionice -p `pidof /bin/tar`
## ionice -p PID
##
## check nice priority:
## ps -eo nice,command | grep /bin/tar
## 


#ionice -c 2 -n 7 /bin/tar -czvf /home/DOMAIN-TICKET.tar.gz /home/admin/sites/DOMAIN/
#chmod 644 /home/DOMAIN-TICKET.tar.gz
#mv /home/DOMAIN-TICKET.tar.gz /home/admin/sites/DOMAIN/

# --- SITES PATH ---
# for MG, sites are located in /home/admin/sites
SITESPATH=/home/admin/sites

function usage {
	echo "
mg_backup.sh:
	tars up \$DOMAIN w/ file name \$DOMAIN-\$TICKET-YYYY-MM-DD.tar.gz and sticks it
	in $SITESPATH/\$DOMAIN for download. does so with nice / 
	ionice so machine doesn't bog down. 

Usage:
	./mg_backup.sh \$DOMAIN \$TICKET 
	./mg_backup.sh website.com ABC-12345
	
	C Macmillan 2014 9 25
	updated: 10/20"
}



if [ $1 ] & [ $2 ]; then
	echo "\$DOMAIN= "$1 \$TICKET= "$2"
	nice -n19 ionice -c 2 -n 7 /bin/tar -czvf /home/$1-$2-`date +%F`.tar.gz /home/admin/sites/$1/
	chmod 644 /home/$1-$2.tar.gz
	mv /home/$1-$2.tar.gz $SITESPATH/$1/
else
	usage
fi
