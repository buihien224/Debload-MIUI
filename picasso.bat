@echo off
CLS
cd %cd%/adb
echo wait-for-device.....
adb.exe wait-for-device >NUL 2>NUL
adb.exe devices -l 
echo 1.Install 
echo 2.Clean
CHOICE /C 12 /M "Enter your choice:"
:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 2 GOTO Clean
IF ERRORLEVEL 1 GOTO Install
:: Install rom 
:Install
echo Auto enter to recovery
adb.exe reboot recovery
adb.exe wait-for-sideload 
adb.exe devices
timeout 60
adb.exe devices
echo Go to MENU (3 lines option)
timeout 5
echo Go To ADB & Sideload
timeout 5
echo Swipe to Start Sideload
timeout 5
adb.exe devices
set /p UserInputPath=Drag your Zip file ROM, Magisk To CMD : 
adb.exe sideload %UserInputPath%
echo DONE
GOTO End

:Clean
echo  This script help you clean so many fucking miui trash app
echo  feel free to contact me via telegram 035939562
echo  Clean your phone  
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
echo  pls allow to install in your phone
echo Fuck xiaomi's trash app 
echo If you want add more app to delete
GOTO End

End 
