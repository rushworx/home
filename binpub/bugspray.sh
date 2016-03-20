##
## Automatically repair artificially failing md raid arrays 
##

# formatting shit
set_red="\033[31;1m"
set_yellow="\033[33;1m"
set_green="\033[32;1m"
set_blue_lt="\033[94;1m"
set_red_bg="\033[41;1m"
color_end="\033[0m"

# count and print number of drives
QUANTITYDRIVES=$(ls /dev/sd? | sed 's/\/dev\///g' | wc -l)
printf "%s\n" "$QUANTITYDRIVES drives detected"

# create list of drives detected
DRIVELIST=$(ls /dev/sd? | sed 's/\/dev\///g')

function Get_bad_sector_count {
    smartctl -a /dev/$1|grep 'Reallocated_Sector_Ct' | awk '{print $10}'
}

# are any drives bad?
BADDRIVEFLAG=0

printf "%s\t%s\n" Drive Reallocated_Sector_Ct
printf "%s\t%s\n" ----- ---------------------
an
for drive in $DRIVELIST; do
  count=$(Get_bad_sector_count $drive)
  printf "%s\t%s\n" $drive $count
  if [ $count -gt 0 ]; then
        BADDRIVEFLAG=1
  fi
done

# list all raid devices on the system
function List_all_raid {
  RAIDLIST=$(cat /proc/mdstat | grep md| awk '{print $1}')
  for raid in $RAIDLIST; do printf "%s\t" $raid; mdadm --detail /dev/$raid |grep "State :"; done
}

# list degraded raid devices
function List_bad_raid {
  printf %b $set_red
  List_all_raid | grep degraded | awk '{print $1}'
  printf %b $color_end
}

# what partitions belong to a raid device?  
function Which_partition {
  mdadm --detail /dev/$raid | grep dev
}

function Fix_all_raid {
  echo "Fix_all_raid ..."
  for raid in `List_bad_raid`; do
        mdadm --detail /dev/$raid

        printf "Going to add partitions X Y and Z .. %bProceed? (y=yes, s=skip)%b\n" $set_yellow $color_end
        read -n1 -r key
        echo
        case "$key" in
          y)
                printf "%bFixing $raid %b\n" $set_green $color_end
                ;;
          s)
                printf "%bSkipping $raid %b\n" $set_red $color_end
                ;;
          *)
                printf "%bbad input: that's not a y or an s\n%b" $set_red_bg $color_end
                exit 1
                ;;
        esac

  done

}

if [ $BADDRIVEFLAG -gt 0 ]; then
  printf "%bBad drives detected, stopping%b\n" $set_red_bg $color_end
else
  printf "%bNo bad drives detected.  will proceed with automatically re-adding partitions to linux soft raid%b\n" $set_green $color_end
  printf "%s\n" "All raid devices:"
  List_all_raid
  printf "%s\n" "Bad raid devices:"
  List_bad_raid
  Fix_all_raid
fi




/////
/////

cat bugspray.sh 
# formatting shit
set_red="\033[31;1m"
set_yellow="\033[33;1m"
set_green="\033[32;1m"
set_blue_lt="\033[94;1m"
set_red_bg="\033[41;1m"
color_end="\033[0m"

# count and print number of drives
QUANTITYDRIVES=$(ls /dev/sd? | sed 's/\/dev\///g' | wc -l)
printf "%s\n" "$QUANTITYDRIVES drives detected"

# create list of drives detected
DRIVELIST=$(ls /dev/sd? | sed 's/\/dev\///g')

function Get_bad_sector_count {
    smartctl -a /dev/$1|grep 'Reallocated_Sector_Ct' | awk '{print $10}'
}

BADDRIVEFLAG=0

printf "%s\t%s\n" Drive Reallocated_Sector_Ct
printf "%s\t%s\n" ----- ---------------------
an
for drive in $DRIVELIST; do 
  count=$(Get_bad_sector_count $drive)
  printf "%s\t%s\n" $drive $count
  if [ $count -gt 0 ]; then
        BADDRIVEFLAG=1
  fi
done

function List_all_raid {
  RAIDLIST=$(cat /proc/mdstat | grep md| awk '{print $1}')  
  for raid in $RAIDLIST; do printf "%s\t" $raid; mdadm --detail /dev/$raid |grep "State :"; done
}

function List_bad_raid {
  printf %b $set_red
  List_all_raid | grep degraded | awk '{print $1}'
  printf %b $color_end
}
  printf %b $color_end


function Fix_all_raid {
  echo "Fix_all_raid ..."
  for raid in `List_bad_raid`; do
        mdadm --detail /dev/$raid

        printf "Going to add partitions X Y and Z .. %bProceed? (y=yes, s=skip)%b\n" $set_yellow $color_end
        read -n1 -r key
        echo
        case "$key" in
          y)
                printf "%bFixing $raid %b\n" $set_green $color_end
                ;;
          s)
                printf "%bSkipping $raid %b\n" $set_red $color_end
                ;;
          *)
                printf "%bbad input: that's not a y or an s\n%b" $set_red_bg $color_end
                exit 1
                ;;
        esac

  done

}

if [ $BADDRIVEFLAG -gt 0 ]; then
  printf "%bBad drives detected, stopping%b\n" $set_red_bg $color_end
else
  printf "%bNo bad drives detected.  will proceed with automatically re-adding partitions to linux soft raid%b\n" $set_green $color_end
  printf "%s\n" "All raid devices:"
  List_all_raid
  printf "%s\n" "Bad raid devices:"
  List_bad_raid
  Fix_all_raid
fi
