#!/bin/bash
# please chmod +x .sh for acquire authority
# if on linux terminal
# you should run this blew:
# $ sed 's/\r//g' sync_retail.sh > sync_retail_.sh
# so that you can covert \r\n to \n

echo "This sh will sync file to wow addons path!"
avr="this is a avr"
# echo '-------  sorce_path ------------'
source_path="/mnt/d/Github/Addons/__retail__"
# ' " `
destination_path='/mnt/d/World of Warcraft/_retail_/Interface/AddOns/'
echo ' ------ destination_path original ------- '
echo ' copy is running ... '
for desFile in `ls "$destination_path"`; do
	#statements
	echo ${desFile}
done
#cp -r -f ${source_path} "$destination_path"
for file in `ls $source_path`; do
	#statements
	echo ${file}
	cp -r -f "${source_path}/${file}" "${destination_path}/${file}"
done
echo ' ---- done ----'
