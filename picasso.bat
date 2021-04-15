echo off
cd %cd%/adb
:begin
cd %cd%/adb
echo wait-for-device.....
adb.exe wait-for-device
adb.exe devices -l 
echo Select a task:
echo =============
echo -
echo 1) INSTALL
echo 2) CLEAN
echo -
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2

echo Please Pick an option:
goto begin


:op1
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
echo FLASING                                                                                                 
adb.exe sideload %UserInputPath%
adb.exe wait-for-recovery 
CLS
echo DONE  
adb.exe reboot
goto begin

:op2
CLS
echo cleaning your phone
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
echo DONE
pause
goto begin

:exit
@exit