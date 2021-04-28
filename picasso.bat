@echo off
CLS
cd %cd%/adb
echo wait-for-device.....
adb.exe wait-for-device >NUL 2>NUL
adb.exe devices -l 
echo 1.Install 
echo 2.Clean
echo 3.GBoard
CHOICE /C 123 /M "Enter your choice:"
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 3 GOTO GBoard
IF ERRORLEVEL 2 GOTO Clean
IF ERRORLEVEL 1 GOTO Install
:: Install rom 
:Install
echo Auto enter to recovery
adb.exe reboot recovery
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
echo #######################################
echo FFFFFFF LL        AAA    SSSSS  HH   HH
echo FF      LL       AAAAA  SS      HH   HH
echo FFFF    LL      AA   AA  SSSSS  HHHHHHH
echo FF      LL      AAAAAAA      SS HH   HH
echo FF      LLLLLLL AA   AA  SSSSS  HH   HH   
echo #######################################                                                                                            
adb.exe sideload %UserInputPath%
adb.exe wait-for-recovery 
CLS
echo ###############################
echo DDDDD    OOOOO  NN   NN EEEEEEE
echo DD  DD  OO   OO NNN  NN EE     
echo DD   DD OO   OO NN N NN EEEEE  
echo DD   DD OO   OO NN  NNN EE     
echo DDDDDD   OOOO0  NN   NN EEEEEEE
echo ###############################
adb.exe reboot
pause
GOTO End


:Clean
echo #######################################
echo  CCCCC  LL      EEEEEEE   AAA   NN   NN
echo CC    C LL      EE       AAAAA  NNN  NN
echo CC      LL      EEEEE   AA   AA NN N NN
echo CC    C LL      EE      AAAAAAA NN  NNN
echo  CCCCC  LLLLLLL EEEEEEE AA   AA NN   NN
echo #######################################
echo.
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
echo ###############################
echo DDDDD    OOOOO  NN   NN EEEEEEE
echo DD  DD  OO   OO NNN  NN EE     
echo DD   DD OO   OO NN N NN EEEEE  
echo DD   DD OO   OO NN  NNN EE     
echo DDDDDD   OOOO0  NN   NN EEEEEEE
echo ###############################  
pause
GOTO End

:GBoard
echo install GBoard
adb.exe install gb.apk
GOTO End


End 
