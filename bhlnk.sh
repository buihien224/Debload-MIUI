#!/bin/bash
part=(system vendor product system_ext)
module=(vietsub fonts gsm gsm_pd theme ext) 
dir=$(pwd)
bin="$dir/bin/linux"
bro="$dir/zip_temp"
chmod -R 777 $bin
chmod -R 777 $dir/bin
config=0;
getszie()
{
	part_size[0]=$(find "system.img" -printf "%s") 
	part_size[1]=$(find "vendor.img" -printf "%s")
	part_size[2]=$(find "product.img" -printf "%s")
	part_size[3]=$(find "system_ext.img" -printf "%s")
}
zipfile()
{
cd $dir
echo "#############################"
echo "#     Unpack Zip rom .... #"
echo "#############################"
mkdir zip_temp
mkdir temp
echo "Checking $zipname"
echo "Unziping $zipname"
mv $zipname zip_temp
cd zip_temp
jar xf $zipname
rm $zipname
cd ..
if [[ -f zip_temp/system.new.dat.br   ]]; then
	for ((i = 0 ; i < 4 ; i++)); do
		echo "decompress brotli : "${part[$i]}.new.dat.br" " 
		brotli --decompress zip_temp/"${part[$i]}.new.dat.br" -o zip_temp/"${part[$i]}.new.dat" > /dev/null
		echo "decompress new.dat : "${part[$i]}.new.dat" " 
		python3 ./bin/sdat2img.py zip_temp/"${part[$i]}.transfer.list" zip_temp/"${part[$i]}.new.dat" "${part[$i]}.img" > /dev/null
		echo "extract to "${part[$i]}.img" : done"
	done
	getszie
	if [[ -f "$bro/dynamic_partitions_op_list" ]]; then
		for ((i = 0 ; i < 4 ; i++)); do
		echo "Getting "${part[$i]}.img" size "
		sed -i "s/${part_size[$i]}/"${part[$i]}_size"/g" "$bro/dynamic_partitions_op_list"
		done
	fi
	config=1
elif [[ -f zip_temp/payload.bin ]]; then
		cp "$dir/bin/payload_dumper.py" zip_temp
		cp "$dir/bin/update_metadata_pb2.py" zip_temp
		cd zip_temp
		python3 payload_dumper.py payload.bin
		for ((i = 0 ; i < 4 ; i++)); do
			mv "${part[$i]}.img" $dir
		done
		cd ..
		rm zip_temp/payload_dumper.py
		rm zip_temp/update_metadata_pb2.py
		config=2
else 
	echo "Type Rom is Not Support Yet !"
	exit
fi
	
}
######################
mkrw()
{
cd $dir
echo "#############################"
echo "#       READ-WRITE ....     #"
echo "#############################"
echo ""
echo "Get Parttion size ...."
echo ""
getszie
echo "Resize Parttion ...."
for ((i = 0 ; i < 4 ; i++)); do
	size=$(echo "${part_size[$i]} + 50000000" | bc)
	size1=$(echo "$size / 1024" | bc)
	echo "new "${part[$i]}.img" is : $size" > /dev/null
	e2fsck -f "${part[$i]}.img" > /dev/null
	resize2fs "${part[$i]}.img" $size1 > /dev/null
	echo "${part[$i]}.img done"
done
echo ""
echo "Start remove Read-Only ...."
for ((i = 0 ; i < 4 ; i++)); do
	e2fsck -y -E unshare_blocks "${part[$i]}.img" > /dev/null
	echo ""${part[$i]}.img" : done"
done
}
##########
mount()
{
mkdir temp > /dev/null
echo "#############################"
echo "#        Mounting ....      #"
echo "#############################"
echo ""
echo "Enter your password to use Sudo ...."
for ((i = 0 ; i < 4 ; i++)); do
	mkdir temp/"${part[$i]}"
	sudo mount "${part[$i]}.img" temp/"${part[$i]}"
done
}
########
debloat()
{
cd $dir
echo "#############################"
echo "#       Debloating ....     #"
echo "#############################"
echo ""
echo "Debloating ...."
###########
sys=`cat $dir/module/debloat/system.txt`
ven=`cat $dir/module/debloat/vendor.txt`
pro=`cat $dir/module/debloat/product.txt`
ext=`cat $dir/module/debloat/system_ext.txt`
echo "In System : "
cd $dir/temp/system/system
  for app in $sys; do
        sudo rm -rf "$app" > /dev/null
  done
echo Done
echo "In Vendor : "
cd $dir/temp/vendor
  for app in $ven; do
        sudo rm -rf "$app" > /dev/null
  done
echo Done
echo "In Product : "
cd $dir/temp/product
  for app in $pro; do
        sudo rm -rf "$app" > /dev/null
  done
echo Done
echo "In System_ext : "
cd $dir/temp/system_ext
  for app in $ext; do
        sudo rm -rf "$app" > /dev/null
  done
echo Done
}
#########
#########
umount()
{
echo "#############################"
echo "#        Unmounting ....    #"
echo "#############################"
echo ""
cd $dir/temp
sleep 3
for ((i = 0 ; i < 4 ; i++)); do
	sudo umount "${part[$i]}"
	echo "Umount "${part[$i]}" :  done"
	sleep 3
done
}
##########
shrink ()
{
echo "#############################"
echo "#        Shrinking ....     #"
echo "#############################"
echo ""
cd $dir
sleep 1
for ((i = 0 ; i < 4 ; i++)); do
	resize2fs -f -M "${part[$i]}.img" > /dev/null
	echo "Shrink "${part[$i]}" :  done"
done
cd $dir
getszie
echo "Writing new size to dynamic_partitions_op_list"
if [[ -f "$bro/dynamic_partitions_op_list" ]]; then
	for ((i = 0 ; i < 4 ; i++)); do
	sed -i "s/"${part[$i]}_size"/"${part_size[$i]}"/g" "$bro/dynamic_partitions_op_list"
	done
fi
}
cleanup()
{
	cd $dir
	if [[ -d "temp" ]]; then
		rm -r temp
		rm -r zip_temp
	fi
}
remove_source()
{
echo "#############################"
echo "#  remove source file ....  #"
echo "#############################"
echo ""
cd $dir/zip_temp
if [[ -f "system.new.dat.br" ]]; then
	rm firmware-update/vbmeta.img
	for ((i = 0 ; i < 4 ; i++)); do
		if [[ -f "${part[$i]}.new.dat.br" ]]; then
			rm "${part[$i]}.new.dat.br"
			rm "${part[$i]}.new.dat"
			rm "${part[$i]}.patch.dat"
			rm "${part[$i]}.transfer.list"
		fi
	done
fi
cd ..
}
repackz()
{
cd $dir
echo "#############################"
echo "#         Compress          #"
echo "#############################"
echo ""
echo "Compress to sparse img .... "
if [[ config -eq 2 ]]; then
	echo "making flashable file for A/B"
	for ((i = 0 ; i < 4 ; i++)); do
  echo "Compress "${part[$i]}.img" "
	img2simg "${part[$i]}.img" "s_${part[$i]}.img" > /dev/null
	rm -rf "${part[$i]}.img" ; mv "s_${part[$i]}.img" "${part[$i]}.img"
	done
elif [[ config -eq 1 ]]; then
	for ((i = 0 ; i < 4 ; i++)); do
  echo "Compress "${part[$i]}.img" "
	img2simg "${part[$i]}.img" "s_${part[$i]}.img" > /dev/null
	rm -rf "${part[$i]}.img"
	done
	echo "Compress to new.dat .... "
	for ((i = 0 ; i < 4 ; i++)); do
	echo "- Repack ${part[$i]}.img"
 	python3 ./bin/linux/img2sdat.py "s_${part[$i]}.img" -o $bro -v 4 -p "${part[$i]}" > /dev/null
 	rm -rf "s_${part[$i]}.img"
	done

#level brotli
	echo "Compress to brotli .... "
#
	for ((i = 0 ; i < 4 ; i++)); do
  	 echo "- Repack ${part[$i]}.new.dat"
		brotli -7 -j -w 24 "$bro/${part[$i]}.new.dat" -o "$bro/${part[$i]}.new.dat.br" 
		rm -rf "$bro/${part[$i]}.new.dat"
	done
	if [ -d $bro/META-INF ]; then
		echo "- Zipping"
		cp "$dir/bin/vbmeta.img" $bro
		7za a -tzip "$dir/debloat_$zipname" $bro/*  
	fi
	if [ -f "$dir/debloat_$zipname" ]; then
      echo "- Repack done"
	else
      echo "- Repack error"
	fi
else echo "no file to repack"
fi

}
cd $dir
cleanup
echo "#############################"
echo "#         STARTING ....     #"
echo "#############################"
echo ""
if [[ -f "$(ls *.img 2>/dev/null)" ]]; then
	echo "Super Parttion Detect"
	superimg
	mkrw
	mount
	debloat
	vietsub
	buildprop
	umount
	shrink
	repack_super
elif [[ -f "$(ls *.zip 2>/dev/null)" ]]; then
	zipname=$(ls *.zip)
	echo "$zipname detect"
	zipfile
	mkrw
	mount
	debloat
	umount
	shrink
	remove_source
	repackz
else exit 0
fi
#
