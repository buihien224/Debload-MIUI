@echo off
CLS
cd %cd%/adb
echo wait-for-device.....
adb.exe wait-for-device
adb.exe devices -l 
ECHO 1. Install
ECHO 2. Clean
set choice=
set /p choice=Type the number to do.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Install
if '%choice%'=='2' goto Clean
ECHO "%choice%" is not valid, try again
:: Install rom 
:Install
CLS
echo Auto enter to recovery
adb.exe reboot recovery
echo rebooting .......
adb.exe wait-for-recovery
CLS
echo ##################################
echo #      Now in recovery mode      #
echo #   Go to MENU (3 lines option)  #
echo #     Go To ADB , Sideload       #
echo #    Swipe to Start Sideload     #
echo ##################################
adb.exe wait-for-sideload
set /p UserInputPath=Drag your Zip file ROM, Magisk To CMD : 
echo ##################################################################
echo #		______ _       ___   _____ _   _ _____ _   _ _____        #
echo #		|  ___| |     / _ \ /  ___| | | |_   _| \ | |  __ \		  #
echo #		| |_  | |    / /_\ \\ `--.| |_| | | | |  \| | |  \/       #
echo #		|  _| | |    |  _  | `--. \  _  | | | | . ` | | __        #
echo #		| |   | |____| | | |/\__/ / | | |_| |_| |\  | |_\ \       #
echo #		\_|   \_____/\_| |_/\____/\_| |_/\___/\_| \_/\____/       #
echo # 																  #
echo ##################################################################                                                                                                  
adb.exe sideload %UserInputPath%
adb.exe wait-for-recovery 
CLS
echo ###############################################################
echo #                 .-'''-.                                     #          
echo #_______         '   _    \                                   #        
echo #\  ___ `'.    /   /` '.   \    _..._         __.....__       #        
echo # ' |--.\  \  .   |     \  '  .'     '.   .-''         '.     #        
echo # | |    \  ' |   '      |  '.   .-.   . /     .-''"'-.  `.   #        
echo # | |     |  '\    \     / / |  '   '  |/     /________\   \  #        
echo # | |     |  | `.   ` ..' /  |  |   |  ||                  |  #        
echo # | |     ' .'    '-...-'`   |  |   |  |\    .-------------'  #        
echo # | |___.' /'                |  |   |  | \    '-.____...---.  #        
echo #/_______.'/                 |  |   |  |  `.             .'   #        
echo #\_______|/                  |  |   |  |    `''-...... -'     #        
echo #                            |  |   |  |                      #        
echo #                            '--'   '--'                      #        
echo ###############################################################   
adb.exe reboot
GOTO End


:Clean
CLS
echo  ________  ___       _______   ________  ________      
echo |\   ____\|\  \     |\  ___ \ |\   __  \|\   ___  \    
echo \ \  \___|\ \  \    \ \   __/|\ \  \|\  \ \  \\ \  \   
echo  \ \  \    \ \  \    \ \  \_|/_\ \   __  \ \  \\ \  \  
echo   \ \  \____\ \  \____\ \  \_|\ \ \  \ \  \ \  \\ \  \ 
echo    \ \_______\ \_______\ \_______\ \__\ \__\ \__\\ \__\
echo     \|_______|\|_______|\|_______|\|__|\|__|\|__| \|__|
echo
echo  
adb.exe shell pm uninstall -k --user 0 com.zhihu.android
adb.exe shell pm uninstall -k --user 0 com.xiaomi.jr 
adb.exe shell pm uninstall -k --user 0 com.ss.android.article.news
adb.exe shell pm uninstall -k --user 0 com.taobao.taobao
adb.exe shell pm uninstall -k --user 0 com.duokan.free
adb.exe shell pm uninstall -k --user 0 com.dragon.read
adb.exe shell pm uninstall -k --user 0 com.eg.android.AlipayGphone
adb.exe shell pm uninstall -k --user 0 com.xiaomi.youpin
adb.exe shell pm uninstall -k --user 0 com.xiaomi.vipaccount
adb.exe shell pm uninstall -k --user 0 com.miui.miservice
adb.exe shell pm uninstall -k --user 0 com.xiaomi.smarthome
adb.exe shell pm uninstall -k --user 0 com.mipay.wallet
adb.exe shell pm uninstall -k --user 0 com.xiaomi.gamecenter
adb.exe shell pm uninstall -k --user 0 com.xiaomi.shop
adb.exe shell pm uninstall -k --user 0 com.miui.voiceassist
adb.exe shell pm uninstall -k --user 0 com.android.email
adb.exe shell pm uninstall -k --user 0 com.miui.huanji
adb.exe shell pm uninstall -k --user 0 com.miui.virtualsim
adb.exe shell pm uninstall -k --user 0 com.mi.health
adb.exe shell pm uninstall -k --user 0 com.android.browser
adb.exe shell pm uninstall -k --user 0 com.iflytek.inputmethod.miui
adb.exe shell pm uninstall -k --user 0 com.baidu.input_mi
adb.exe shell pm uninstall -k --user 0 com.miui.newhome
adb.exe shell pm uninstall -k --user 0 com.xiaomi.payment
adb.exe shell pm uninstall -k --user 0 com.miui.newmidrive
adb.exe shell pm uninstall -k --user 0 com.mi.live.assistant
adb.exe shell pm uninstall -k --user 0 com.sohu.inputmethod.sogou.xiaomi
adb.exe shell pm uninstall -k --user 0 com.miui.smarttravel
adb.exe shell pm uninstall -k --user 0 com.unionpay.tsmservice.mi
echo downloading gboard
powershell -Command "Invoke-WebRequest https://download1583.mediafire.com/theszju94f8g/vd16wqk7xddw3p2/Gboard+the+Google+Keyboard_v10.3.05.356487417-release-arm64-v8a_apkpure.com.apk  -Outfile gb.apk"
adb install gb.apk
CLS
echo ###############################################################
echo #                 .-'''-.                                     #          
echo #_______         '   _    \                                   #        
echo #\  ___ `'.    /   /` '.   \    _..._         __.....__       #        
echo # ' |--.\  \  .   |     \  '  .'     '.   .-''         '.     #        
echo # | |    \  ' |   '      |  '.   .-.   . /     .-''"'-.  `.   #        
echo # | |     |  '\    \     / / |  '   '  |/     /________\   \  #        
echo # | |     |  | `.   ` ..' /  |  |   |  ||                  |  #        
echo # | |     ' .'    '-...-'`   |  |   |  |\    .-------------'  #        
echo # | |___.' /'                |  |   |  | \    '-.____...---.  #        
echo #/_______.'/                 |  |   |  |  `.             .'   #        
echo #\_______|/                  |  |   |  |    `''-...... -'     #        
echo #                            |  |   |  |                      #        
echo #                            '--'   '--'                      #        
echo ###############################################################   
GOTO End



End 
