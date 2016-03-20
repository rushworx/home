#/bin/bash
# Carl Macmillan 2014 10 14
# Updated 10/15
##
##	migrates KVM virutal machine
##

DESTINATION="$2"
VMID="VMID$1"

echo "Usage: ./migrate_vm.sh \$VMID \$DESTINATION";
echo -e "Migrating $VMID to $DESTINATION\n";

echo "1. SSH key"

# do we have a pub key?
pubkey="/root/.ssh/id_rsa.pub"
if [ -e "$pubkey" ]
then
  echo -e "\e[0;34m*** $pubkey exists.\e[0m"
else
  echo -e "\e[0;34m*** $pubkey NOT FOUND! generating ssh keys...\e[0m"
#  ssh-keygen
fi

# firewall -  get our IP so we can print a convenient iptables command
myip=`ip addr show br0 scope global | grep inet | sed 's/\/[^/]*$//' | sed 's/.* //'`

echo -e "\n2. firewall - run the following on $DESTINATION:\n---------------------------------------\n\niptables -I INPUT 1 -s $myip -j ACCEPT\n\n---------------------------------------\nenter to continue..."
read unusedVariable

echo -e "\e[0;34m*** copying ssh key to $DESTINATION...\e[0m"
ssh-copy-id root@$DESTINATION
#todo: add some tests to verify successful ssh connection

echo -e "3. migration\n\e[0;34m*** creating lv on $DESTINATION\e[0m"
ssh $DESTINATION "lvcreate vg --name $VMID --size `lvdisplay /dev/vg/$VMID | grep Size | sed 's/\..*$//' | sed 's/[^0-9]*//g'`G"

echo -e "3. \e[0;33mBegin migration of $VMID to $DESTINATION? enter to start...\e[0m"
read unusedVariable
echo -e "\e[0;34m*** Starting virsh migrate ...\e[0m"
virsh migrate --verbose --live --persistent --copy-storage-all --auto-converge $VMID qemu+ssh://$DESTINATION/system
#todo: add some sort of progress bar / disk usage monitoring or some kind of indicator that it's working or not. 

echo -e "\n3.\e[0;36m In database:\e[0m migrate $VMID from `hostname -s` to $DESTINATION.\nTest $VMID on $DESTINATION. If it works, you can remove $VMID from $HOSTNAME in the next step\nenter to continue..."
read unusedVariable

echo -e "4. removal\n\e[0;33mRemove $VMID from $HOSTNAME?\e[0;31m type x to remove,\e[0;33m anything else to quit\e[0m"
read remove

if [ $remove = "x" ]
then
  echo -e "\e[0;31m*** removing $VMID\e[0m"
  virsh undefine $VMID; lvremove /dev/vg/$VMID
else
  echo "quitting"
fi
