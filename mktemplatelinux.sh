codename="picasso"
bhlnk="https://github.com/buihien224/host/raw/main/dynamic1.zip"
scpt="tmp/META-INF/com/google/android/updater-script"

#####
cd ~/
mkdir BHLNK
rd=$($RANDOM)
pwd=$(pwd)
echo -e "\e[1;31mGenerate GSI Flashing Template @bhlnk \e[0m"
sleep 0.5
echo -e "\e[1;31mFor Dynamic Partition Device \e[0m"
sleep 0.5
echo -e "\e[1;31mYour Device Is $codename \e[0m"
sleep 0.5
######
if [[ -f "system.img" ]]
then
    echo -e "\e[1;31mGenerating..........\e[0m"
    systemsize=$(find "system.img" -printf "%s")
    wget -q $bhlnk 
    unzip dynamic1.zip
    rm dynamic1.zip
    echo -e "\e[1;31mCoping system.img...\e[0m"
    cp system.img tmp
    sed -i "s/test/$codename/g" $scpt 
    sed -i "s/160600/$systemsize/g" tmp/dynamic_partitions_op_list
    echo -e "\e[1;31mDONE........\e[0m"
    for dir in tmp; do
    ( cd "$dir" && zip -r ../"$codename"_flashable_"$rd".zip . )
    done
    rm -r tmp
    echo -e "\e[1;31mDone Flash "$codename"_flashable_"$rd".zip\e[0m"
    echo -e "\e[1;31mIn Custom Recovery\e[0m"
    
else 
echo
echo -e "\e[1;31mCopy system.img to\e[0m"
echo -e "\e[1;31mHome\e[0m"
echo -e "\e[1;31mThen run this script again\e[0m"
fi

#####

