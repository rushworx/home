for admip in `cat fping`; do
	echo "administer ip=$admip , fpingip? =" `grep -Fx $admip administerips_original`;
done
